//
//  QPColorTemperaturePickerStateTests.m
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 3/31/14.
//
//

#import <XCTest/XCTest.h>
#import "QPColorTemperaturePickerState.h"
#import "QPColorFunctions.h"

@interface QPColorTemperaturePickerStateTests : QPTestCase

@end

@implementation QPColorTemperaturePickerStateTests

- (void)setUp {
  [super setUp];
  // Put setup code here. This method is called before the invocation of each
  // test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each
  // test method in the class.
  [super tearDown];
}

- (void)testHue_initWithColor {
  for (int i = 0; i < 5; i++) {
    UIColor *expectedColor = QPRandomColorOpaque(i % 2 == 0);
    QPColorTemperaturePickerState *state =
        [[QPColorTemperaturePickerState alloc] initWithColor:expectedColor];

    CGFloat h, s, v, a;
    [expectedColor getHue:NULL saturation:&s brightness:&v alpha:&a];
    h = state.hue;

    UIColor *actualColor =
        [UIColor colorWithHue:h saturation:s brightness:v alpha:a];

    [self assertColor:actualColor equalsColor:expectedColor];
  }
}

- (void)testSaturation_initWithColor {
  for (int i = 0; i < 5; i++) {
    UIColor *expectedColor = QPRandomColorOpaque(i % 2 == 0);
    QPColorTemperaturePickerState *state =
        [[QPColorTemperaturePickerState alloc] initWithColor:expectedColor];

    CGFloat h, s, v, a;
    [expectedColor getHue:&h saturation:NULL brightness:&v alpha:&a];
    s = state.saturation;

    UIColor *actualColor =
        [UIColor colorWithHue:h saturation:s brightness:v alpha:a];

    [self assertColor:actualColor equalsColor:expectedColor];
  }
}

- (void)testColor_initWithColor {
  for (int i = 0; i < 5; i++) {
    UIColor *expectedColor = QPRandomColorOpaque(i % 2 == 0);
    QPColorTemperaturePickerState *state =
        [[QPColorTemperaturePickerState alloc] initWithColor:expectedColor];

    [self assertColor:state.color equalsColor:expectedColor];
  }
}

- (void)testColor_initWithScaledRelativePoint {
  // Scaled relative point is *relative*, so 0,0 is the center, which should be
  // white

  QPColorTemperaturePickerState *state =
      [[QPColorTemperaturePickerState alloc] initWithScaledRelativePoint:CGPointMake(0, 0)
                                                   brightness:1.0
                                                        alpha:1.0];
  UIColor *expectedColor = [UIColor whiteColor];
  [self assertColor:expectedColor equalsColor:state.color];
}

- (void)testColor_stateForPointSizePadding {
  // Regardless of padding, 100,100 is the center point of a 200px circle, which
  // is white
  // Assumed that default is 100% brightness and 100% alpha

  QPColorTemperaturePickerState *state =
      [QPColorTemperaturePickerState stateForPoint:CGPointMake(100, 100)
                                   size:200
                                padding:0];
  UIColor *expectedColor = [UIColor whiteColor];
  [self assertColor:expectedColor equalsColor:state.color];
}

- (void)testColor_initWithHueSaturationBrightnessAlpha {
  QPColorTemperaturePickerState *state = [[QPColorTemperaturePickerState alloc] initWithHue:0
                                                           saturation:0
                                                           brightness:1.0
                                                                alpha:1.0];
  UIColor *expectedColor = [UIColor whiteColor];
  [self assertColor:expectedColor equalsColor:state.color];
}

- (void)testSelectionLocationWithSizePadding {
  UIColor *expectedColor;
  QPColorTemperaturePickerState *state;
  CGPoint expectedPoint, actualPoint;

  NSArray *centerTests = @[
    [UIColor blackColor],
    [UIColor whiteColor],
    [UIColor colorWithWhite:0.5 alpha:1.0]
  ];
  for (expectedColor in centerTests) {
    state = [[QPColorTemperaturePickerState alloc] initWithColor:expectedColor];

    expectedPoint = CGPointMake(100, 100);
    actualPoint = [state selectionLocationWithSize:200.0 padding:20.0];

    XCTAssertEqual(expectedPoint.x, actualPoint.x);
    XCTAssertEqual(expectedPoint.y, actualPoint.y);
  }
}

@end
