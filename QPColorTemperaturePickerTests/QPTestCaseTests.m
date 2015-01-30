//
//  QPTestCaseTests.m
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 3/13/14.
//
//

#import <XCTest/XCTest.h>

@interface QPTestCaseTests : QPTestCase

@end

@implementation QPTestCaseTests

- (void)testAssertColorEqualsColor {
  UIColor *redA = [UIColor redColor];
  UIColor *redB = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];

  [self assertColor:redA equalsColor:redB];
}

- (void)testAssertColorNotEqualsColor {
  UIColor *red = [UIColor redColor];
  UIColor *green = [UIColor greenColor];

  [self assertColor:red notEqualsColor:green];
}

@end
