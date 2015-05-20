//
//  StoreTableViewCell.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/5/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *marketName;
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UILabel *person;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (strong,nonatomic) NSMutableDictionary *goodsDic;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;

@end
