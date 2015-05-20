//
//  DetailViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 2/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) NSMutableDictionary *goodsDic;
@property (strong,nonatomic) NSMutableArray *goodsArr;
@property (weak, nonatomic) IBOutlet UITableView *GoodsTable;

@end
