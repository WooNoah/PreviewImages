//
//  ZoomImage.h
//  ScaleDemo
//
//  Created by tb on 16/12/28.
//  Copyright © 2016年 com.tb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZoomImage : NSObject

/**
 *@brief点击图片放大,再次点击缩小
 *
 *@param avatarImageView 头像所在的imageView
 */
+ (void)showImage:(UIImageView*)avatarImageView;

@end
