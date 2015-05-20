//
//  RecSuggestionViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 3/19/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecSuggestionViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *mesTabel;

@property (weak, nonatomic) IBOutlet UILabel *mesLabel;



@end
