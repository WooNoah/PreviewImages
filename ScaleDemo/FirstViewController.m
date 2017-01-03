//
//  FirstViewController.m
//  ScaleDemo
//
//  Created by tb on 16/12/29.
//  Copyright © 2016年 com.tb. All rights reserved.
//

#import "FirstViewController.h"
#import <QuartzCore/QuartzCore.h>

#import "ZoomImage.h"

//设置放大后图片的宽高，为了省时间，偷了下懒，建议最好结合实际做下运算
#define BIG_IMG_WIDTH  325
#define BIG_IMG_HEIGHT 325

@interface FirstViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *minImageView;

@property (nonatomic,strong) IBOutlet UIImageView *testImgView;

@end

@implementation FirstViewController{
    UIView *background;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //允许用户交互
    _minImageView.userInteractionEnabled = YES;
    //添加点击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [_minImageView addGestureRecognizer:tapGesture];
    
    self.testImgView.userInteractionEnabled = YES;
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(testTapAction)];
    [self.testImgView addGestureRecognizer:tap];
}

- (void)testTapAction {
    [ZoomImage showImage:self.testImgView];
}

//点击图片后的方法(即图片的放大全屏效果)
- (void) tapAction{
    
    [ZoomImage showImage:self.minImageView];
    return;
    
    //创建一个黑色背景
    //初始化一个用来当做背景的View。我这里为了省时间计算，宽高直接用的5s的尺寸
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 600)];
    background = bgView;
    [bgView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:bgView];
    
    //创建显示图像的视图
    //初始化要显示的图片内容的imageView（这里位置继续偷懒...没有计算）
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
    //要显示的图片，即要放大的图片
    [imgView setImage:[UIImage imageNamed:@"landscape"]];
    [bgView addSubview:imgView];
    
    imgView.userInteractionEnabled = YES;
    //添加点击手势（即点击图片后退出全屏）
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeView)];
    [imgView addGestureRecognizer:tapGesture];
    
    [self shakeToShow:bgView];//放大过程中的动画
}


-(void)closeView{
    [background removeFromSuperview];
}


//放大过程中出现的缓慢动画
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
