//
//  TestColorTemperatureViewController.m
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 1/31/15.
//

#import "TestColorTemperatureViewController.h"
#import "QPBrightnessSlider.h"

@implementation TestColorTemperatureViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = QPRandomColorOpaque(YES);

  self.navigationController.navigationBar.translucent = NO;
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Push"
                                       style:UIBarButtonItemStyleBordered
                                      target:self
                                      action:@selector(pushNext:)];

  // View that displays color picker (needs to be square)
  _colorPicker = [[QPColorTemperaturePickerView alloc]
      initWithFrame:CGRectMake(20.0, 10.0, 280.0, 280.0)];

  // Optionally set and force the picker to only draw a circle
  //    [_colorPicker setCropToCircle:YES]; // Defaults to NO (you can set BG
  //    color)

  // Set the selection color - useful to present when the user had picked a
  // color previously
  [_colorPicker setSelectionColor:QPRandomColorOpaque(YES)];

  //    [_colorPicker setSelectionColor:[UIColor colorWithRed:1 green:0
  //    blue:0.752941 alpha:1.000000]];
  //    [_colorPicker setSelection:CGPointMake(269, 269)];

  // Set the delegate to receive events
  [_colorPicker setDelegate:self];

  [self.view addSubview:_colorPicker];

  // On/off circle or square
  UISwitch *circleSwitch =
      [[UISwitch alloc] initWithFrame:CGRectMake(10, 340, 0, 0)];
  [circleSwitch setOn:_colorPicker.cropToCircle];
  [circleSwitch addTarget:self
                   action:@selector(circleSwitchAction:)
         forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:circleSwitch];

  // View that controls brightness
  _brightnessSlider = [[QPBrightnessSlider alloc]
      initWithFrame:CGRectMake(CGRectGetMaxX(circleSwitch.frame) + 4, 300.0,
                               320 - (20 + CGRectGetWidth(circleSwitch.frame)),
                               30.0)];
  [_brightnessSlider setColorPicker:_colorPicker];
  [self.view addSubview:_brightnessSlider];

  // View that shows selected color
  _colorPatch =
      [[UIView alloc] initWithFrame:CGRectMake(160, 380.0, 150, 30.0)];
  [self.view addSubview:_colorPatch];

  UIButton *resizeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  resizeButton.frame = CGRectMake(10.0, 380.0, 50.0, 30.0);

  [resizeButton setTitle:@"Resize" forState:UIControlStateNormal];
  [resizeButton addTarget:self
                   action:@selector(testResize:)
         forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:resizeButton];

  UIButton *loupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  loupButton.frame = CGRectMake(CGRectGetMaxX(resizeButton.frame) + 10,
                                CGRectGetMinY(resizeButton.frame), 50, 30);
  [loupButton setTitle:@"Loup" forState:UIControlStateNormal];
  [loupButton addTarget:self
                 action:@selector(testLoup:)
       forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:loupButton];

  _rgbLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(CGRectGetMaxX(loupButton.frame) + 10,
                               CGRectGetMinY(loupButton.frame) + 30, 180, 30)];
  _rgbLabel.text = @"RGB";
  _rgbLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  [self.view addSubview:_rgbLabel];
}

#pragma mark - QPColorTemperaturePickerView delegate methods

- (void)colorPickerDidChangeSelection:(QPColorTemperaturePickerView *)cp {

  // Get color data
  UIColor *color = [cp selectionColor];

  CGFloat r, g, b, a;
  [[cp selectionColor] getRed:&r green:&g blue:&b alpha:&a];

  // Update important UI
  _colorPatch.backgroundColor = color;
  _brightnessSlider.value = [cp brightness];

  // Debug
  NSString *colorDesc =
      [NSString stringWithFormat:@"rgba: %f, %f, %f, %f", r, g, b, a];
  NSLog(@"%@", colorDesc);
  int ir = r * 255;
  int ig = g * 255;
  int ib = b * 255;
  int ia = a * 255;
  colorDesc =
      [NSString stringWithFormat:@"rgba: %d, %d, %d, %d", ir, ig, ib, ia];
  NSLog(@"%@", colorDesc);
  _rgbLabel.text = colorDesc;

  NSLog(@"%@", NSStringFromCGPoint(cp.selection));
}

#pragma mark - User action

- (void)testResize:(id)sender {
  if (isSmallSize) {
    _colorPicker.frame = CGRectMake(20.0, 10.0, 280.0, 280.0);
    isSmallSize = NO;
  } else {
    _colorPicker.frame = CGRectMake(40.0, 10.0, 240.0, 240.0);
    isSmallSize = YES;
  }
}

- (void)testLoup:(id)sender {
  if (_colorPicker.showLoupe) {
    _colorPicker.showLoupe = NO;
  } else {
    _colorPicker.showLoupe = YES;
  }
}

- (void)selectRed:(id)sender {
  [_colorPicker setSelectionColor:[UIColor redColor]];
}
- (void)selectGreen:(id)sender {
  [_colorPicker setSelectionColor:[UIColor greenColor]];
}
- (void)selectBlue:(id)sender {
  [_colorPicker setSelectionColor:[UIColor blueColor]];
}
- (void)selectBlack:(id)sender {
  [_colorPicker setSelectionColor:[UIColor blackColor]];
}
- (void)selectWhite:(id)sender {
  [_colorPicker setSelectionColor:[UIColor whiteColor]];
}
- (void)selectPurple:(id)sender {
  [_colorPicker setSelectionColor:[UIColor purpleColor]];
}
- (void)selectCyan:(id)sender {
  [_colorPicker setSelectionColor:[UIColor cyanColor]];
}

- (void)circleSwitchAction:(UISwitch *)s {
  _colorPicker.cropToCircle = s.isOn;
}

#pragma mark - Push the stack

- (void)pushNext:(id)sender {
  TestColorTemperatureViewController *colorController =
      [[TestColorTemperatureViewController alloc] initWithNibName:nil
                                                           bundle:nil];
  [self.navigationController pushViewController:colorController animated:YES];
}

#pragma mark - Generated methods

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
