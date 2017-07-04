//
//  ViewController.m
//  YJNavigationBarTest
//
//  Created by cptech on 2017/3/8.
//  Copyright © 2017年 cptech. All rights reserved.
//

#import "ViewController.h"
#import "HeadTableViewCell.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) CGFloat heightOfCell;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint *HeadHeightConstraint;//用来判定大图片的伸缩
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *logoWidthConstraint;//logo的大小缩放
@property (weak, nonatomic) IBOutlet UIImageView *headLogo;

@property (nonatomic, assign) CGFloat oldContentOffSetY;
@end

@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initNavigationBar];
    [self initTableView];
    [self testCode];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Private Methods
- (void)initNavigationBar
{
    //navigationbar全透明
    self.navigationBar.translucent = YES;
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
    //寻找navigationbar上的黑色横线
    UIImageView *imageView = [self findlineviw:self.navigationBar];
    //隐藏
    imageView.hidden = YES;
}
- (void)initTableView
{
//    self.tableView.tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"HeadTableView" owner:self options:nil][0];
    
}
- (void)testCode
{
  
}
//寻找navigationbar上的黑色横线
-(UIImageView*)findlineviw:(UIView*)view{
    
    if ([view isKindOfClass:[UIImageView class]]&&view.bounds.size.height<=1.0) {
        return (UIImageView*) view;
    }for (UIImageView *subview in view.subviews) {
        UIImageView *lineview = [self findlineviw:subview];
        if (lineview) {
            return lineview;
        }
    }
    return nil;
    
}
#pragma mark - Notification


#pragma mark - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
        return 1;
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
        return 300;
    else
        return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        HeadTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HeadTableViewCell" owner:self options:nil][0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"333");
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat nowContentOffSetY = scrollView.contentOffset.y;
    
    /*如果下拉到最顶部时候，拉不动了 顶部图片会进行弹性放大*/
    if( nowContentOffSetY < 0)
    {
        [self.view updateConstraintsIfNeeded];
        self.HeadHeightConstraint.constant = 300+fabs(scrollView.contentOffset.y);
        self.logoWidthConstraint.constant = 80+fabs(scrollView.contentOffset.y/2);
        [self.view layoutIfNeeded];
    }
    /*保证logo的宽度在71到20之间缩放*/
    CGFloat level = 2;//倍率用来控制缩放速度
    if(nowContentOffSetY > 0 && nowContentOffSetY <41*level)
    {
        [self.view updateConstraintsIfNeeded];
        self.logoWidthConstraint.constant = 80-fabs(scrollView.contentOffset.y/level);
        [self.view layoutIfNeeded];
    }
    

//    /*当上滑到第一行图片底部到达导航栏的时候 隐藏导航栏*/
//    if(nowContentOffSetY>300-64)
//    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:.5];
//        self.navigationBar.frame = CGRectMake(0, -64, self.view.bounds.size.width, 44);
//        [UIView commitAnimations];
//    }
//    /* 下滑显示导航栏 */
//    if(_oldContentOffSetY > nowContentOffSetY)
//    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:.5];
//        self.navigationBar.frame = CGRectMake(0, 20, self.view.bounds.size.width, 44);
//        [UIView commitAnimations];
//    }
//    
//    _oldContentOffSetY = scrollView.contentOffset.y;

}
#pragma mark - Responder Event
//点击导航栏上的button
- (IBAction)clickNavigationBar:(id)sender {
    
    NSLog(@"点击");
}



#pragma mark - Getter Setter
- (CGFloat)heightOfCell
{
    if(!_heightOfCell)
    {
        _heightOfCell = 100;
    }
    return _heightOfCell;
}




@end
