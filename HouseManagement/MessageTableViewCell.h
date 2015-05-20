//
//  MessageTableViewCell.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *mesTitle;
@property (weak, nonatomic) IBOutlet UILabel *mesContent;
@property (weak, nonatomic) IBOutlet UILabel *mesPerson;

@end
