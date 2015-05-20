//
//  addReplyViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/2/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReloadReplyDelegate
-(void)reloadReplyTableView;
@end
@interface addReplyViewController : UIViewController<UITextViewDelegate>


@property(assign,nonatomic)id<ReloadReplyDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITextView *replyContent;

@property (assign,nonatomic) NSString *replyId;
@property(nonatomic,strong) NSUserDefaults *data;
- (IBAction)cancalButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancal;
@property (weak, nonatomic) IBOutlet UIButton *confirm;


- (IBAction)confirmButton:(id)sender;


@end
