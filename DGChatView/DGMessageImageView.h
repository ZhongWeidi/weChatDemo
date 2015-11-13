//
//  DGMessageImageView.h
//  QQ
//
//  Created by 钟伟迪 on 15/11/6.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>


@interface DGMessageImageView : UIView

@property (assign , nonatomic)BOOL isRight;

@property (strong , nonatomic) UIImage * image;


@property (assign ,nonatomic)  CGFloat arrowsStart;//箭头起始y位置

@property (strong , nonatomic) UIColor* color;

@property (strong , nonatomic) UIColor* borderColor;

@property (assign , nonatomic) CGFloat borderWidth;

@property (assign , nonatomic)DGMessageType type;

@property (strong , nonatomic)UIImageView *audioImageView;

@property (strong , nonatomic) UIImageView * playImageView;


//取得视频的第一帧
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

@end
