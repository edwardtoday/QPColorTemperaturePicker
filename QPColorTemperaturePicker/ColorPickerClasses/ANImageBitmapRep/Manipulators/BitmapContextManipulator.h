//
//  BitmapContextManip.h
//  ImageBitmapRep
//
//  Created by Alex Nichol on 10/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QPBitmapContextRep.h"

@interface BitmapContextManipulator : NSObject <BitmapContextRep> {
#if __has_feature(objc_arc) == 1
  __unsafe_unretained QPBitmapContextRep *bitmapContext;
#else
  QPBitmapContextRep *bitmapContext;
#endif
}

#if __has_feature(objc_arc) == 1
@property(nonatomic, assign) QPBitmapContextRep *bitmapContext;
#else
@property(nonatomic, assign) QPBitmapContextRep *bitmapContext;
#endif

- (id)initWithContext:(QPBitmapContextRep *)aContext;

@end
