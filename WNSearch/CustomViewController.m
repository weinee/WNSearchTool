//
//  AddressViewController.m
//  HongTu
//
//  Created by sunshine on 16/3/17.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CustomViewController.h"
#import "UIView+SDAutoLayout.h"
#import "ConListCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "PersDetailModel.h"
#import "WNSearchResultView.h"
#import "CommonTools.h"

@interface CustomViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, WNSearchResultViewDelegate>
@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NSMutableDictionary *modelDic;
@property (strong, nonatomic) NSArray *modelsKey;//一个key对应一个section的model

@property (strong, nonatomic) WNSearchResultView * searchDisplay;
@property (strong, nonatomic) NSMutableArray *searchDatasource;
@property (strong, nonatomic) NSMutableArray *searchResult;

@property (strong, nonatomic) UISearchBar *searchBar;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//	self.searchBar.delegate = self;
  
  [self setTitle:@"通讯录"];
	self.view.backgroundColor = [UIColor colorWithRed:102 green:102 blue:102 alpha:1];
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	UIView *header = [[UIView alloc] initWithFrame:self.searchBar.frame];
	[header addSubview:self.searchBar];
	self.tableView.tableHeaderView = header;
	
	//设置分区索引样式
	self.tableView.sectionIndexBackgroundColor = kColorClear;
	self.tableView.sectionIndexColor = kColorTextDetail;

	//注册单元格
	[self.tableView registerClass:[ConListCell class] forCellReuseIdentifier:NSStringFromClass([ConListCell class])];
	
	//创建搜索
	self.searchDisplay = [[WNSearchResultView alloc] initWithSearchBar:self.searchBar dateSource:self.searchDatasource contentController:self];
//	[self.searchDisplay setCellClass:[ConListCell class] andModelKeyPath:@"model"];//添加单元格和模型keypath
	[self.searchDisplay setCellClass:[ConListCell class] andModelKeyPath:@"model" searchField:@[@"displayname"]];
//	_searchDisplay.hidenNavigationBar = NO;
	self.searchDisplay.delegate = self;
//	self.searchDisplay = nil;
	//布局视图
	self.tableView.sd_layout
	.topSpaceToView(self.view, NAVHEIGHT + STAUSHEIGHT)
	.leftEqualToView(self.view)
	.rightEqualToView(self.view)
	.bottomSpaceToView(self.view, 0);

}

#pragma mark getter and setter
-(NSMutableDictionary *)modelDic{//构造假数据
	if (!_modelDic) {
		_modelDic = [CommonTools getDicByUserModelArray:self.searchDatasource];	
	}
	return _modelDic;
}
-(NSArray *)modelsKey{
	if (!_modelsKey) {
		NSMutableArray *mArr = [[self.modelDic.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString* obj1, NSString* obj2) {
			return [obj1 compare:obj2];
		}] mutableCopy];
		
		NSString *first = mArr[0];
		if ([@"#" isEqualToString:first]) {
			[mArr removeObjectAtIndex:0];
			[mArr addObject:first];
		}
		
		_modelsKey = [mArr copy];
		
	}
	return _modelsKey;
}
//TODO: 根据API重构，结合 modelDic
-(NSMutableArray *)searchDatasource{
	if (_searchDatasource) {
		return _searchDatasource;
	}
	_searchDatasource = [NSMutableArray array];
	
	PersDetailModel *model1 = [[PersDetailModel alloc] init];
	model1.displayname = @"微溺";
	model1.detail = @"detail111111";
	model1.jobnum = @"120903023101";
	model1.department = @"department1";
	model1.avatar = @"header";
	[_searchDatasource addObject: model1];
	PersDetailModel *model2 = [[PersDetailModel alloc] init];
	model2.displayname = @"aeinee2";
	model2.detail = @"detail111112";
	model2.jobnum = @"120903023102";
	model2.department = @"department2";
	model2.avatar = @"header";
	[_searchDatasource addObject: model2];
	PersDetailModel *model3 = [[PersDetailModel alloc] init];
	model3.displayname = @"人einee3";
	model3.detail = @"detail111113";
	model3.jobnum = @"120903023104";
	model3.department = @"department3";
	model3.avatar = @"header";
	[_searchDatasource addObject: model3];
	
	PersDetailModel *model4 = [[PersDetailModel alloc] init];
	model4.displayname = @"wdinee1";
	model4.detail = @"个人简介1";
	model4.jobnum = @"120903023101";
	model4.department = @"department4";
	model4.avatar = @"header";
	[_searchDatasource addObject: model4];
	
	PersDetailModel *model5 = [[PersDetailModel alloc] init];
	model5.displayname = @"可以";
	model5.detail = @"detail111112";
	model5.jobnum = @"120903023102";
	model5.department = @"department5";
	model5.avatar = @"header";
	[_searchDatasource addObject: model5];
	PersDetailModel *model6 = [[PersDetailModel alloc] init];
	model6.displayname = @"keinee3";
	model6.detail = @"detail111113";
	model6.jobnum = @"120903023104";
	model6.avatar = @"header";
	[_searchDatasource addObject: model6];
	
	PersDetailModel *model7 = [[PersDetailModel alloc] init];
	model7.displayname = @"wcinee1";
	model7.detail = @"detail111111";
	model7.jobnum = @"120903023101";
	model7.avatar = @"header";
	[_searchDatasource addObject: model7];
	
	PersDetailModel *model8 = [[PersDetailModel alloc] init];
	model8.displayname = @"$einee2";
	model8.detail = @"detail111112";
	model8.jobnum = @"120903023102";
	model8.avatar = @"header";
	[_searchDatasource addObject: model8];
	
	PersDetailModel *model9 = [[PersDetailModel alloc] init];
	model9.displayname = @"-einee1";
	model9.detail = @"detail111111";
	model9.jobnum = @"120903023101";
	model9.avatar = @"header";
	[_searchDatasource addObject: model9];
	
	PersDetailModel *model10 = [[PersDetailModel alloc] init];
	model10.displayname = @"meinee2";
	model10.detail = @"detail111112";
	model10.jobnum = @"120903023102";
	model10.avatar = @"header";
	[_searchDatasource addObject: model10];
	PersDetailModel *model11 = [[PersDetailModel alloc] init];
	model11.displayname = @"Meinee3";
	model11.detail = @"detail111113";
	model11.jobnum = @"120903023104";
	model11.avatar = @"header";
	[_searchDatasource addObject: model11];
	
	return _searchDatasource;
}

#pragma mrak 获取model
/** 从数据源中获取model*/
-(PersDetailModel *) getCellModel:(NSIndexPath *) indexPath{
	return self.modelDic[self.modelsKey[indexPath.section]][indexPath.row];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return kScreenWidth * 0.056;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	Class currentClass = [ConListCell class];
	
	PersDetailModel *model;
	model = [self getCellModel:indexPath];
	return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:currentClass contentViewWidth:[self cellContentViewWith]];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	NSLog(@"%@", indexPath);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	CGFloat screenWidth = kScreenWidth;
	UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth * 0.056)];
	header.backgroundColor = kColorSection;
	UILabel *label = [[UILabel alloc] init];
	[header addSubview:label];
	label.sd_layout
	.topEqualToView(header)
	.leftSpaceToView(header, screenWidth * 0.044)
	.widthIs(40)
	.bottomEqualToView(header);
	label.text = self.modelsKey[section];
	label.textColor = kColorTextDetail;
	label.font = kFontOfSize(14);
	return header;
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

#pragma mark UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return self.modelDic.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.modelDic[self.modelsKey[section]] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	//获取model
	PersDetailModel *model;
	Class currentClass = [ConListCell class];
	ConListCell *cell = nil;
	cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(currentClass)];
	
	model = [self getCellModel:indexPath];
	cell.model = model;
	// 此步设置用于实现cell的frame缓存，可以让tableview滑动更加流畅
	cell.sd_tableView = tableView;
	cell.sd_indexPath = indexPath;
	
	return cell;
}

-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
	return self.modelsKey;
}

#pragma mark WNSearchResultViewDelegate
-(void)selectedAtIndex:(NSInteger)index{
	NSLog(@"%ld", index);
}

#pragma mark 视图懒加载
-(UITableView *)tableView{
	if (_tableView) {
		return _tableView;
	}
	//创建tableView
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
	_tableView.delegate = self;
	_tableView.dataSource = self;
	[self.view addSubview:self.tableView];
	return _tableView;
}

-(UISearchBar *)searchBar{
	if (_searchBar) {
		return _searchBar;
	}
	_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
	_searchBar.searchBarStyle = UISearchBarStyleMinimal;
	return _searchBar;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
