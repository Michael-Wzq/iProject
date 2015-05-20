//
//  LoginViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userAccount;
@property (weak,nonatomic) IBOutlet UITextField *userPassword;
- (IBAction)loginButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
- (IBAction)registerButton:(id)sender;
@property(nonatomic,strong) NSUserDefaults *data;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
