//
//  FeedBackViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/24.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedBackViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *feedBackTextView;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@property(nonatomic,strong) NSUserDefaults *data;
@end
