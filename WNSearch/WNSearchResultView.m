//
//  WNSearchResultView.m
//  HongTu
//
//  Created by weinee on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "WNSearchResultView.h"
#import "UIView+SDAutoLayout.h"
#import "NDSearchTool.h"
#import "PersDetailModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "ConListCell.h"
#import "XYString.h"

#define OFFSET 50
#define ANIMATEDURATION 0.3
#define NavigateHegth 64

@interface WNSearchResultView ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIGestureRecognizerDelegate>
@property (nonatomic, assign, getter=isShown) BOOL shown;

//自定义单元格
@property (nonatomic, assign) Class tableCellClass;
@property (nonatomic, copy) NSString *modelKeyPath;

//searchBar的内容视图
@property (nonatomic, strong) UIView *searchContent;
@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, weak) UISearchBar* originSearchBar;
@property (nonatomic, strong) UISearchBar* searchBar;

//searchBar所在的controller
@property (nonatomic, weak) UIViewController* contentViewController;

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, weak) NSArray* datasource;
@property (nonatomic, strong) NSMutableArray* searchResult;// 搜索结果

@end

static NSString *CellID = @"SearchCell";
@implementation WNSearchResultView

- (instancetype)initWithSearchBar:(UISearchBar *)searchBar dateSource:(NSArray *)datasource contentController:(UIViewController *)viewController
{
	self = [super init];
	if (self) {
		_shown = NO;
		
		_hidenNavigationBar = YES;
		
		_datasource = datasource;
		
		_originSearchBar = searchBar;
		self.searchBar.searchBarStyle = searchBar.searchBarStyle;
		self.searchBar.placeholder = searchBar.placeholder;
		[[self.searchBar valueForKey:@"_cancelButton"] setTitle:@"取消"];

		//给原来的searchBar添加点击手势
		UIView *searchCoverView = [[UIView alloc] initWithFrame:searchBar.frame];
		searchCoverView.backgroundColor = [UIColor clearColor];
		[searchBar.superview addSubview:searchCoverView];
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(triggerShow:)];
		tap.delegate = self;
		[searchCoverView addGestureRecognizer:tap];
		
		//传入viewController
		_contentViewController = viewController;
		
	}
	return self;
}

-(void)setCellClass:(Class)tableCellClass andModelKeyPath:(NSString *)modelKeyPath{
	_tableCellClass = tableCellClass;
	_modelKeyPath = modelKeyPath;
	//注册单元格
	[self.tableView registerClass:_tableCellClass forCellReuseIdentifier:CellID];
}

/**
 *  默认方式显示
 */
-(void)show{
	//布局
	[self doLayoutSubView];
	
	self.shown = YES;
	[self.originSearchBar becomeFirstResponder];//先让原来的searchBar作为第一响应者，可以看到动画效果
	
	if (self.isHidenNavigationBar) {
		self.frame = _contentViewController.view.frame;
		//隐藏navigationBar
		[_contentViewController.navigationController setNavigationBarHidden:YES animated:YES];
	} else{
		self.frame = CGRectMake(0, NavigateHegth, _contentViewController.view.frame.size.width, _contentViewController.view.frame.size.height - NavigateHegth);
	}
	
	self.alpha = 0;
	[_contentViewController.view addSubview:self];
	
	//	searchBar 上移动画, 渐显动画
	[UIView animateWithDuration:ANIMATEDURATION animations:^{
		self.originSearchBar.transform = CGAffineTransformMakeTranslation(self.originSearchBar.frame.origin.x, self.originSearchBar.frame.origin.y - OFFSET);
		//动画显示
		self.alpha = 1;
	} completion:^(BOOL finished) {
		// 动画结束后，从父视图隐藏
		self.originSearchBar.hidden = YES;
		//让现在使用的searchBar成为第一响应者
		[self.searchBar becomeFirstResponder];
	}];

}

-(void)showInView:(UIView *)view edge:(UIEdgeInsets)edge{
	//修改fram
	
	self.hidden = 0;
	[view addSubview:self];
	//动画显示
	self.hidden = 1;
}

/** 移除*/
-(void) remove{
	self.shown = NO;
	//隐藏tableView
	self.tableView.hidden = YES;
	if (self.isHidenNavigationBar) {
		[self.contentViewController.navigationController setNavigationBarHidden:NO animated:YES];
	}
	
	self.originSearchBar.hidden = NO;
	[UIView animateWithDuration:ANIMATEDURATION animations:^{
		//原来的searchBar恢复到原来的位置
		self.originSearchBar.transform = CGAffineTransformIdentity;
	}];
	[self removeFromSuperview];
	
}

/** 布局视图*/
-(void)doLayoutSubView{
	self.searchContent.sd_layout
	.topSpaceToView(self, _hidenNavigationBar ? 20 : 0)
	.leftEqualToView(self)
	.rightEqualToView(self)
	.heightIs(44);
	
	self.coverView.sd_layout
	.topSpaceToView(self.searchContent, 0)
	.leftEqualToView(self)
	.rightEqualToView(self)
	.bottomEqualToView(self);
	
	self.tableView.sd_layout
	.topSpaceToView(self.searchContent, 0)
	.leftEqualToView(self)
	.rightEqualToView(self)
	.bottomEqualToView(self);
	
	self.searchBar.sd_layout
	.topSpaceToView(self.searchContent, 6)
	.leftEqualToView(self.searchContent)
	.rightEqualToView(self.searchContent)
	.bottomEqualToView(self.searchContent);
	
}
#pragma mark 手势触发
-(void)triggerShow:(UIGestureRecognizer *)gesture{
	if ([XYString isBlankString:NSStringFromClass(self.tableCellClass)] || [XYString isBlankString:self.modelKeyPath]) {
		NSAssert(NO, @"必须设置cell的类和模型在自定义cell中的keypath");
		return;
	}
	[self show];
}

#pragma mark UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	if (searchText == nil || [@"" isEqualToString:searchText]) {
		self.tableView.hidden = YES;
		return;
	}
	//进行搜索
	if (self.tableView.hidden && (searchText != nil && ![@"" isEqualToString:searchText])) {
		//显示tableView
		self.tableView.hidden = NO;
	}
	self.searchResult = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"displayname", @"displayname_quanpinFirst"] inputString:searchText inArray:self.datasource];
	[self.tableView reloadData];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
	NSString* searchText = searchBar.text;
	if (searchText == nil || [@"" isEqualToString:searchText]) {
		self.tableView.hidden = YES;
		return;
	}
	//进行搜索
	if (self.tableView.hidden && (searchText != nil && ![@"" isEqualToString:searchText])) {
		//显示tableView
		self.tableView.hidden = NO;
	}
	self.searchResult = (NSMutableArray *)[[NDSearchTool tool] searchWithFieldArray:@[@"displayname", @"displayname_quanpinFirst"] inputString:searchText inArray:self.datasource];
	[self.tableView reloadData];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
	[self remove];
}


-(PersDetailModel *) getSearchCellModel:(NSIndexPath *) indexPath{
	return self.searchResult[indexPath.row];
}
#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.searchResult.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//获取model
	PersDetailModel *model;
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
	model = [self getSearchCellModel:indexPath];
	[cell setValue:model forKey:_modelKeyPath];
	// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅
	cell.sd_tableView = tableView;
	cell.sd_indexPath = indexPath;
	return cell;
}

#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	//判断当前选择的行在，searchDatasource中的下标, 并调用代理方法
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if ([self.delegate respondsToSelector:@selector(selectedAtIndex:)]) {
		[self remove];
		[self.delegate selectedAtIndex:[self.datasource indexOfObject:[self getSearchCellModel:indexPath]]];
	}
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	Class currentClass = [ConListCell class];
	
	PersDetailModel *model;
	model = [self getSearchCellModel:indexPath];
	return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
}

/** SDAutolayout适配ios7 的方法*/
- (CGFloat)cellContentViewWith
{
	CGFloat width = [UIScreen mainScreen].bounds.size.width;
	// 适配ios7
	if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
		width = [UIScreen mainScreen].bounds.size.height;
	}
	return width;
}
#pragma mark UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
	if (self.isShown) {
		return NO;
	}
	return YES;
}

#pragma mark 视图懒加载
-(UITableView *)tableView{
	if (_tableView) {
		return _tableView;
	}
	_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	_tableView.hidden = YES;
	[self addSubview:_tableView];
	return _tableView;
}

-(UIView *)coverView{
	if (_coverView) {
		return _coverView;
	}
	_coverView = [[UIView alloc] init];
	_coverView.backgroundColor = [UIColor blackColor];
	_coverView.alpha = 0.2;
	[self addSubview:_coverView];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remove)];
	[_coverView addGestureRecognizer:tap];
	[self sendSubviewToBack:_coverView];
	return _coverView;
}

-(UISearchBar *)searchBar{
	if (_searchBar) {
		return _searchBar;
	}
	_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
	_searchBar.delegate = self;
	_searchBar.showsCancelButton = YES;
	[self.searchContent addSubview:self.searchBar];
	return _searchBar;
}

-(UIView *)searchContent{
	if (_searchContent) {
		return _searchContent;
	}
	_searchContent = [[UIView alloc] init];
	_searchContent.backgroundColor = [UIColor whiteColor];
	[self addSubview:_searchContent];
	return _searchContent;
}

#pragma mark dealloc
-(void)dealloc{
	self.modelKeyPath = nil;
	self.searchContent = nil;
	self.coverView = nil;
	self.searchBar = nil;
	self.tableView = nil;
	self.searchResult = nil;
}

@end
