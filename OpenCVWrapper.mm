//
//  OpenCVWrapper.m
//  CameraCaptureApp
//
//  Created by Adithya Pradosh on 11/6/16.
//  Copyright © 2016 adiprad. All rights reserved.
//

#import "OpenCVWrapper.h"
#import <opencv2/opencv.hpp>
#import <opencv2/imgcodecs/ios.h>

@implementation OpenCVWrapper

+(NSString *) openCVVersion {
    return [NSString stringWithFormat:@"OpenCV Version %s", CV_VERSION];
}

+(UIImage *) grayscale:(UIImage *)image {
    cv::Mat imageMat;
    UIImageToMat(image, imageMat);
    
    cv::Mat grayMat;
    cv::cvtColor(imageMat, grayMat, CV_BGR2GRAY);
    
    return MatToUIImage(grayMat);
}

+(UIImage *) haarcascade:(UIImage *)image {
    //Path to the training parameters for frontal face detector
    NSString *faceCascadePath = [[NSBundle mainBundle] pathForResource:@"haarcascade_frontalface_alt" ofType:@"xml"];
    printf("%s", faceCascadePath);
    const CFIndex CASCADE_NAME_LEN = 2048;
    char *CASCADE_NAME = (char *) malloc(CASCADE_NAME_LEN);
    CFStringGetFileSystemRepresentation( (CFStringRef)faceCascadePath, CASCADE_NAME, CASCADE_NAME_LEN);
    cv::CascadeClassifier faceDetector;
    
    /*if(!faceDetector.load("haarcascade_frontalface_alt.xml")) {printf("Error loading haar cascade"); return image;}*/
    
    cv::Mat img;
    UIImageToMat(image, img);
    cv::cvtColor(img, img, CV_BGRA2GRAY);
    std::vector<cv::Rect> faceRects;
    cv::Size minimumSize(30,30);
    
    cv::equalizeHist(img, img);
    
    try {
        faceDetector.detectMultiScale(img, faceRects,
                                  1.1, 2, 0|CV_HAAR_SCALE_IMAGE,
                                      cv::Size(30, 30) );
    }
    catch (cv::Exception & e) {
        NSLog(@"Error: %@", [NSThread callStackSymbols]);
        
        return image;
    }
    for(int i = 0; i < faceRects.size(); i++) {
        cv::Point center(faceRects[i].x + faceRects[i].width*0.5,
                         faceRects[i].y + faceRects[i].height*0.5);
        cv::ellipse(img, center, cv::Size(faceRects[i].width*0.5, faceRects[i].height*0.5), 0, 0, 360, cv::Scalar(255, 0, 0), 4, 8, 0);
    }
    
    return MatToUIImage(img);
}
@end
