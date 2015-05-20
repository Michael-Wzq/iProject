//
//  AnnouncementTableViewCell.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/26.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *announceTitle;
@property (weak, nonatomic) IBOutlet UILabel *announceDate;
@property (weak, nonatomic) IBOutlet UILabel *announceContent;

@end
