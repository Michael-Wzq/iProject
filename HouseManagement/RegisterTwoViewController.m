//
//  RegisterTwoViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "RegisterTwoViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "LoginViewController.h"
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation RegisterTwoViewController
-(void)viewDidLoad{
    self.realName.delegate= self;
    self.address.delegate= self;
    self.phone.delegate = self;
    
}





- (IBAction)doneRegisterButton:(id)sender {
    [SVProgressHUD showWithStatus:@"注册中"];
    NSDictionary *parameter=@{@"name": self.userName,@"pass": self.userPassword ,@"realname": self.realName.text,@"phone":self.phone.text,@"address": self.address.text};
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:[staticStr stringByAppendingString:@"signup"] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response=(NSDictionary *)responseObject;
        if ([response objectForKey:@"status"])
        {
            
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            
            LoginViewController *loginView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            loginView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            [self presentViewController:loginView animated:YES completion:^(void){
            }];

            
            
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"注册失败"];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:[response objectForKey:@"mes"]
                                                        delegate:nil cancelButtonTitle:@"重新输入" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"注册失败"];
        NSLog(@"%@",error);
    }];
    
}


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

    
    
    
    
    
    
    

@end
