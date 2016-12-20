//
//  UserInfoModel.h
//  LiangPiao
//
//  Created by Zhang on 16/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

#import "JKDBModel.h"
#import <MJExtension/MJExtension.h>

@interface UserInfoModel : JKDBModel

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, assign) NSInteger gender;

+ (instancetype)shareInstance;

+ (BOOL)logout;

+ (BOOL)isLoggedIn;

//+ (UserInfoModel *)unarchiveObjectWithFile;
//
//+ (void)archiveRootObject:(UserInfoModel *)model;

@end
