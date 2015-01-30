//
//  GenerateOperation.h
//  QPColorTemperaturePicker
//
//  Created by Ryan on 7/22/13.
//

#import <Foundation/Foundation.h>
#import <Accelerate/Accelerate.h>

@class QPImageBitmapRep;

@interface RSGenerateOperation : NSOperation

-(id)initWithDiameter:(CGFloat)diameter andPadding:(CGFloat)padding;

@property (readonly) CGFloat diameter;
@property (readonly) CGFloat padding;

@property QPImageBitmapRep *bitmap;

@end
