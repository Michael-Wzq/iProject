//
//  AnnouncementViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/18.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnouncementViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
- (IBAction)changePage:(id)sender;
@property (strong,nonatomic) NSMutableArray *imageViews;
@property (weak, nonatomic) IBOutlet UITableView *anonunceTable;

@end
