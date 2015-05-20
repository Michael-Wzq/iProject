//
//  FeedBackViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/24.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import "FeedBackViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface FeedBackViewController ()<UITextViewDelegate>

@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data = [NSUserDefaults standardUserDefaults];
    CALayer *layer1=[self.cancel layer];
    layer1.cornerRadius=5.0f;
    CALayer *layer2=[self.submit layer];
    layer2.cornerRadius=5.0f;
    self.feedBackTextView.delegate=self;
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
    [self.feedBackTextView resignFirstResponder];
}



- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)submitButton:(id)sender {
    [SVProgressHUD showWithStatus:@"发送反馈中"];
    
    NSDictionary *parameter=@{@"content": self.feedBackTextView.text ,@"person":[self.data objectForKey:@"userAccount"]};
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:[staticStr stringByAppendingString:@"feedback"] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response=(NSDictionary *)responseObject;
        if ([response objectForKey:@"status"])
        {
            
            [SVProgressHUD showSuccessWithStatus:@"反馈成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"反馈失败"];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"反馈信息格式有误"
                                                        delegate:nil cancelButtonTitle:@"重新反馈" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"反馈失败"];
        NSLog(@"%@",error);
    }];
    
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
