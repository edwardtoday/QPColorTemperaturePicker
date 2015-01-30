//
//  QPColorTemperaturePickerViewDelegateTests.m
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 3/15/14.
//
//

#import <XCTest/XCTest.h>

#import "QPColorTemperaturePickerView.h"
#import "QPColorFunctions.h"

@interface QPColorTemperaturePickerViewDelegateTests
    : QPTestCase <QPColorTemperaturePickerViewDelegate>

@property(nonatomic) QPColorTemperaturePickerView *colorPicker;
@property(nonatomic) int delegateDidChangeSelectionCalledCount;

@end

@implementation QPColorTemperaturePickerViewDelegateTests

- (void)setUp {
  [super setUp];

  // Reset counter
  self.delegateDidChangeSelectionCalledCount = 0;

  self.colorPicker = [[QPColorTemperaturePickerView alloc]
      initWithFrame:CGRectMake(0.0, 0.0, 200.0, 200.0)];
  self.colorPicker.selectionColor = QPRandomColorOpaque(NO);
  // Make sure we set delegate last so counters don't get messed up by init
  self.colorPicker.delegate = self;
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each
  // test method in the class.
  [super tearDown];
}

- (void)testDelegateDidChangeSelection_selectionColor {
  self.colorPicker.selectionColor = QPRandomColorOpaque(NO);
  XCTAssertEqual(self.delegateDidChangeSelectionCalledCount, 1);
}
- (void)testDelegateDidChangeSelection_selection {
  self.colorPicker.selection = CGPointMake(100.0, 100.0);
  XCTAssertEqual(self.delegateDidChangeSelectionCalledCount, 1);
}

#pragma mark - RSColorPickerView Delegates

- (void)colorPickerDidChangeSelection:(QPColorTemperaturePickerView *)cp {
  self.delegateDidChangeSelectionCalledCount++;
  NSLog(@"Got QPColorTemperaturePickerViewDelegate selection change callback");
}
- (void)colorPicker:(QPColorTemperaturePickerView *)colorPicker
       touchesBegan:(NSSet *)touches
          withEvent:(UIEvent *)event {
  XCTFail(@"Got -touchesBegan from running tests");
}
- (void)colorPicker:(QPColorTemperaturePickerView *)colorPicker
       touchesEnded:(NSSet *)touches
          withEvent:(UIEvent *)event {
  XCTFail(@"Got -touchesEnded from running tests");
}

@end
