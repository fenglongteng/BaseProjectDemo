//
//  UITableView+AHTableViewEmptyPlaceHold.h
//  NiuNiuLive
//
//  Created by ComAnvei on 17/3/28.
//  Copyright © 2017年 AH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AHEmptyPlaceHoldView.h"
@interface UITableView (AHTableViewEmptyPlaceHold)
@property (nonatomic, strong) AHEmptyPlaceHoldView *placeHolderView;
-(void)ah_reloadData;
@end
