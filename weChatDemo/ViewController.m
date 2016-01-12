//
//  ViewController.m
//  weChatDemo
//
//  Created by 钟伟迪 on 15/11/7.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import "ViewController.h"
#import "DGMessageTableViewCell.h"
#import "DGChatViewController.h"
#import "UserInfo.h"
#import "DGMessageImageView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic)NSArray * users;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //分支操作
    
    
    UserInfo * u1 = [UserInfo new];
    u1.name = @"惠明";
    u1.headerImagePath = @"1.jpg";
    u1.time = @"08:31";
    u1.message = @"明天我们什么时候汇合?";
    
    UserInfo * u2 = [UserInfo new];
    u2.name = @"流苏";
    u2.headerImagePath = @"2.jpg";
    u2.time = @"09:44";
    u2.message = @"这样不好吧";

    UserInfo * u3 = [UserInfo new];
    u3.name = @"龙惠民";
    u3.headerImagePath = @"3.jpg";
    u3.time = @"11:41";
    u3.message = @"或许可以考虑下";

    UserInfo * u4 = [UserInfo new];
    u4.name = @"小包子";
    u4.headerImagePath = @"4.jpg";
    u4.time = @"21:40";
    u4.message = @"在不？";

    UserInfo * u5 = [UserInfo new];
    u5.name = @"白虎";
    u5.headerImagePath = @"5.jpg";
    u5.time = @"22:30";
    u5.message = @"怎么可能呢";

    UserInfo * u6 = [UserInfo new];
    u6.name = @"漏屋";
    u6.headerImagePath = @"6.jpg";
    u6.time = @"23:17";
    u6.message = @"明天怎么办";

    self.users = @[u1,u2,u3,u4,u5,u6];
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.users.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"MessageCell";
    DGMessageTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    UserInfo * info = self.users[indexPath.row];
    cell.headerImageView.image = [UIImage imageNamed:info.headerImagePath];
    cell.nameLabel.text = info.name;
    cell.timeLabel.text = info.time;
    cell.messageLabel.text = info.message;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"showChat" sender:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showChat"]) {
        DGChatViewController * chatViewController = segue.destinationViewController;
        chatViewController.user = self.users[[sender row]];
    }

}

@end
