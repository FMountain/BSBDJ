//
//  A3SeeBigViewController.m
//  BSBDJ
//
//  Created by mac on 15/11/3.
//  Copyright © 2015年 mac. All rights reserved.
//

#import "A3SeeBigViewController.h"
#import "A3Topic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import <Photos/Photos.h>

@interface A3SeeBigViewController ()<UIScrollViewDelegate>
@property (nonatomic,weak)UIImageView *imageView;
@end

@implementation A3SeeBigViewController

static NSString *const A3CollectionName = @"-百思不得姐";

- (void)viewDidLoad {
    [super viewDidLoad];
    //scrollView
    UIScrollView *scrollView = [[UIScrollView alloc ]init];
    scrollView.delegate = self;
    scrollView.frame = [UIScreen mainScreen].bounds;
    [self.view insertSubview:scrollView atIndex:0];
    
    //imageView
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
    imageView.width = scrollView.width;
    imageView.height = self.topic.height * imageView.width / self.topic.width;
    imageView.x = 0;
    if (imageView.height >= scrollView.height) {
        //图片高度超过整个屏幕
        imageView.y = 0;
        
    }else {
        //居中显示
        imageView.centerY = scrollView.height * 0.5;
    }
    [scrollView addSubview:imageView];
    self.imageView = imageView;
    
    //滚动范围
    scrollView.contentSize = CGSizeMake(0, imageView.height);
    
    //缩放比例
    CGFloat maxScale = self.topic.height / imageView.height;
    
    if (maxScale > 1.0) {
        scrollView.maximumZoomScale = maxScale;
    }
    
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save{
////存储图片到 相机胶卷
//    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //.判断状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) { //用户拒绝 访问相册
        
        A3Log(@"用户拒绝当前应用访问相册 - 提醒用户打开访问开关");
    }else if ( status == PHAuthorizationStatusRestricted){ //家长控制
        A3Log(@"家长控件 - 不允许访问");
    }else if ( status == PHAuthorizationStatusNotDetermined){ //用户还没有做出选择
        A3Log(@"用户还没有做出选择");
        [self saveImage];
    
    }else if (status == PHAuthorizationStatusAuthorized)
    {
        A3Log(@"用户允许当前应用访问相册 ");
        [self saveImage];
    }
}
/**
 保存图片到相册
 */
- (void)saveImage
{
    /**
     PHAseet :一个PHAseet对象就代表一个资源文件,比如一张图片
     PHAseetCollection : 一个PHAseetCollection对象就代表一个相册
     */
    __block NSString *assetId = nil;
    
    //1.存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary]
        performChanges:^{ //这个block里面存放一些"修改"性质的代码
            //新建一个PHAseetCreationRequest 对象,保存图片到"相机胶卷"
            //返回PHAseet(图片)的字符串标识
            assetId = [PHAssetCreationRequest creationRequestForAssetFromImage:self.imageView.image].placeholderForCreatedAsset.localIdentifier;
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                A3Log(@"保存图片到相机胶卷中失败");
                return ;
            }
            A3Log(@"成功保存图片到相机胶卷中");
            
            //获得相册对象
            PHAssetCollection *collection = [self collection];
            
            //3.将相机胶卷中的图片 添加到 新的相册
            [[PHPhotoLibrary sharedPhotoLibrary]
                performChanges:^{
                    PHAssetCollectionChangeRequest *reqeust = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
                    //根据唯一标识获得相片对象
                    PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
                    //添加图片到相册中
                    [reqeust addAssets:@[asset]];
                } completionHandler:^(BOOL success, NSError * _Nullable error) {
                    if (error) {
                        A3Log(@"保存图片到相册失败");
                        return ;
                    }
                    A3Log(@"成功保存图片到相册中");
                    [[NSOperationQueue mainQueue]
                    addOperationWithBlock:^{
                        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
                    }];
                }];
        }];
}
/**
 *  返回相册
 */
- (PHAssetCollection *)collection
{
    //先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:A3CollectionName]) {
            return collection;
        }
    }
    //如果相册不存在,就他创建新的相册(文件夹)
    __block NSString *collectionId = nil;
    //这个方法会在相册 创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary]
    performChangesAndWait:^{
        // 新建一个PHAssetCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:A3CollectionName].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    return  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}

#pragma mark - UIScrollViewDelegate
/**
 *  返回一个 scrollView内部的子控件进行缩放
 */
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return  self.imageView;
}
@end
