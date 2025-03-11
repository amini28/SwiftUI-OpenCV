//
//  OpencvWrappers.h
//  SwiftUI-OpenCV
//
//  Created by Amini on 09/03/25.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpencvWrappers : NSObject

+ (UIImage *)applyWarmFilterToImage:(UIImage *)image intensity:(int) intensity;

@end
