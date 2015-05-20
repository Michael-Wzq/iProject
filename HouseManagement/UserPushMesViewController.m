//
//  UserPushMesViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 3/21/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "UserPushMesViewController.h"
#import "UserPushMesTableViewCell.h"
#import "PushMesViewController.h"
#import "PushAllMesViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface UserPushMesViewController()
@property (strong,nonatomic) NSMutableDictionary *mesDic;
@property (strong,nonatomic) NSMutableArray *mesArr;
@property (strong,nonatomic) NSString *nameStr;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation UserPushMesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.hidden = YES;
    self.labelView.hidden = YES;
    [self jasonRequest];
    
    UINib *nib = [UINib nibWithNibName:@"UserPushMesTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"pushmes"];
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
}
- (void)jasonRequest{
    //     NSDictionary *parameter=@{@"name":[self.data objectForKey:@"userAccount"],@"type":@"0"};
   
    NSString * str =[staticStr stringByAppendingString:@"userlist"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.mesDic = responseObject;
        NSLog(@"mes: %@",self.mesDic);
        
        
        self.mesArr = [self.mesDic objectForKey:@"list"];
        
        [self.tableView reloadData];
        
        if([[self.mesDic objectForKey:@"total"]intValue ]!=0){
            self.labelView.hidden = NO;
            self.tableView.hidden =YES;
        }else{
            self.labelView.hidden = YES;
            self.tableView.hidden =NO;
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
    
    UserPushMesTableViewCell *cell = [self.tableView   dequeueReusableCellWithIdentifier:@"pushmes"];
    if(cell==nil){
        cell = [[UserPushMesTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"pushmes"];}
    
    cell.userAccount.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"name"];
    
    cell.addressLabel.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"address"];
    cell.phoneLabel.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"phone"];
    cell.realName.text = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"realName"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.nameStr = [[self.mesArr objectAtIndex:indexPath.row]objectForKey:@"name"];
    PushMesViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"PushMesViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){
        addView.userStr =  self.nameStr;
    }];
    
    
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}




- (IBAction)refreshButton:(id)sender {
    
    
    PushAllMesViewController *addView = [self.storyboard instantiateViewControllerWithIdentifier:@"PushAllMesViewController"];
    addView.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:addView animated:YES completion:^(void){
    }];

}


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end



