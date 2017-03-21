//
//  ExpressDeliveryNet.h
//  LiangPiao
//
//  Created by Zhang on 2017/3/19.
//  Copyright © 2017年 Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ExpressDeliveryNet : NSObject

+ (instancetype)shareInstance;

- (RACSignal *)requestExpressDelivreyNetOrder:(NSDictionary *)dic url:(NSString *)url;

@end
