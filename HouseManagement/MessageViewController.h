//
//  MessageViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
- (IBAction)backButton:(id)sender;
@property (nonatomic,strong) NSUserDefaults *data;
@property (weak, nonatomic) IBOutlet UILabel *mesLabel;



@end
