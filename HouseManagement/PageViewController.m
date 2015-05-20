//
//  PageViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/18.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import "PageViewController.h"
NSArray *nameArray = nil ;
NSArray *imageArray = nil;
@interface PageViewController()
@end

@implementation PageViewController

- (id)initWithPageNumber:(int)page{
    if (self = [super initWithNibName:@"PageViewController" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    NSString *str1 = [PageViewController pageControlNameWithIndex:pageNumber];
    self.PageLabel.text = str1;
    NSString *str = [[NSString alloc]initWithFormat:@"%@",[PageViewController pageControlImageWithIndex:pageNumber]];
    UIImage *myImage = [UIImage imageNamed:str];
    [self.ImageView setImage:myImage];
    
    
}

+ (NSString *)pageControlNameWithIndex:(NSUInteger)index {
    if (nameArray == nil) {
        nameArray = [[NSArray alloc]initWithObjects:@"欢迎来到口袋社区1",@"欢迎来到口袋社区2",@"欢迎来到口袋社区3", nil];
    }
    return [nameArray objectAtIndex:index %[nameArray count]];
}

+ (UIImage *)pageControlImageWithIndex:(NSUInteger)index {
    if (imageArray == nil) {
        imageArray = [[NSArray alloc]initWithObjects:@"main_image_2.jpg",@"main_image_3.jpg",@"main_image_1.jpg", nil];
    }
    return [imageArray objectAtIndex:index %[imageArray count]];
}

@end