//
//  PushAllMesViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 3/21/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "PushAllMesViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface PushAllMesViewController ()

@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation PushAllMesViewController

- (void)viewDidLoad{
    
    
    
    
    [super viewDidLoad];
    self.data = [NSUserDefaults standardUserDefaults];
    CALayer *layer1=[self.cancelButton layer];
    layer1.cornerRadius=5.0f;
    CALayer *layer2=[self.confirmButton layer];
    layer2.cornerRadius=5.0f;
    self.textContent.delegate=self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textContent resignFirstResponder];
}


- (IBAction)pushMes:(id)sender {
    [SVProgressHUD showWithStatus:@"发送中"];
    
    NSDictionary *parameter=@{@"title":[self.titleLabel.text
                                        ],@"person":[self.data objectForKey:@"userAccount"],@"content": self.textContent.text,@"type":@"1",@"receiver":@"-1"};
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:[staticStr stringByAppendingString:@"addpush"] parameters: parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response=(NSDictionary *)responseObject;
        if ([[response objectForKey:@"status"]intValue ] ==1)
        {
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"发送信息格式有误"
                                                        delegate:nil cancelButtonTitle:@"重新发送" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        NSLog(@"%@",error);
    }];
    
    
    
}





- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
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
