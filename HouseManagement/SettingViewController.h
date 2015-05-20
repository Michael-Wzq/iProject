//
//  SettingViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
@property (strong,nonatomic) NSUserDefaults *data;
- (IBAction)logoutButton:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *address;

@end
