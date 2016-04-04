//
//  CommonTools.m
//  HongTu
//
//  Created by weinee on 16/4/1.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "CommonTools.h"
#import "PersDetailModel.h"
#import "NSString+Spell.h"
@implementation CommonTools

+(NSMutableDictionary *)getDicByUserModelArray:(NSArray *)array{
	if (array == nil || array.count == 0) {
		return nil;
	}
	NSMutableDictionary* modelDic = [NSMutableDictionary dictionary];
	//使用数组构造分组数据源
	for (PersDetailModel* model in array) {
		NSString *firstChar = [[model.displayname_quanpinFirst substringToIndex:1] uppercaseString];//汉语全拼大写的首字母的第一个字符
		//判断首字符是否为字母
		BOOL isLatter = [firstChar firstCharIsLatter];
		firstChar = isLatter ? firstChar : @"#";
		//判断是否有fistLatter这个关键字
		if (![modelDic objectForKey:firstChar]) {
			//创建可变数组
			NSMutableArray *marr = [NSMutableArray array];
			[modelDic setObject:marr forKey:firstChar];
		}
		[modelDic[firstChar] addObject:model];
	}
	//使用描述排序
	for (NSString* key in modelDic) {
		NSSortDescriptor* desc = [NSSortDescriptor sortDescriptorWithKey:@"displayname_quanpinFirst" ascending:YES];
		[modelDic[key] sortUsingDescriptors:@[desc]];
	}
	return modelDic;
}

@end
