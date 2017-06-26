//
//  AHBaseModel.h
//  NiuNiuLive
//
//  Created by ComAnvei on 17/3/20.
//  Copyright © 2017年 AH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AHBaseModel : NSObject
//访问状态 1是成功。
@property(nonatomic,assign)NSInteger success;
//数组
@property(nonatomic,strong)id data;

//为0时 没有更多
@property(nonatomic,assign)NSInteger more;

//msg
@property(nonatomic,copy)NSString *msg;
@end
