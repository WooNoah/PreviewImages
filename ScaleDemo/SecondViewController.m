//
//  SecondViewController.m
//  ScaleDemo
//
//  Created by tb on 16/12/29.
//  Copyright © 2016年 com.tb. All rights reserved.
//

#import "SecondViewController.h"
#import "SecTableViewCell.h"

@interface SecondViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tabView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@property (nonatomic,assign) CGRect oldFrame;

@property (nonatomic,strong) UIImageView *bigImgView;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tabView.backgroundColor = [UIColor lightGrayColor];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    [self.tabView registerNib:[UINib nibWithNibName:@"SecTableViewCell" bundle:nil] forCellReuseIdentifier:@"SecTableViewCell"];
    [self.view addSubview:self.tabView];
    
    self.bigImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.bigImgView.backgroundColor=[UIColor blackColor];
    self.bigImgView.userInteractionEnabled=YES;
    [self.bigImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap2:)]];
    self.bigImgView.contentMode=UIViewContentModeScaleAspectFit;
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"SecTableViewCell";
    SecTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[SecTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.imgV1.userInteractionEnabled = YES;
        [cell.imgV1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
    }
    cell.imgV1.userInteractionEnabled = YES;
    [cell.imgV1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)]];
    cell.imgV1.image=[UIImage imageNamed:@"1.png"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200.f;
}


- (void)actionTap:(UITapGestureRecognizer *)sender{
    CGPoint location = [sender locationInView:self.tabView];
    NSIndexPath *indexPath  = [self.tabView indexPathForRowAtPoint:location];
    UITableViewCell *cell = (UITableViewCell *)[self.tabView  cellForRowAtIndexPath:indexPath];

    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:9999];
    
    //小图的frame
    self.oldFrame = CGRectMake(cell.frame.origin.x+imageView.frame.origin.x, cell.frame.origin.y+imageView.frame.origin.y-self.tabView.contentOffset.y, imageView.frame.size.width, imageView.frame.size.height); //得到cell上的图片位置
    
    if (![self.bigImgView superview]) {
        
        self.bigImgView.image = imageView.image;
        
        [self.view.window addSubview:self.bigImgView];
        
        
        
        self.bigImgView.frame = self.oldFrame;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.bigImgView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
            
        } completion:^(BOOL finished) {
            
            [UIApplication sharedApplication].statusBarHidden=YES;
            
        }];
        
    }
    
    
}


-(void)actionTap2:(UITapGestureRecognizer *)sender{
    
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.bigImgView.frame = self.oldFrame;
        
        
    } completion:^(BOOL finished) {
        
        [self.bigImgView removeFromSuperview];
        
    }];
    
    
    [UIApplication sharedApplication].statusBarHidden=NO;
    
    
    
}


- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"1",@"2",@"3",@"4",@"5"];
    }
    return _dataArr;
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
