//
//  UIImage+Compress.h
//  LiangPiao
//
//  Created by Zhang on 29/12/2016.
//  Copyright © 2016 Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Compress)

+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end
