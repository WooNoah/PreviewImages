//
//  ThirdViewController.m
//  ScaleDemo
//
//  Created by tb on 16/12/29.
//  Copyright © 2016年 com.tb. All rights reserved.
//

#import "ThirdViewController.h"
#import "ThirdCollectionCell.h"

#import "PhotoBroswerVC.h"

#define RGBColor(r , g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0 ]
#define RandomColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface ThirdViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    ThirdCollectionCell
    
    self.dataArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15"].mutableCopy;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ThirdCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ThirdCollectionCell"];
}

#pragma mark - 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ThirdCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ThirdCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.pictureImgView.backgroundColor = RandomColor;
    cell.pictureImgView.userInteractionEnabled = YES;
    cell.pictureImgView.tag = indexPath.item;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [cell.pictureImgView addGestureRecognizer:tap];
    return cell;
}

#pragma mark -
- (void)tapAction:(UITapGestureRecognizer *)recognizer {

    UIImageView *cell = (UIImageView *)recognizer.view;
//    ThirdCollectionCell *cell = (ThirdCollectionCell *)recognizer.view.superview.superview;
    [self networkImageShow:cell.tag];
 
}


/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index{
    
//    __weak typeof(self) weakSelf=self;
//    
//    [PhotoBroswerVC show:self type:PhotoBroswerVCTypePush index:index photoModelBlock:^NSArray *{
//        
//        NSArray *localImages = weakSelf.images;
//        
//        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
//        for (NSUInteger i = 0; i< localImages.count; i++) {
//            
//            PhotoModel *pbModel=[[PhotoModel alloc] init];
//            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
//            pbModel.image = localImages[i];
//            
//            //源frame
//            UIImageView *imageV =(UIImageView *) weakSelf.contentView.subviews[i];
//            pbModel.sourceImageView = imageV;
//            
//            [modelsM addObject:pbModel];
//        }
//        
//        return modelsM;
//    }];
}


/*
 *  展示网络图片
 */
-(void)networkImageShow:(NSUInteger)index{
    
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeModal index:index photoModelBlock:^NSArray *{
        
        
        NSArray *networkImages=@[
                                 @"http://www.netbian.com/d/file/20150519/f2897426d8747f2704f3d1e4c2e33fc2.jpg",
                                 @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
                                 @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
                                 @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
                                 @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
                                 @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
                                 @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
                                 @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
                                 @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
                                 @"http://www.netbian.com/d/file/20130502/701d50ab1c8ca5b5a7515b0098b7c3f3.jpg",
                                 @"http://www.netbian.com/d/file/20110418/48d30d13ae088fd80fde8b4f6f4e73f9.jpg",
                                 @"http://www.netbian.com/d/file/20150318/869f76bbd095942d8ca03ad4ad45fc80.jpg",
                                 @"http://www.netbian.com/d/file/20110424/b69ac12af595efc2473a93bc26c276b2.jpg",
                                 
                                 @"http://www.netbian.com/d/file/20140522/3e939daa0343d438195b710902590ea0.jpg",
                                 
                                 @"http://www.netbian.com/d/file/20141018/7ccbfeb9f47a729ffd6ac45115a647a3.jpg",
                                 ];
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:networkImages.count];
        for (NSUInteger i = 0; i< networkImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
//            pbModel.title = [NSString stringWithFormat:@"这是标题%@",@(i+1)];
//            pbModel.desc = [NSString stringWithFormat:@"我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字我是一段很长的描述文字%@",@(i+1)];
            pbModel.image_HD_U = networkImages[i];
            
            //源frame
            UIImageView *imageV =(UIImageView *) weakSelf.collectionView.subviews[i];
            pbModel.sourceImageView = imageV;
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}



#pragma mark -
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 5.f;
        layout.minimumLineSpacing = 5.f;
        layout.itemSize = CGSizeMake(100, 120);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
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
