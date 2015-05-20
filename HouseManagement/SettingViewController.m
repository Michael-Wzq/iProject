//
//  SettingViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "SettingViewController.h"
#import "LoginViewController.h"
@implementation SettingViewController

- (void)viewDidLoad{
    self.data = [NSUserDefaults standardUserDefaults];
    self.userName.text = [[NSString alloc]initWithFormat:@"%@",[self.data objectForKey:@"userAccount"]];
    self.address.text =[[NSString alloc]initWithFormat:@"%@",[self.data objectForKey:@"address"]];
    self.phone.text =[[NSString alloc]initWithFormat:@"%@",[self.data objectForKey:@"phone"]];
    
}

- (IBAction)logoutButton:(id)sender {
    [self.data setBool:NO forKey:@"boolLogin"];
    [self dismissViewControllerAnimated:YES completion:nil];
//    LoginViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
//    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    [self presentViewController:addView animated:YES completion:^(void){}];
    
}
@end
