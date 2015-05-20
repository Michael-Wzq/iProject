//
//  LoginViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "AnnouncementViewController.h"
#import "SVProgressHUD.h"
#import "AFNetworking.h"
@interface LoginViewController()
@property (strong,nonatomic) NSMutableDictionary *dataDic;


@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";


@implementation LoginViewController


-(void)viewDidLoad{
    
    self.userAccount.delegate=self;
    self.userPassword.delegate=self;
    self.data=[NSUserDefaults standardUserDefaults];
    CALayer *layer1=[self.loginButton layer];
    layer1.cornerRadius=5.0f;
    
    if ( [[self.data objectForKey:@"boolLogin"]isEqual:@"YES"]) {
        [self loginButton:nil];
    }
    
    
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.userAccount resignFirstResponder];
    [self.userPassword  resignFirstResponder];
    [self loginButton:nil];
    return YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.userAccount resignFirstResponder];
    [self.userPassword  resignFirstResponder];
    
}

















- (IBAction)loginButton:(id)sender {
    
    if (self.userAccount.text.length==0||self.userPassword.text.length==0)
    {
        [SVProgressHUD showErrorWithStatus:@"登陆失败"];
    }
    else
     {
        [SVProgressHUD showWithStatus:@"登陆中"];
        
        
         
         NSDictionary *parameter=@{@"name": self.userAccount.text,@"pass": self.userPassword.text };
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];//设置协议可接受
         
         
        [manager GET:[staticStr stringByAppendingString:@"login"] parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             NSDictionary *response=(NSDictionary *)responseObject;
             
             self.dataDic = [response objectForKey:@"data"];
             
             if ([[response objectForKey:@"status"] intValue]== 1)
             {
            
                
//                 NSLog(@"%@",response);
                 [self.data setObject:self.userAccount.text forKey:@"userAccount"];
//                 NSLog(@"用户名");
//                 NSLog(@"%@",[self.data objectForKey:@"userAccount"]);
              
                 [self.data setObject:self.userPassword.text forKey:@"userPassword"];
//                 NSLog(@"密码");
//                  NSLog(@"%@",[self.data objectForKey:@"userPassword"]);
//                
                 [self.data setBool:YES forKey:@"boolLogin"];
//                 NSLog(@"是否登陆");
//                 NSLog(@"%@",[self.data objectForKey:@"boolLogin"]);
                 [self.data setObject:[self.dataDic objectForKey:@"realname"] forKey:@"realName"];
//                 NSLog(@"真名");
//                 NSLog(@"%@",[self.dataDic objectForKey:@"realName"]);
                 
                 [self.data setObject:[self.dataDic objectForKey:@"address"] forKey:@"address"];
//                 NSLog(@"地址");
//                  NSLog(@"%@",[self.dataDic objectForKey:@"address"]);
                
                 [self.data setObject:[self.dataDic objectForKey:@"level"] forKey:@"userLevel"];
//                 NSLog(@"%@",[self.dataDic objectForKey:@"level"] );
//                 NSLog(@"级别");
//                  NSLog(@"%@",[self.dataDic objectForKey:@"userLevel"]);
                 [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                 
                  [self performSegueWithIdentifier:@"mainTabBarController" sender:self];             }
             else
             {
                 [SVProgressHUD showErrorWithStatus:@"登陆失败"];
                 
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             [SVProgressHUD showErrorWithStatus:@"网络异常，请求失败"];
         }];
        
    }
    
}

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

- (IBAction)registerButton:(id)sender {

    RegisterViewController *registerview = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    registerview.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:registerview animated:YES completion:^(void){
    }];

    
    
}
@end
