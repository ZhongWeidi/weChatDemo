//
//  DGChatTableViewCell.m
//  weChatDemo
//
//  Created by 钟伟迪 on 15/11/7.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import "DGChatTableViewCell.h"
#import "DGMessageImageView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width //屏幕宽度

#if 0

#define RIGHT_BUBBLE_NAME @"rightPaoPao" //右边气泡名字
#define LEFT_BUBBLE_NAME @"leftPaoPao"  //左边气泡名字

#endif

#define DEFAULT_HEADER_NAME @"defaultHeader.jpg" //默认头像图片名
#define RIGHT_BUBBLE_COLOR  [UIColor colorWithRed: 0.62 green: 0.91 blue: 0.392 alpha: 1] //右边气泡颜色
#define LEFT_BUBBLE_COROL [UIColor colorWithWhite:1.0 alpha:1.0] //左边气泡颜色



static  CGFloat _headerImageSpace = 5.0f;//头像离左右间歇

static  CGFloat _topOrButtomSpace = 3.0f;//气泡与文字上下间隙
static  CGFloat _leftOrRight = 20.0f;//气泡与文字左右间隙

static  CGFloat _ContentSpace = 70.0f;//内容距边界间隙


@interface DGChatTableViewCell()


@end

@implementation DGChatTableViewCell

- (id)initWithDelegate:(id)delegate reuseIdentifier:(NSString *)reuseIdentifier{
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.delegate = delegate;
    }
    return self;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}



- (void)awakeFromNib {
    
}
#pragma mark - get
- (DGMessageImageView *)contentImageView{
    if (!_contentImageView) {
        _contentImageView = [[DGMessageImageView alloc] init];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerWithContentImageView:)];
        [_contentImageView addGestureRecognizer:tap];
        [self.contentView addSubview:_contentImageView];
    }
    return _contentImageView;
}

//文本消息
- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel =  [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CONTENT_WIDTH, 30)];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont systemFontOfSize:TEXT_FONT];
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentJustified;
        [self.contentView addSubview:_messageLabel];
        [_messageLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        
        
    }
    return _messageLabel;
}

//气泡背景图
- (DGMessageImageView *)backgourdImageView{
    if (!_backgourdImageView) {
        _backgourdImageView = [[DGMessageImageView alloc] initWithFrame:CGRectMake(5, 5, CONTENT_WIDTH + 30, 40)];
        _backgourdImageView.image = [UIImage new];
        _backgourdImageView.isRight = self.message.isRight;
        _backgourdImageView.borderColor = [UIColor grayColor];
        _backgourdImageView.borderWidth = 0.25f;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerWithContentImageView:)];
        [_backgourdImageView addGestureRecognizer:tap];
        [self.contentView insertSubview:_backgourdImageView atIndex:0];
    }
    
    return _backgourdImageView;
}

//头像
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake( _headerImageSpace, 5, 40, 40)];
        _headerImageView.image = [UIImage imageNamed:DEFAULT_HEADER_NAME];
        _headerImageView.layer.cornerRadius = 5.0f;
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_headerImageView.frame].CGPath;
        
        [self.contentView addSubview:_headerImageView];
    }
    return _headerImageView;
}


#pragma mark - set
- (void)setMessage:(MessageInfo *)message{
    _message = message;
    self.isRight = message.isRight;
    self.messageType = message.type;
    self.headerImageView.image = [UIImage imageNamed:message.headerImagePath];
}

//主要设置头像位置
- (void)setIsRight:(BOOL)isRight{
    _isRight = isRight;
    CGRect rect = self.headerImageView.frame;
    
    self.backgourdImageView.isRight = self.isRight;
    self.backgourdImageView.image = [UIImage new];
    
    if (isRight) {
        self.backgourdImageView.color = RIGHT_BUBBLE_COLOR;
        self.contentImageView.color = RIGHT_BUBBLE_COLOR;
        rect.origin.x = SCREEN_WIDTH - rect.size.width - _headerImageSpace;
    }
    else{
        self.backgourdImageView.color = LEFT_BUBBLE_COROL;
        self.contentImageView.color = LEFT_BUBBLE_COROL;

        rect.origin.x = _headerImageSpace;
    }
    
    self.headerImageView.frame = rect;
}


- (void)setMessageType:(DGMessageType)messageType{
    
    
    switch (messageType) {
            
        case DGMessageTypeText:
        {
            self.messageLabel.hidden = NO;
            self.backgourdImageView.hidden = NO;
            self.contentImageView.hidden = YES;
            self.messageLabel.text = self.message.content;
        }
            break;
            
        case DGMessageTypeImage:
        {
            self.messageLabel.hidden = YES;
            self.backgourdImageView.hidden = YES;
            self.contentImageView.hidden = NO;
            self.contentImageView.image = [UIImage imageWithContentsOfFile:self.message.content];
            self.contentImageView.isRight = self.message.isRight;
            self.contentImageView.type = DGMessageTypeImage;
            self.contentImageView.frame = [DGChatTableViewCell contentImageRect:self.contentImageView.image];
            [self imageTypeWithView:self.contentImageView];
        }
            
            break;
            
        case DGMessageTypeVideo:
        {
            self.messageLabel.hidden = YES;
            self.backgourdImageView.hidden = YES;
            self.contentImageView.hidden = NO;

            NSURL * url = [NSURL fileURLWithPath:self.message.content];
            UIImage * image = [DGMessageImageView thumbnailImageForVideo:url atTime:0];
            self.contentImageView.image = image;
            self.contentImageView.isRight = self.message.isRight;
            self.contentImageView.type = DGMessageTypeVideo;
            self.contentImageView.frame = [DGChatTableViewCell contentImageRect:self.contentImageView.image];
            [self imageTypeWithView:self.contentImageView];
        
        }
            
            break;
            
        case DGMessageTypeDate:
            
            
            break;
            
        case DGMessageTypeAudion:
        {
            self.messageLabel.hidden = YES;
            self.backgourdImageView.hidden = NO;
            self.contentImageView.hidden = YES;
            
            self.backgourdImageView.image = [UIImage new];
            self.backgourdImageView.isRight = self.message.isRight;
            self.backgourdImageView.type = DGMessageTypeAudion;
            self.backgourdImageView.frame = CGRectMake(0, 0, 100, CONETNT_MAX_HEIGHT);
            [self imageTypeWithView:self.backgourdImageView];


        }
            break;
            
            
        default:
            break;
    }
    
    
    
}

#pragma mark - Action
- (void)tapGestureRecognizerWithContentImageView:(UITapGestureRecognizer *)tap{
 
    
    if ([self.delegate respondsToSelector:@selector(dgTableView:selectedChatTableViewWithIndexPath:)]) {
        UIView * view = self.superview;
        
        while (![view isKindOfClass:[UITableView class]]) {
            view = view.superview;
        }
        
        UITableView * tableView = (UITableView *)view;
        NSIndexPath * indexPath = [tableView indexPathForCell:self];
        
        [self.delegate dgTableView:tableView selectedChatTableViewWithIndexPath:indexPath];

    }
}


///////////////重新计算图片的位置////////////////////
- (void)imageTypeWithView:(UIView *)view{
    CGRect rect = view.frame;
    
    rect.origin.y = 8;//图片离顶部距离
    if (self.isRight) {
        rect.origin.x = SCREEN_WIDTH - rect.size.width - _ContentSpace + 20;
    }else{
        rect.origin.x = _ContentSpace - 20;
    }
    view.frame = rect;
}


///////////////////////////////////


////////////////计算文本的位置///////////////////
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    NSString * s = self.messageLabel.text;
    CGRect rect = [s boundingRectWithSize:CGSizeMake(CONTENT_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TEXT_FONT]} context:nil];
    
    [self textTypeWithFrame:rect];
}

//设置文本风格内容
- (void)textTypeWithFrame:(CGRect)rect{
    
    if (rect.size.width < 30)rect.size.width = 30.0f;
        rect.origin.y = 20;//文字离顶部距离为20
    
    
    if (self.isRight) {
        rect.origin.x = SCREEN_WIDTH - rect.size.width - _ContentSpace;
    }else{
        rect.origin.x = _ContentSpace;
    }
    
    self.messageLabel.frame = rect;
    self.backgourdImageView.frame = CGRectMake(rect.origin.x - _leftOrRight, rect.origin.y/2.0f - _topOrButtomSpace + 1 , rect.size.width + _leftOrRight*2, rect.size.height+ rect.origin.y + _topOrButtomSpace);
}
///////////////////////////////////



//计算图片内容大小
+ (CGRect)contentImageRect:(UIImage *)image{
    
    CGRect rect = CGRectZero;
    CGFloat radio = image.size.height/image.size.width;
    
    if (image.size.width > IMAGE_MAX_WIDTH) {
        rect.size.width =  IMAGE_MAX_WIDTH;
        rect.size.height =  IMAGE_MAX_WIDTH * radio;
    }else if(image.size.width < CONETNT_MIN_WIDTH){
        rect.size.width =  CONETNT_MIN_WIDTH;
        rect.size.height = CONETNT_MIN_WIDTH * radio;
    }else{
        rect.size.width = image.size.width ;
        rect.size.height  = image.size.width * radio;
    }
    

    return rect;
    
}

#pragma mark - 计算Cell的高度
+ (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath withMessageModel:(MessageInfo *)meesage{
    
    
    CGFloat height = 0.0f;
    
    switch (meesage.type) {
        case DGMessageTypeText:
        {
            CGRect rect = [meesage.content boundingRectWithSize:CGSizeMake(CONTENT_WIDTH, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TEXT_FONT]} context:nil];
            height = rect.size.height + _topOrButtomSpace*2 + 40;
            
        }
            break;
            
        case DGMessageTypeImage:
        {
            UIImage * image = [UIImage imageWithContentsOfFile:meesage.content];
            
            CGRect imageRect =  [self contentImageRect:image];
            
            height = imageRect.size.height + 20;
            
        }
            
            break;
            
            
        case DGMessageTypeVideo:
        {
            
            NSURL * url = [NSURL fileURLWithPath:meesage.content];
            
            UIImage * image = [DGMessageImageView thumbnailImageForVideo:url atTime:0];
                        
            CGRect imageRect =  [self contentImageRect:image];
            
            height = imageRect.size.height + 20;

        }
            
            break;

        case DGMessageTypeAudion:
            
            height = CONETNT_MAX_HEIGHT + 20;
            
            break;
            
        case DGMessageTypeDate:
            
            break;
            
            
        default:
            break;
    }
    
    
    
    return height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (void)dealloc{
    [self.messageLabel removeObserver:self forKeyPath:@"text"];
    _contentImageView = nil;
    _backgourdImageView = nil;
    _messageLabel =nil;
    _message = nil;
    _headerImageView = nil;
}


@end
