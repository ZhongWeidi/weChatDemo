//
//  MessageInfo.h
//  QQ
//
//  Created by 钟伟迪 on 15/11/6.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import <Foundation/Foundation.h>


//你可以使用自己数据模型，但必需遵循此协议。必需需要这2个属性
@protocol MessageInfo <NSObject>

@property DGMessageType type;

@property BOOL isRight;


@end

@interface MessageInfo : NSObject<MessageInfo>

@property NSString * headerImagePath;

@property BOOL isRight;

@property NSString * content;

@property DGMessageType type;

@end
