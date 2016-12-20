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
    self.ticketRow = @"随机分配";
    self.ticketRegin = @"随机分配";
    self.sellType = @"单卖";
    self.seatType = @"2";
    self.deverliExpress = @"请选择";
    self.deverliVisite = @"请选择";
    self.deverliPresnt = @"请选择";
    self.ticketSellType = 1;
    return self;
}

@end
