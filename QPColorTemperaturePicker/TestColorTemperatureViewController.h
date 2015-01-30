//
//  TestColorTemperatureViewController.h
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 1/31/15.
//

#import <UIKit/UIKit.h>
#import "ColorPickerClasses/QPColorTemperaturePickerView.h"
#import "ColorPickerClasses/QPColorFunctions.h"

@class QPBrightnessSlider;

@interface TestColorTemperatureViewController
    : UIViewController <QPColorTemperaturePickerViewDelegate> {
  BOOL isSmallSize;
}

@property(nonatomic) QPColorTemperaturePickerView *colorPicker;
@property(nonatomic) QPBrightnessSlider *brightnessSlider;
@property(nonatomic) UIView *colorPatch;

@property UILabel *rgbLabel;

@end
