//
//  DGMessageTableViewCell.m
//  weChatDemo
//
//  Created by 钟伟迪 on 15/11/7.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import "DGMessageTableViewCell.h"

@implementation DGMessageTableViewCell

- (void)awakeFromNib {
    self.headerImageView.layer.cornerRadius = 5.0f;
    self.headerImageView.layer.masksToBounds = YES;
    self.headerImageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.headerImageView.bounds].CGPath;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
