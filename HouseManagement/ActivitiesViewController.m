//
//  ActivitiesViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 14/12/26.
//  Copyright (c) 2014年 michael. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "ActivitiesTableViewCell.h"
#import "AddActivitiesViewController.h"
#import "ActivityReplyViewController.h"
#import "AFNetworking.h"
@interface ActivitiesViewController ()
@property (strong,nonatomic) NSMutableDictionary *activitiesDic;
@property (strong,nonatomic) NSMutableArray *activitiesArr;
@property (strong,nonatomic) NSMutableDictionary *replyDic1;
@property (strong,nonatomic) NSMutableDictionary *replyDic2;
@property (strong,nonatomic) NSMutableArray *replyArr;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation ActivitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self jasonRequest];
   
    UINib *nib = [UINib nibWithNibName:@"ActivitiesTableViewCell" bundle:nil];
    [self.activitiesTable registerNib:nib forCellReuseIdentifier:@"activitiesCell"];
   
    self.activitiesTable.delegate=self;
    self.activitiesTable.dataSource=self;
   
}

- (void)jasonRequest{
    NSString *str =[staticStr stringByAppendingString: @"activity"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.activitiesDic = (NSMutableDictionary *)responseObject;
        self.activitiesArr = [self.activitiesDic objectForKey:@"list"];
        [self.activitiesTable reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}



-(void)reloadActivityTableView{
    [self jasonRequest];
}







#pragma tableviewmethod
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.activitiesArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    self.replyDic1 = [self.activitiesArr objectAtIndex:indexPath.row];
    self.replyDic2 = [self.replyDic1 objectForKey:@"comment"];
    self.replyArr = [self.replyDic2 objectForKey:@"data"];

    
    
    ActivitiesTableViewCell *cell = [self.activitiesTable   dequeueReusableCellWithIdentifier:@"activitiesCell"];
    if(cell==nil){
        cell = [[ActivitiesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"activitiesCell"];}
    cell.activityUser.text = [[self.activitiesArr objectAtIndex:indexPath.row]objectForKey:@"person"];
    cell.activityTitle.text = [[self.activitiesArr objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.activityDate.text = [[self.activitiesArr objectAtIndex:indexPath.row]objectForKey:@"date"];
    cell.activityContent.text = [[self.activitiesArr objectAtIndex:indexPath.row]objectForKey:@"content"];
    [cell.activityReply setTitle:[self.replyDic2 objectForKey:@"count"] forState:UIControlStateNormal];
    cell.activityReply.replyArr = [self.replyDic2 objectForKey:@"data"];
    
    cell.activityReply.replyId = [self.replyDic1 objectForKey:@"id"];
    
    cell.activityReply.row = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
//    NSLog(@"aaaaaaaa%@",cell.activityReply.row);
    [cell.activityReply addTarget:self action:@selector(activitiesReply: ) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (IBAction)activitiesReply:(ReplyButton *)sender{
    ActivityReplyViewController *activityReplyView = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityReplyViewController"];
    activityReplyView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:activityReplyView animated:YES completion:^(void){
        activityReplyView.replyArr = sender.replyArr;
        activityReplyView.replyId = sender.replyId;
        activityReplyView.replyRow = sender.row;
//        NSLog(@"bbbbbb%@",activityReplyView.replyRow);
         [activityReplyView.replyTableView reloadData];
        
    }];
    
    
}




- (void)viewWillAppear:(BOOL)animated   {
//    NSLog(@"viewDidWillAppear   ");
    [self jasonRequest];
}






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}







- (IBAction)addActivities:(id)sender {
    AddActivitiesViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"AddActivitiesViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){}];
    addView.delegate =self;
}




@end
