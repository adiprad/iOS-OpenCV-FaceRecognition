//
//  OpenCVWrapper.h
//  CameraCaptureApp
//
//  Created by Adithya Pradosh on 11/6/16.
//  Copyright © 2016 adiprad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OpenCVWrapper : NSObject

+(NSString *) openCVVersion;

+(UIImage *) grayscale:(UIImage *)image;

+(UIImage *) haarcascade:(UIImage *)image;

@end
