//
//  PushAllMesViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 3/21/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushAllMesViewController : UIViewController<UITextViewDelegate>
@property (strong,nonatomic) NSUserDefaults *data;

@property (weak, nonatomic) IBOutlet UITextView *textContent;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
@property (strong,nonatomic) NSString *userStr;
@end
