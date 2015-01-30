//
//  OSCommonImage.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#ifndef ImageBitmapRep_OSCommonImage_h
#define ImageBitmapRep_OSCommonImage_h

#import "TargetConditionals.h"
#import "QPCGImageContainer.h"

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
typedef UIImage QPImageObj;
#elif TARGET_OS_MAC
#import <Cocoa/Cocoa.h>
typedef NSImage QPImageObj;
#endif

CGImageRef CGImageFromQPImage(QPImageObj *QPImageObj);
QPImageObj *QPImageFromCGImage(CGImageRef imageRef);

#endif
