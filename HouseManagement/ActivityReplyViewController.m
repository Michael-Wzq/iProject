//
//  ActivityReplyViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/26.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import "ActivityReplyViewController.h"
#import "ActivityReplyTableViewCell.h"
#import "addReplyViewController.h"
#import "AFNetworking.h"

@interface ActivityReplyViewController ()
@property  (strong,nonatomic) NSMutableArray *activitiesArr;
@property  (strong,nonatomic) NSMutableDictionary *dic1;
@property  (strong,nonatomic) NSMutableDictionary *dic2;
@property  (strong,nonatomic) NSMutableDictionary *activitiesDic;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation ActivityReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"ActivityReplyTableViewCell" bundle:nil];
    [self.replyTableView registerNib:nib forCellReuseIdentifier:@"activityReplyTableViewCell"];
    
    self.replyTableView.delegate=self;
    self.replyTableView.dataSource=self;
    
}
#pragma tableviewmethod
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.replyArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    ActivityReplyTableViewCell *cell = [self.replyTableView   dequeueReusableCellWithIdentifier:@"activityReplyTableViewCell"];
    if(cell==nil){
        cell = [[ActivityReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activityReplyTableViewCell"];}
    
    cell.replyContent.text = [[self.replyArr objectAtIndex:indexPath.row]objectForKey:@"content"];
    cell.userName.text = [[self.replyArr objectAtIndex:indexPath.row]objectForKey:@"person"];
    cell.replyFloor.text = [[NSString alloc]initWithFormat: @"%ld",(long)indexPath.row+1 ];
    cell.replyTime.text = [[self.replyArr objectAtIndex:indexPath.row]objectForKey:@"date"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}


- (IBAction)addReply:(id)sender {
    addReplyViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddReplyViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){
        addView.replyId = self.replyId;
    }];
    addView.delegate = self;
}

-(void)reloadReplyTableView{
   NSString *str = [staticStr stringByAppendingString:@"activity"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.activitiesDic = (NSMutableDictionary *)responseObject;
        self.activitiesArr = [self.activitiesDic objectForKey:@"list"];
        self.dic1 = [self.activitiesArr objectAtIndex:[self.replyRow integerValue]];
        self.dic2 = [self.dic1 objectForKey:@"comment"];
        self.replyArr = [self.dic2 objectForKey:@"data"];
     
        [self.replyTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}

@end
