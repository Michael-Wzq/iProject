//
//  RegisterViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/18.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTwoViewController.h"
@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userName.delegate = self;
    self.userPassword.delegate =self;
    self.confirmUserPassword.delegate = self;
    
    
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.userName resignFirstResponder];
    [self.userPassword resignFirstResponder];
    [self.confirmUserPassword resignFirstResponder];
}
- (IBAction)registerNextStep:(id)sender {
    if ([self.userPassword.text isEqualToString:self.confirmUserPassword.text]) {
        
    
    RegisterTwoViewController *registertwoview = [self.storyboard instantiateViewControllerWithIdentifier:@"RegisterTwoViewController"];
    registertwoview.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:registertwoview animated:YES completion:^(void){
        registertwoview.userName = self.userName.text;
        registertwoview.userPassword = self.userPassword.text;
    }];
    
    }else{
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"两次输入的密码不一致"
                                                    delegate:nil cancelButtonTitle:@"重新输入" otherButtonTitles:nil, nil];
        [alert show];
    }
    
    
}
@end
