//
//  UIImage+QPImageBitmapRep.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TargetConditionals.h"

#if TARGET_OS_IPHONE

@class QPImageBitmapRep;

#import <UIKit/UIKit.h>

@interface UIImage (QPImageBitmapRep)

#if __has_feature(objc_arc) == 1
+ (UIImage *)imageFromImageBitmapRep:(QPImageBitmapRep *)ibr __attribute__((ns_returns_autoreleased));
- (QPImageBitmapRep *)imageBitmapRep __attribute__((ns_returns_autoreleased));
- (UIImage *)imageByScalingToSize:(CGSize)sz __attribute__((ns_returns_autoreleased));
- (UIImage *)imageFittingFrame:(CGSize)sz __attribute__((ns_returns_autoreleased));
- (UIImage *)imageFillingFrame:(CGSize)sz __attribute__((ns_returns_autoreleased));
#else
+ (UIImage *)imageFromImageBitmapRep:(QPImageBitmapRep *)ibr;
- (QPImageBitmapRep *)imageBitmapRep;
- (UIImage *)imageByScalingToSize:(CGSize)sz;
- (UIImage *)imageFittingFrame:(CGSize)sz;
- (UIImage *)imageFillingFrame:(CGSize)sz;
#endif

@end

#endif
