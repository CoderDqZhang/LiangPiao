//
//  SellFormModel.h
//  LiangPiao
//
//  Created by Zhang on 16/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKDBModel.h"
#import <MJExtension/MJExtension.h>

@interface SellFormModel : JKDBModel

@property (nonatomic, copy) NSString  *id;

@property (nonatomic, copy) NSString  *price;

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *sellPrice;

@property (nonatomic, copy) NSString  *sellType;

@property (nonatomic, copy) NSString  *ticketRegin;

@property (nonatomic, copy) NSString  *ticketRow;

@property (nonatomic, assign) NSInteger ticketSellType;

@property (nonatomic, copy) NSString *deverliExpress;

@property (nonatomic, copy) NSString *deverliPresnt;

@property (nonatomic, copy) NSString *deverliVisite;

- (instancetype)init;

@end
