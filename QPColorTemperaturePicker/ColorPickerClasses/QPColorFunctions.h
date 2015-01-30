//
//  QPColorFunctions.h
//  QPColorTemperaturePicker
//
//  Created by Pei Qing on 3/12/13.
//

#import <UIKit/UIKit.h>
#import "QPImageBitmapRep.h"

BMPixel QPPixelFromHSV(CGFloat H, CGFloat S, CGFloat V, CGFloat k);
void QPHSVFromPixel(BMPixel pixel, CGFloat *h, CGFloat *s, CGFloat *v);

// four floats will be placed into `components`
void QPGetComponentsForColor(CGFloat *components, UIColor *color);

UIImage *QPUIImageWithScale(UIImage *img, CGFloat scale);

UIImage *QPOpacityBackgroundImage(CGFloat length, CGFloat scale,
                                  UIColor *color);

UIColor *QPRandomColorOpaque(BOOL isOpaque);
