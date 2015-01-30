//
//  NSImage+QPImageBitmapRep.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TargetConditionals.h"

#if TARGET_OS_IPHONE != 1

#import <Cocoa/Cocoa.h>

@class QPImageBitmapRep;

@interface NSImage (QPImageBitmapRep)

#if __has_feature(objc_arc) == 1
+ (NSImage *)imageFromImageBitmapRep:(QPImageBitmapRep *)ibr __attribute__((ns_returns_autoreleased));
- (QPImageBitmapRep *)imageBitmapRep __attribute__((ns_returns_autoreleased));
- (NSImage *)imageByScalingToSize:(CGSize)sz __attribute__((ns_returns_autoreleased));
- (NSImage *)imageFittingFrame:(CGSize)sz __attribute__((ns_returns_autoreleased));
- (NSImage *)imageFillingFrame:(CGSize)sz __attribute__((ns_returns_autoreleased));
#else
+ (NSImage *)imageFromImageBitmapRep:(QPImageBitmapRep *)ibr;
- (QPImageBitmapRep *)imageBitmapRep;
- (NSImage *)imageByScalingToSize:(CGSize)sz;
- (NSImage *)imageFittingFrame:(CGSize)sz;
- (NSImage *)imageFillingFrame:(CGSize)sz;
#endif

@end

#endif
