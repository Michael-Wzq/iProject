//
//  DetailTableViewCell.h
//  HouseManagement
//
//  Created by 吴泽钦 on 2/5/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *Id;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImage;

@end
