//
//  WuYeViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/18.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import "WuYeViewController.h"
#import "FeedBackViewController.h"
#import "MessageViewController.h"
#import "RepairsViewController.h"
#import "PayViewController.h"
#import "RecRepairViewController.h" 
#import "RecSuggestionViewController.h"
#import "PushMesViewController.h"
#import "UserPushMesViewController.h"
@interface WuYeViewController ()

@end

@implementation WuYeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.data = [NSUserDefaults standardUserDefaults];
    NSLog(@"判断 level的值");
    NSLog(@"%@",[self.data objectForKey:@"userLevel"] );
}



- (IBAction)pushMessageView:(id)sender {
    if ([[self.data objectForKey:@"userLevel"] isEqualToString:@"5"]) {
        UserPushMesViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"UserPushMesViewController"];
        addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:addView animated:YES completion:^(void){}];
        
    }else{
    MessageViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){}];

}
}

- (IBAction)pushExpenseView:(id)sender {
    PayViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"PayViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){}];
}

- (IBAction)pushRepairView:(id)sender {
    if (
        [[self.data objectForKey:@"userLevel"] isEqualToString:@"5"]) {
        RecRepairViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"RecRepairViewController"];
        addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:addView animated:YES completion:^(void){}];
    }else{
    
    RepairsViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"RepairsViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){}];
}
}
- (IBAction)pushFeedBackView:(id)sender {
    
    if ([[self.data objectForKey:@"userLevel"] isEqualToString:@"5"]) {
        
        RecSuggestionViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"RecSuggestionViewController"];
        addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        [self presentViewController:addView animated:YES completion:^(void){}];
    }else{
    
    
    
    FeedBackViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){}];
}

}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
