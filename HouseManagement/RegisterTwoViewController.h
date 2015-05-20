//
//  RegisterTwoViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTwoViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *realName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (strong,nonatomic) NSString *userName;
@property (strong,nonatomic) NSString *userPassword;

- (IBAction)doneRegisterButton:(id)sender;


@end
