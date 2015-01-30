//
//  UIImage+QPImageBitmapRep.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TargetConditionals.h"

#if TARGET_OS_IPHONE

#import "UIImage+QPImageBitmapRep.h"
#import "QPImageBitmapRep.h"

@implementation UIImage (QPImageBitmapRep)


+ (UIImage *)imageFromImageBitmapRep:(QPImageBitmapRep *)ibr {
    return [ibr image];
}

- (QPImageBitmapRep *)imageBitmapRep {
#if __has_feature(objc_arc) == 1
    return [[QPImageBitmapRep alloc] initWithImage:self];
#else
    return [[[QPImageBitmapRep alloc] initWithImage:self] autorelease];
#endif
}

- (UIImage *)imageByScalingToSize:(CGSize)sz {
    QPImageBitmapRep * imageBitmap = [[QPImageBitmapRep alloc] initWithImage:self];
    [imageBitmap setSize:QPBMPointMake(round(sz.width), round(sz.height))];
    UIImage * scaled = [imageBitmap image];
#if __has_feature(objc_arc) != 1
    [imageBitmap release];
#endif
    return scaled;
}

- (UIImage *)imageFittingFrame:(CGSize)sz {
    QPImageBitmapRep * imageBitmap = [[QPImageBitmapRep alloc] initWithImage:self];
    [imageBitmap setSizeFittingFrame:QPBMPointMake(round(sz.width), round(sz.height))];
    UIImage * scaled = [imageBitmap image];
#if __has_feature(objc_arc) != 1
    [imageBitmap release];
#endif
    return scaled;
}

- (UIImage *)imageFillingFrame:(CGSize)sz {
    QPImageBitmapRep * imageBitmap = [[QPImageBitmapRep alloc] initWithImage:self];
    [imageBitmap setSizeFillingFrame:QPBMPointMake(round(sz.width), round(sz.height))];
    UIImage * scaled = [imageBitmap image];
#if __has_feature(objc_arc) != 1
    [imageBitmap release];
#endif
    return scaled;
}

@end

#endif
