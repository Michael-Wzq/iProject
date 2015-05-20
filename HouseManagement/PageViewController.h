//
//  PageViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/18.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController: UIViewController
{
    int pageNumber;
}
@property (weak, nonatomic) IBOutlet UILabel *PageLabel;


@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
- (id)initWithPageNumber:(int )page;
@end
