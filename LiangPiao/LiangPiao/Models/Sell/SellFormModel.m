//
//  SellFormModel.m
//  LiangPiao
//
//  Created by Zhang on 16/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

#import "SellFormModel.h"

@implementation SellFormModel

- (instancetype)init{
    self = [super init];
    self.ticketRow = @"随机";
    self.ticketRegin = @"随机";
    self.sellType = @"可以分开卖";
    self.seatType = @"1";
    self.ticketPrice = @"10";
    self.deverliExpress = @"请选择";
    self.deverliVisite = @"请选择";
    self.deverliPresnt = @"请选择";
    self.ticketSellType = 1;
    self.sellCategoty = 0;
    return self;
}

@end
