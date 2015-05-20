//
//  RepairsViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/2/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "RepairsViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"

@interface RepairsViewController ()<UITextViewDelegate,UIActionSheetDelegate>
@property (strong,nonatomic) UIActionSheet *sheet;
@property (strong,nonatomic) NSString  *imageUrl;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/repair";
@implementation RepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [NSUserDefaults standardUserDefaults];
    CALayer *layer1=[self.cancalButton layer];
    layer1.cornerRadius=5.0f;
    CALayer *layer2=[self.confirmButton layer];
    layer2.cornerRadius=5.0f;
    self.repairContent.delegate=self;
}
/*
 -(void)viewDidLayoutSubviews
 {
 
 }
 */
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
    self.placeHolder.hidden=YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.placeHolder.hidden=NO;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.repairContent resignFirstResponder];
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButton:(id)sender {
    [SVProgressHUD showWithStatus:@"发送报修问题中"];
    NSDictionary *parameter=@{@"person":[self.data objectForKey:@"userAccount"],@"content": self.repairContent.text ,@"image" : self.imageUrl };
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:staticStr parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response=(NSDictionary *)responseObject;
        if ([response objectForKey:@"status"])
        {
            [SVProgressHUD showSuccessWithStatus:@"报修成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"报修失败"];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"报修信息格式有误"
                                                        delegate:nil cancelButtonTitle:@"重新报修" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"报修失败"];
        NSLog(@"%@",error);
    }];
    
}










- (IBAction)callImage:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"从摄像机拍摄"
                                  otherButtonTitles:@"从相片选取",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    actionSheet.tag = 255;
    [actionSheet showInView:self.view];
    
}
    
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 2:
                    // 取消
                    return;
                case 0:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else if(buttonIndex == 1) {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            } else{
                return;
            }
        }

        // 跳转到相机或相册页面
    
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}
#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地，方法见下文
//    [self saveImage:image withName:@"currentImage.png"];
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    isFullScreen = NO;
    NSLog(@"%@",image);
    [self.repairPhoto setBackgroundImage:image forState:0];
    
    
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


















@end
