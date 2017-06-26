//
//  CustomCamerButton.h
//  ImagePicker
//
//  Created by fenglongteng on 16/6/30.
//
//

#import <UIKit/UIKit.h>

typedef void (^PickerSeletedImageBlock)(UIImage*);

@interface CustomCamerButton : UIButton<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
#pragma mark xib是使用

//当前window上显示的控制器
@property(nonatomic,weak)UIViewController *customVC;

//是否开启裁剪功能
@property(nonatomic,assign)BOOL isEdite;

//选择图片回调
@property(nonatomic,copy)PickerSeletedImageBlock pickSeletedImageBlock;

#pragma mark 手动初始化使用

//初始化
-(instancetype)initAddTargetVC:(UIViewController*)viewController AndSeltedCompleteHandle:(PickerSeletedImageBlock)block;

//开启拍照+照片选择功能
-(void)showImagePicker;

@end
