//
//  Header.h
//  WNSearch
//
//  Created by weinee on 16/4/4.
//  Copyright © 2016年 weinee. All rights reserved.
//

#ifndef Header_h
#define Header_h
#import "MJRefresh.h"

///Size
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define STATUBAR_HEIGHT 20.f
#define NAVIGATIONBAR_HEIGHT 64.f
#define NAVIGATIONBAR_ORIGIN_OFFSET ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? 0 : 20.f)

//导航条高度
#define NAVHEIGHT self.navigationController.navigationBar.frame.size.height
//状态栏高度
#define  STAUSHEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
//导航条默认颜色
#define NAVIGATIONBAR_BACKGROUNDCOLOR [UIColor colorWithRed:130/255.0 green:197/255.0 blue:66/255.0 alpha:1.0]
//TabBar高度
#define TABBARHEIGHT 48
//当前SDK版本
#define CurrentVersion [[[UIDevice currentDevice] systemVersion] floatValue]

//Tab默认颜色
#define TAB_ITEMSELECTEDCOLOR [UIColor colorWithRed:113/255.0 green:192/255.0 blue:188/255.0 alpha:1.0]


#define kColorGray [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0]
#define kColorGreen [UIColor colorWithRed:130/255.0 green:197/255.0 blue:66/255.0 alpha:1.0]
#define kColorGreenThin [UIColor colorWithRed:130/255.0 green:197/255.0 blue:66/255.0 alpha:0.3]

#define kColorRed [UIColor colorWithRed:247/255.0 green:89/255.0 blue:80/255.0 alpha:1.0]
#define kColorBlue [UIColor colorWithRed:58/255.0 green:183/255.0 blue:241/255.0 alpha:1.0]
#define kColorPurple [UIColor colorWithRed:194/255.0 green:98/255.0 blue:214/255.0 alpha:1.0]
#define kColorOrange [UIColor colorWithRed:255/255.0 green:197/255.0 blue:73/255.0 alpha:1.0]

//只读按钮颜色
#define kColorReadonly [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0]
//遮罩层
#define kColorMaskBlack [UIColor colorWithRed:0.f/255.0 green:0.f/255.0 blue:0.f/255.0 alpha:0.7]
#define kColorMaskGray [UIColor colorWithRed:0.f/255.0 green:0.f/255.0 blue:0.f/255.0 alpha:0.5]
#define kColorMaskGreen [UIColor colorWithRed:130.f/255.0 green:197.f/255.0 blue:66.f/255.0 alpha:0.7]

//民生蓝色
#define kColorMS [UIColor colorWithRed:0/255.0 green:104/255.0 blue:183/255.0 alpha:1.0]
//标题文字颜色
#define kColorTextTitle [UIColor colorWithRed:0/255.0 green:154/255.0 blue:83/255.0 alpha:1.0]
//正常文字颜色
#define kColorTextDetail [UIColor colorWithRed:112/255.0 green:112/255.0 blue:112/255.0 alpha:1.0]
//正常文字颜色，稍深
#define kColorTextDetailDeeper [UIColor colorWithRed:49/255.0 green:49/255.0 blue:49/255.0 alpha:1.0]
//通讯录字体颜色
#define kColorTextName [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

//分割线颜色
#define kColorSplitLine [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1.0]
//进度条背景色
#define kColorProgressBG [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]
//图片背景框
#define kColorImageBG [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:1.0]
//我的背景颜色
#define kColorMeBG [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1]
//分区标题背景颜色
#define kColorSection [UIColor colorWithRed:252/255.0 green:252/255.0 blue:252/255.0 alpha:1.0]
//分割线颜色
#define kColorSeparator [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0]
//透明
#define kColorClear [UIColor clearColor]

///Fonts
#define kFontOfSize(fontSize) [UIFont fontWithName:@"STHeitiSC-Light" size:fontSize]
#define kFontOfSizeBold(fontSize) [UIFont fontWithName:@"STHeitiSC-Medium" size:fontSize]
#endif /* Header_h */
