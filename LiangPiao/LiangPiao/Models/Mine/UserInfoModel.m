//
//  UserInfoModel.m
//  LiangPiao
//
//  Created by Zhang on 16/11/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

#import "UserInfoModel.h"

#define kEncodedObjectPath_User ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"UserInfo"])


static UserInfoModel *_instance = nil;

@implementation UserInfoModel

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UserInfoModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
        if ([UserInfoModel findAll].count > 0) {
            _instance =  [UserInfoModel findLastObject];
        }else{
            _instance = [[UserInfoModel alloc] init];
        }
        
    });
    return _instance;
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [self init];
//    if (self) {
//        self.id = [aDecoder decodeObjectForKey:@"uid"];
//        self.username = [aDecoder decodeObjectForKey:@"username"];
//        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
//        self.gender = [aDecoder decodeIntegerForKey:@"gender"];
//    }
//    return self;
//}
//
//#pragma mark - NSCoding
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    
//    [aCoder encodeObject:self.id forKey:@"uid"];
//    [aCoder encodeObject:self.username forKey:@"username"];
//    [aCoder encodeObject:self.avatar forKey:@"avatar"];
//    [aCoder encodeInteger:self.gender forKey:@"gender"];
//}


+ (BOOL)isLoggedIn
{
    if ([UserInfoModel findAll].count > 0) {
        return YES;
    }else{
        return NO;
    }
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    return [fileManager fileExistsAtPath:kEncodedObjectPath_User];
}

+ (BOOL)logout
{
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    BOOL result = [fileManager removeItemAtPath:kEncodedObjectPath_User error:&error];
    [UserInfoModel shareInstance].id = nil;
    [UserInfoModel shareInstance].avatar = nil;
    [UserInfoModel shareInstance].username = nil;
    [UserInfoModel shareInstance].phone = nil;
    [UserInfoModel shareInstance].gender = 0;
    return [[UserInfoModel shareInstance] deleteObject];;
}

//+ (void)archiveRootObject:(UserInfoModel *)model
//{
//    [NSKeyedArchiver archiveRootObject:model toFile:kEncodedObjectPath_User];
//}
//
//+ (UserInfoModel *)unarchiveObjectWithFile
//{
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:kEncodedObjectPath_User];
//}

@end
