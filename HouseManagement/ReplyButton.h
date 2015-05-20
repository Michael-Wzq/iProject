//
//  ReplyButton.h
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/31.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplyButton : UIButton
@property (strong,nonatomic) NSString *replyId;
@property (strong,nonatomic) NSMutableArray *replyArr;
@property (strong,nonatomic) NSString *row;

@end
