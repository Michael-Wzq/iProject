//
//  PayTableViewCell.h
//  
//
//  Created by 吴泽钦 on 1/4/15.
//
//

#import <UIKit/UIKit.h>

@interface PayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *water;
@property (weak, nonatomic) IBOutlet UILabel *electric;
@property (weak, nonatomic) IBOutlet UILabel *other;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
