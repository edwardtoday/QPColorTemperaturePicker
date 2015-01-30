//
//  NSImage+QPImageBitmapRep.m
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "TargetConditionals.h"

#if TARGET_OS_IPHONE != 1

#import "NSImage+QPImageBitmapRep.h"
#import "QPImageBitmapRep.h"

@implementation NSImage (QPImageBitmapRep)

+ (NSImage *)imageFromImageBitmapRep:(QPImageBitmapRep *)ibr {
  return [ibr image];
}

- (QPImageBitmapRep *)imageBitmapRep {
#if __has_feature(objc_arc) == 1
  return [[QPImageBitmapRep alloc] initWithImage:self];
#else
  return [[[QPImageBitmapRep alloc] initWithImage:self] autorelease];
#endif
}

- (NSImage *)imageByScalingToSize:(CGSize)sz {
  QPImageBitmapRep *imageBitmap = [[QPImageBitmapRep alloc] initWithImage:self];
  [imageBitmap setSize:BMPointMake(round(sz.width), round(sz.height))];
  NSImage *scaled = [imageBitmap image];
#if __has_feature(objc_arc) != 1
  [imageBitmap release];
#endif
  return scaled;
}

- (NSImage *)imageFittingFrame:(CGSize)sz {
  QPImageBitmapRep *imageBitmap = [[QPImageBitmapRep alloc] initWithImage:self];
  [imageBitmap
      setSizeFittingFrame:BMPointMake(round(sz.width), round(sz.height))];
  NSImage *scaled = [imageBitmap image];
#if __has_feature(objc_arc) != 1
  [imageBitmap release];
#endif
  return scaled;
}

- (NSImage *)imageFillingFrame:(CGSize)sz {
  QPImageBitmapRep *imageBitmap = [[QPImageBitmapRep alloc] initWithImage:self];
  [imageBitmap
      setSizeFillingFrame:BMPointMake(round(sz.width), round(sz.height))];
  NSImage *scaled = [imageBitmap image];
#if __has_feature(objc_arc) != 1
  [imageBitmap release];
#endif
  return scaled;
}

@end

#endif
