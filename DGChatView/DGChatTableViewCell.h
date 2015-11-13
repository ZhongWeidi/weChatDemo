//
//  DGChatTableViewCell.h
//  weChatDemo
//
//  Created by 钟伟迪 on 15/11/7.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageInfo.h"


#define CONTENT_WIDTH  ([UIScreen mainScreen].bounds.size.width - 100.0f) //内容最大宽度
#define IMAGE_MAX_WIDTH   ([UIScreen mainScreen].bounds.size.width - 200.0f)//图片最大宽度
#define CONETNT_MIN_WIDTH 50.0f //内容最小宽度
#define CONETNT_MAX_HEIGHT 40.0f //内容最小高度
#define TEXT_FONT         15.0f //字体大小


@class DGChatTableViewCell,DGMessageImageView;

@protocol  DGChatTableViewCellDelegate <NSObject>

@optional

- (void)dgTableView:(UITableView *)tableView selectedChatTableViewWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface DGChatTableViewCell : UITableViewCell

- (id)initWithDelegate:(id)delegate reuseIdentifier:(NSString *)reuseIdentifier;


//消息内容
@property (strong , nonatomic)MessageInfo * message;

@property (weak , nonatomic) id <DGChatTableViewCellDelegate> delegate;


//是否靠右
@property (assign , nonatomic) BOOL isRight;

@property (assign , nonatomic) DGMessageType messageType;


@property (strong , nonatomic)DGMessageImageView * backgourdImageView;//背景图

@property (strong  , nonatomic)UILabel * messageLabel;


@property (strong , nonatomic) UIImageView * headerImageView;



+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath withMessageModel:(MessageInfo *)meesage;




@end
