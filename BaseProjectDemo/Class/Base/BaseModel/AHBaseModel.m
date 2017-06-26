//
//  AHBaseModel.m
//  NiuNiuLive
//
//  Created by ComAnvei on 17/3/20.
//  Copyright © 2017年 AH. All rights reserved.
//

#import "AHBaseModel.h"
#import "YYModel.h"
@implementation AHBaseModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"success" :@[@"success",@"status"],
             @"msg" : @[@"msg",@"message"]};
}

@end
