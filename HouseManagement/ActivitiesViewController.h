//
//  ActivitiesViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/26.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddActivitiesViewController.h"
#import "addReplyViewController.h"
@interface ActivitiesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ReloadDelegate>




@property (weak, nonatomic) IBOutlet UITableView *activitiesTable;


@end


