//
//  ActivityReplyViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/26.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "addReplyViewController.h"
@interface ActivityReplyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ReloadReplyDelegate>


@property (weak, nonatomic) IBOutlet UITableView *replyTableView;

@property (strong,nonatomic) NSMutableArray *replyArr;
@property (strong,nonatomic) NSString *replyId;
@property (strong,nonatomic) NSString *replyRow;
@end
