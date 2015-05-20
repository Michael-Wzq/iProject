//
//  PayViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSUserDefaults *data;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *rest;
@property (weak, nonatomic) IBOutlet UILabel *needpay;
@property (weak, nonatomic) IBOutlet UILabel *yuliu;
@property (weak, nonatomic) IBOutlet UITableView *history;
@end
