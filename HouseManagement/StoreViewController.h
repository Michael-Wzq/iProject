//
//  StoreViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UIBarButtonItem *showMenuButton;

@property (weak, nonatomic) IBOutlet UIView *menuView;

@property (weak, nonatomic) IBOutlet UIButton *buyRecordButton;

@property (weak, nonatomic) IBOutlet UIButton *myStore;
- (IBAction)buyRecordButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *myStoreButton;

@property (weak, nonatomic) IBOutlet UITableView *storeTableView;




@end
