//
//  ViewController.m
//  ScaleDemo
//
//  Created by tb on 16/12/28.
//  Copyright © 2016年 com.tb. All rights reserved.
//

#import "ViewController.h"

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)toTabview:(id)sender {
    [self.navigationController pushViewController:[[SecondViewController alloc]init] animated:YES];
}


- (IBAction)toCollectionView:(id)sender {
    [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
