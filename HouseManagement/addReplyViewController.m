//
//  addReplyViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/2/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "addReplyViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation addReplyViewController



- (void)viewDidLoad{
    self.data = [NSUserDefaults standardUserDefaults];
    CALayer *layer1=[self.cancal layer];
    layer1.cornerRadius=5.0f;
    CALayer *layer2=[self.confirm layer];
    layer2.cornerRadius=5.0f;
    self.replyContent.delegate=self;
    
}

- (IBAction)confirmButton:(id)sender {
    
    [SVProgressHUD showWithStatus:@"确认回复"];
    
    NSDictionary *parameter=@{@"id":self.replyId,@"content": self.replyContent.text ,@"person":[self.data objectForKey:@"userAccount"]};
    
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:[ staticStr stringByAppendingString:@"addcomment" ] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response=(NSDictionary *)responseObject;
        
        if ([response objectForKey:@"status"])
        {
            
            [SVProgressHUD showSuccessWithStatus:@"回复成功"];
            
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate reloadReplyTableView ];
            }];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"回复失败"];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"回复格式有误"
                                        delegate:nil cancelButtonTitle:@"重新回复" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"回复失败"];
        NSLog(@"%@",error);
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.replyContent resignFirstResponder];
}

- (IBAction)cancalButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
    
    
}

@end
