//
//  RecRepairTabelViewCell.h
//  HouseManagement
//
//  Created by 吴泽钦 on 3/19/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecRepairTabelViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *contextView;

@property (weak, nonatomic) IBOutlet UILabel *timeStr;

@property (weak, nonatomic) IBOutlet UILabel *nameStr;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
