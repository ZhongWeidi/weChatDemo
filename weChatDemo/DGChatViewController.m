//
//  DGChatViewController.m
//  weChatDemo
//
//  Created by 钟伟迪 on 15/11/7.
//  Copyright © 2015年 钟伟迪. All rights reserved.
//

#import "DGChatViewController.h"
#import "DGChatTableViewCell.h"
#import "MessageInfo.h"
#import "DGImageViewerView.h"
#import "DGMessageImageView.h"

@interface DGChatViewController ()<DGChatTableViewCellDelegate>


@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong , nonatomic)NSMutableArray *messages;


@end

@implementation DGChatViewController

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
        
    MessageInfo * m1 =[MessageInfo new];
    m1.content = @"Copyright © 2015年.";
    m1.type = DGMessageTypeText;
    m1.isRight = YES;
    m1.headerImagePath = @"6.jpg";
    
    
    MessageInfo * m2 =[MessageInfo new];
    m2.content = [[NSBundle mainBundle] pathForResource:@"2" ofType:@"jpg"];
    m2.type = DGMessageTypeImage;
    m2.isRight = NO;
    m2.headerImagePath = @"5.jpg";
    
    
    MessageInfo * m3 =[MessageInfo new];
    m3.content = @"据国外媒体报道，火星大气与挥发物演化任务(MAVEN)探测器将完成10个月的空间飞行，预计在9月21日进入预定轨道。MAVEN探测器的首席科学家布鲁斯认为我们致力于观察火星的高层大气，并研究太阳与太阳风之间相互作用的机制，这项任务将揭开火星大气为何丢失的奥秘.";
    m3.type = DGMessageTypeText;
    m3.isRight = NO;
    m3.headerImagePath = @"2.jpg";
    
    
    MessageInfo * m4 =[MessageInfo new];
    m4.content = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"jpg"];
    m4.type = DGMessageTypeAudion;
    m4.isRight = NO;
    m4.headerImagePath = @"2.jpg";
    
    MessageInfo * m5 =[MessageInfo new];
    m5.content = [[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"];
        m5.type = DGMessageTypeImage;
    m5.isRight = YES;
    m5.headerImagePath = @"5.jpg";
    
    MessageInfo * m6 =[MessageInfo new];
    m6.content =  [[NSBundle mainBundle] pathForResource:@"5" ofType:@"jpg"];
    m6.type = DGMessageTypeImage;
    m6.isRight = NO;
    m6.headerImagePath = @"6.jpg";
    
    MessageInfo * m7 =[MessageInfo new];
    m7.content = @"2014年9月20日左右，MAVEN探测器将进入火星轨道，美国宇航局又多了一个火星资产，MAVEN探测器将与好奇号联手共同对火星大气进行研究，此外，美国宇航局还有机遇号、奥德赛号、火星侦察轨道器等，它们的总造价达40亿美元以上，包括两艘火星轨道飞船和两辆火星车，欧洲空间局还有“火星快车”探测器";
    m7.type = DGMessageTypeText;
    m7.isRight = YES;
    m7.headerImagePath = @"6.jpg";
    
    
    MessageInfo * m8 = [MessageInfo new];
    m8.content = [[NSBundle mainBundle] pathForResource:@"videos" ofType:@"mov"];
    m8.type = DGMessageTypeVideo;
    m8.isRight = NO;
    m8.headerImagePath = @"5.jpg";
        
    MessageInfo * m9 = [MessageInfo new];
    m9.content = [[NSBundle mainBundle] pathForResource:@"videos" ofType:@"mov"];
    m9.type = DGMessageTypeAudion;
    m9.isRight = YES;
    m9.headerImagePath = @"5.jpg";
        
        
    
    NSArray * array = @[m1,m2,m3,m4,m5,m6,m7,m8,m9];
    self.messages = [NSMutableArray arrayWithArray:array];

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.user.name;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * identifier = @"MyCell";
    DGChatTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[DGChatTableViewCell alloc] initWithDelegate:self reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    
//    cell.selectionStyle = 0;
    
    MessageInfo * m = self.messages[indexPath.row];
    cell.message = m;
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageInfo * message = self.messages[indexPath.row];
    CGFloat  height = [DGChatTableViewCell heightForRowAtIndexPath:indexPath withMessageModel:message];
    
    return height;
}

#pragma mark - DGChatTableViewCellDelegate
- (void)dgTableView:(UITableView *)tableView selectedChatTableViewWithIndexPath:(NSIndexPath *)indexPath{

    MessageInfo * info = self.messages[indexPath.row];
    
    if (info.type == DGMessageTypeVideo) {
        [self openMovie:info.content];
    }else if (info.type == DGMessageTypeImage){
        DGChatTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        DGImageViewerView * imageViewer = [[DGImageViewerView alloc] initWithFrame:self.view.bounds];
        imageViewer.imageForViews = @[cell.backgourdImageView];
        imageViewer.showIndex = 0;
        imageViewer.imagePahts = @[info.content];
        
        [imageViewer show:YES animation:YES];
        
    }else if (info.type == DGMessageTypeAudion){
    
        DGChatTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell.backgourdImageView.audioImageView startAnimating];
    }
}


-(void)openMovie:(NSString *)url
{
    MPMoviePlayerViewController *playerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:url]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(movieFinishedCallback:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:playerViewController];
    
    
    [self presentViewController:playerViewController animated:NO completion:^{
        MPMoviePlayerController *player = [playerViewController moviePlayer];
        
        [player play];

    }];
    

}

//播放完毕删除
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    
    MPMoviePlayerViewController *playerController = [aNotification object];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:playerController];
    
    MPMoviePlayerController *player = [playerController moviePlayer];

    [player stop];
    
    [playerController dismissViewControllerAnimated:YES completion:nil];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
