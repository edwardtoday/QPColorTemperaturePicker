//
//  QPTestCase.h
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 3/13/14.
//
//

#import <XCTest/XCTest.h>

#define kColorComponentAccuracy (1.0 / 255.0)

@interface QPTestCase : XCTestCase

- (void)assertColor:(UIColor *)colorA equalsColor:(UIColor *)colorB;
- (void)assertColor:(UIColor *)colorA notEqualsColor:(UIColor *)colorB;

@end
