# PreviewImages

####这是一个全屏展示图片的小demo，主要分三种情况来实现：

1. 正常页面中的ImageView
```
///主要使用了这两个方法
+ (void)showImage:(UIImageView*)avatarImageView
{
UIImage *image =avatarImageView.image;
// 获得根窗口
UIWindow *window =[UIApplication sharedApplication].keyWindow;
UIView *backgroundView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ZOOMVCWIDTH, ZOOMVCHEIGHT)];
oldframe =[avatarImageView convertRect:avatarImageView.bounds toView:window];
backgroundView.backgroundColor =[UIColor blackColor];
backgroundView.alpha =0.5;
UIImageView *imageView =[[UIImageView alloc]initWithFrame:oldframe];
imageView.image =image;
imageView.tag =1;
[backgroundView addSubview:imageView];
[window addSubview:backgroundView];
//点击图片缩小的手势
UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
[backgroundView addGestureRecognizer:tap];
[UIView animateWithDuration:0.3 animations:^{
imageView.frame =CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
backgroundView.alpha =1;
}];
}


+ (void)hideImage:(UITapGestureRecognizer *)tap{
UIView *backgroundView =tap.view;
UIImageView *imageView =(UIImageView *)[tap.view viewWithTag:1];
[UIView animateWithDuration:0.3 animations:^{
imageView.frame =oldframe;
backgroundView.alpha =0;
} completion:^(BOOL finished) {
[backgroundView removeFromSuperview];
}];
}
```

2. Tableview的cell上的图片
```
///tableview cell这个，主要使用了UIView的类方法， animateWithxxx
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

```
3. CollectioinView的cell上的图片
```
collection使用了一个第三方，冯大师的PhotoBroswer
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
```

