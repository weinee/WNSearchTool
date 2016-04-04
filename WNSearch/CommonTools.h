//
//  CommonTools.h
//  HongTu
//
//  Created by weinee on 16/4/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 通用工具类，可以把一些通用逻辑封装在这里*/
@interface CommonTools : NSObject
/**
 *  传入一个用户模型的数组，返回一个字典，字典每个关键字对应了一组由相同用户名首字母组成的数组，数组中要排序
 *
 *  @param array 用户模型的数组
 *
 *  @return 字典每个关键字对应了一组由相同用户名首字母组成的数组
 */
+(NSMutableDictionary *) getDicByUserModelArray: (NSArray *) array;

@end
