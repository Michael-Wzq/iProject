//
//  MessageViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface MessageViewController()
@property (strong,nonatomic) NSMutableDictionary *mesDic;
@property (strong,nonatomic) NSMutableArray *mesArr;

@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageTableView.hidden = YES;
    self.mesLabel.hidden = YES;
    [self jasonRequest];
    
    UINib *nib = [UINib nibWithNibName:@"MessageTableViewCell" bundle:nil];
    [self.messageTableView registerNib:nib forCellReuseIdentifier:@"messagecell"];
    
    self.messageTableView.delegate=self;
    self.messageTableView.dataSource=self;
    
}
- (void)jasonRequest{
//     NSDictionary *parameter=@{@"name":[self.data objectForKey:@"userAccount"],@"type":@"0"};
        NSDictionary *parameter=@{@"name":@"李瑶池",@"type":@"0"};
     NSString * str =[staticStr stringByAppendingString:@"push"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.mesDic = responseObject;
        NSLog(@"mes: %@",self.mesDic);
        
        
        self.mesArr = [self.mesDic objectForKey:@"list"];
        
        [self.messageTableView reloadData];
    
        if([[self.mesDic objectForKey:@"total"] isEqual:@"0"]){
            self.mesLabel.hidden = NO;
            self.messageTableView.hidden =YES;
        }else{
            self.mesLabel.hidden = YES;
            self.messageTableView.hidden =NO;
        }
        
        UILocalNotification *notification=[[UILocalNotification alloc] init];
        if (notification!=nil) {
            NSDate *now=[NSDate new];
            notification.fireDate=[now dateByAddingTimeInterval:10];//10秒后通知
            notification.repeatInterval=0;//循环次数，kCFCalendarUnitWeekday一周一次
            notification.timeZone=[NSTimeZone defaultTimeZone];
            notification.applicationIconBadgeNumber=1; //应用的红色数字
            notification.soundName= UILocalNotificationDefaultSoundName;//声音，可以换成alarm.soundName = @"myMusic.caf"
            //去掉下面2行就不会弹出提示框
            notification.alertBody=@"通知内容";//提示信息 弹出提示框
            notification.alertAction = @"打开";  //提示框按钮
            //notification.hasAction = NO; //是否显示额外的按钮，为no时alertAction消失
            
            // NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
            //notification.userInfo = infoDict; //添加额外的信息
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
}




#pragma tableviewmethod
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mesArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageTableViewCell *cell = [self.messageTableView   dequeueReusableCellWithIdentifier:@"messagecell"];
    if(cell==nil){
        cell = [[MessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"messagecell"];}
    
    cell.mesTitle.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"title"];
    cell.mesContent.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"content"];
    cell.mesPerson.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"person"];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    NSDictionary *parameter=@{@"name":[self.data objectForKey:@"userAccount"],@"type":@"1"};
    NSDictionary *parameter=@{@"name":@"李瑶池",@"type":@"1"};
    NSString *str =[staticStr stringByAppendingString:@"push"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.messageTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
        
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)refreshButton:(id)sender {
     [SVProgressHUD showWithStatus:@"重新获取消息中"];
    [self jasonRequest];
    [SVProgressHUD showSuccessWithStatus:@"获取成功"];
}


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
