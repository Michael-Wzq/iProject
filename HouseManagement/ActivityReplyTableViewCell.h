//
//  ActivityReplyTableViewCell.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/26.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityReplyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *replyContent;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *replyTime;
@property (weak, nonatomic) IBOutlet UILabel *replyFloor;

@end
