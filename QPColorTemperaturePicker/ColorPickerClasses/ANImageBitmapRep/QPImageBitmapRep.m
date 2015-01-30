//
//  QPImageBitmapRep.m
//  ImageManip
//
//  Created by Alex Nichol on 7/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "QPImageBitmapRep.h"

BMPixel QPBMPixelMake(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha,
                      CGFloat k) {
  BMPixel pixel;

  if (red < 0 || green < 0 || blue < 0) {
    pixel.red = red;
    pixel.green = green;
    pixel.blue = blue;
    pixel.alpha = alpha;

  } else {
    pixel.red = 1.0;
    pixel.green = 1.0;
    pixel.blue = k;
    pixel.alpha = alpha;
  }

  return pixel;
}

#if TARGET_OS_IPHONE
UIColor *UIColorFromBMPixel(BMPixel pixel) {
  return [UIColor colorWithRed:pixel.red
                         green:pixel.green
                          blue:pixel.blue
                         alpha:pixel.alpha];
}
#elif TARGET_OS_MAC
NSColor *NSColorFromBMPixel(BMPixel pixel) {
  return [NSColor colorWithCalibratedRed:pixel.red
                                   green:pixel.green
                                    blue:pixel.blue
                                   alpha:pixel.alpha];
}
#endif

@interface QPImageBitmapRep (BaseClasses)

- (void)generateBaseClasses;

@end

@implementation QPImageBitmapRep

- (void)forwardInvocation:(NSInvocation *)anInvocation {
  if (!baseClasses)
    [self generateBaseClasses];
  for (int i = 0; i < [baseClasses count]; i++) {
    QPBitmapContextManipulator *manip = [baseClasses objectAtIndex:i];
    if ([manip respondsToSelector:[anInvocation selector]]) {
      [anInvocation invokeWithTarget:manip];
      return;
    }
  }
  [self doesNotRecognizeSelector:[anInvocation selector]];
}

#if __has_feature(objc_arc) == 1
+ (QPImageBitmapRep *)imageBitmapRepWithCGSize:(CGSize)avgSize {
  return [[QPImageBitmapRep alloc]
      initWithSize:QPBMPointMake(round(avgSize.width), round(avgSize.height))];
}

+ (QPImageBitmapRep *)imageBitmapRepWithImage:(QPImageObj *)anImage {
  return [[QPImageBitmapRep alloc] initWithImage:anImage];
}
#else
+ (QPImageBitmapRep *)imageBitmapRepWithCGSize:(CGSize)avgSize {
  return [[[QPImageBitmapRep alloc]
      initWithSize:QPBMPointMake(round(avgSize.width),
                                 round(avgSize.height))] autorelease];
}

+ (QPImageBitmapRep *)imageBitmapRepWithImage:(QPImageObj *)anImage {
  return [[[QPImageBitmapRep alloc] initWithImage:anImage] autorelease];
}
#endif

- (void)invertColors {
  UInt8 pixel[4];
  BMPoint size = [self bitmapSize];
  for (long y = 0; y < size.y; y++) {
    for (long x = 0; x < size.x; x++) {
      [self getRawPixel:pixel atPoint:QPBMPointMake(x, y)];
      pixel[0] = 255 - pixel[0];
      pixel[1] = 255 - pixel[1];
      pixel[2] = 255 - pixel[2];
      [self setRawPixel:pixel atPoint:QPBMPointMake(x, y)];
    }
  }
}

- (void)setQuality:(CGFloat)quality {
  NSAssert(quality >= 0 && quality <= 1, @"Quality must be between 0 and 1.");
  if (quality == 1.0)
    return;
  CGSize cSize = CGSizeMake((CGFloat)([self bitmapSize].x) * quality,
                            (CGFloat)([self bitmapSize].y) * quality);
  BMPoint oldSize = [self bitmapSize];
  [self setSize:QPBMPointMake(round(cSize.width), round(cSize.height))];
  [self setSize:oldSize];
}

- (void)setBrightness:(CGFloat)brightness {
  NSAssert(brightness >= 0 && brightness <= 2,
           @"Brightness must be between 0 and 2.");
  BMPoint size = [self bitmapSize];
  for (long y = 0; y < size.y; y++) {
    for (long x = 0; x < size.x; x++) {
      BMPoint point = QPBMPointMake(x, y);
      BMPixel pixel = [self getPixelAtPoint:point];
      pixel.red *= brightness;
      pixel.green *= brightness;
      pixel.blue *= brightness;
      if (pixel.red > 1)
        pixel.red = 1;
      if (pixel.green > 1)
        pixel.green = 1;
      if (pixel.blue > 1)
        pixel.blue = 1;
      [self setPixel:pixel atPoint:point];
    }
  }
}

- (BMPixel)getPixelAtPoint:(BMPoint)point {
  UInt8 rawPixel[4];
  [self getRawPixel:rawPixel atPoint:point];
  BMPixel pixel;
  pixel.alpha = (CGFloat)(rawPixel[3]) / 255.0;
  pixel.red = ((CGFloat)(rawPixel[0]) / 255.0) / pixel.alpha;
  pixel.green = ((CGFloat)(rawPixel[1]) / 255.0) / pixel.alpha;
  pixel.blue = ((CGFloat)(rawPixel[2]) / 255.0) / pixel.alpha;
  return pixel;
}

- (void)setPixel:(BMPixel)pixel atPoint:(BMPoint)point {
  NSAssert(pixel.red >= 0 && pixel.red <= 1,
           @"Pixel color must range from 0 to 1.");
  NSAssert(pixel.green >= 0 && pixel.green <= 1,
           @"Pixel color must range from 0 to 1.");
  NSAssert(pixel.blue >= 0 && pixel.blue <= 1,
           @"Pixel color must range from 0 to 1.");
  NSAssert(pixel.alpha >= 0 && pixel.alpha <= 1,
           @"Pixel color must range from 0 to 1.");
  UInt8 rawPixel[4];
  rawPixel[0] = round(pixel.red * 255.0 * pixel.alpha);
  rawPixel[1] = round(pixel.green * 255.0 * pixel.alpha);
  rawPixel[2] = round(pixel.blue * 255.0 * pixel.alpha);
  rawPixel[3] = round(pixel.alpha * 255.0);
  [self setRawPixel:rawPixel atPoint:point];
}

- (QPImageObj *)image {
  return QPImageFromCGImage([self CGImage]);
}

#if __has_feature(objc_arc) != 1
- (void)dealloc {
  [baseClasses release];
  [super dealloc];
}
#endif

#pragma mark Base Classes

- (void)generateBaseClasses {
  QPBitmapCropManipulator *croppable =
      [[QPBitmapCropManipulator alloc] initWithContext:self];
  QPBitmapScaleManipulator *scalable =
      [[QPBitmapScaleManipulator alloc] initWithContext:self];
  QPBitmapRotationManipulator *rotatable =
      [[QPBitmapRotationManipulator alloc] initWithContext:self];
  QPBitmapDrawManipulator *drawable =
      [[QPBitmapDrawManipulator alloc] initWithContext:self];
  baseClasses = [[NSArray alloc]
      initWithObjects:croppable, scalable, rotatable, drawable, nil];
#if __has_feature(objc_arc) != 1
  [rotatable release];
  [scalable release];
  [croppable release];
  [drawable release];
#endif
}

#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
  BMPoint size = [self bitmapSize];
  QPImageBitmapRep *rep =
      [[QPImageBitmapRep allocWithZone:zone] initWithSize:size];
  CGContextRef newContext = [rep context];
  CGContextDrawImage(newContext, CGRectMake(0, 0, size.x, size.y),
                     [self CGImage]);
  [rep setNeedsUpdate:YES];
  return rep;
}

@end
