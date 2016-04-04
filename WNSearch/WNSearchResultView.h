//
//  WNSearchResultView.h
//  HongTu
//
//  Created by weinee on 16/3/31.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"

@protocol WNSearchResultViewDelegate <NSObject>
-(void)selectedAtIndex:(NSInteger) index;
@end
@interface WNSearchResultView : UIView

@property (nonatomic, weak) id<WNSearchResultViewDelegate> delegate;

@property (nonatomic, assign, getter=isHidenNavigationBar) BOOL hidenNavigationBar;

/**
 *  初始化搜索
 *  @param searchBar  使用的searchBar
 *  @param datasource 进行搜索的源数据
 *	@param viewController 搜索所在的controller
 *  @return
 */
-(instancetype)initWithSearchBar:(UISearchBar *)searchBar dateSource:(NSArray *)datasource contentController:(UIViewController*) viewController;
/**
 *  调整通用性
 *
 *  @param tableCellClass 显示结果的cell类
 *  @param modelKeyPath   在cell中model的keypath
 */
-(void)setCellClass:(Class) tableCellClass andModelKeyPath:(NSString *)modelKeyPath;

/**
 *  显示到给定的view
 *
 *  @param view 要显示到的父view
 *  @param edge 指定在父view中的边距
 */
-(void)showInView:(UIView *)view edge:(UIEdgeInsets)edge;


/**
 1. 搜索开始前半透明的遮罩，隐藏导航栏，搜索结束要显示导航栏，并移除搜索视图。
 2. 根据原searchBar创建了新的searchBar
 3. 本类的fram使用contentViewController中的view
 
 4. 可以使用自定义的TableViewCell
 
 5. 搜索结果按首字母顺序排序
 
 */
@end
