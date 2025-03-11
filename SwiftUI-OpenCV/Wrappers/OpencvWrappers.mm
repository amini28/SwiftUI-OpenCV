//
//  OpencvWrappers.m
//  SwiftUI-OpenCV
//
//  Created by Amini on 09/03/25.
//

#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>
#import "OpencvWrappers.h"

@implementation OpencvWrappers

+ (UIImage *)applyWarmFilterToImage:(UIImage *)image intensity:(int)intensity{
    cv::Mat mat;
    UIImageToMat(image, mat);

    if (mat.empty()) {
        return image;
    }

    cv::Mat warmMat;
    std::vector<cv::Mat> channels;
    cv::split(mat, channels);

    /***

     Apply filter by changes red / blue color
     - cv::Mat is core data stcuture in openCV used to represent images and matrices
     - mat represent rgb image
     - channles is a dynamic array that will hold a collection of cv:Mat objects
     - mat split into array in channels represents (blue[0], green[1], red[2])
     
     ***/
    // adjust channels
    channels[2] = channels[2] + intensity; // adjust red
    channels[0] = channels[0] - intensity; // adjust blue

    cv::merge(channels, warmMat);

    return MatToUIImage(warmMat);
}

@end
