//
//  PayViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "PayViewController.h"
#import "AFNetworking.h"
#import "PayTableViewCell.h"
@interface PayViewController ()
@property  (strong,nonatomic) NSMutableArray *payArr;
@property  (strong,nonatomic) NSMutableDictionary *payDic;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.data =  [NSUserDefaults standardUserDefaults];
    [self jasonRequset];
    UINib *nib = [UINib nibWithNibName:@"PayTableViewCell" bundle:nil];
    [self.history registerNib:nib forCellReuseIdentifier:@"PayTableViewCell"];
    
    self.history.delegate=self;
    self.history.dataSource=self;
}

- (void)jasonRequset{
    NSString * str =[staticStr stringByAppendingString: @"bill"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    parameters:@{@"name":[self.data objectForKey:@"userAccount"]}
    [manger GET:str parameters:@{@"name":@"李瑶池"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.payDic = (NSMutableDictionary *)responseObject;
        self.address.text = [self.payDic objectForKey:@"address"];
        self.rest.text = [self.payDic objectForKey:@"rest"];
        self.needpay.text = [self.payDic objectForKey:@"needpay"];
        self.yuliu.text = [self.payDic objectForKey:@"yuliu"];
        self.payArr = [self.payDic objectForKey:@"history"];
        [self.history reloadData];
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
    return [self.payArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayTableViewCell *cell = [self.history   dequeueReusableCellWithIdentifier:@"PayTableViewCell"];
    if(cell==nil){
        cell = [[PayTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PayTableViewCell"];}
    
    cell.date.text = [[self.payArr objectAtIndex:indexPath.row]objectForKey:@"data"];
    cell.water.text = [[self.payArr objectAtIndex:indexPath.row]objectForKey:@"water"];
    cell.electric.text = [[self.payArr objectAtIndex:indexPath.row]objectForKey:@"electric"];
    cell.other.text = [[self.payArr objectAtIndex:indexPath.row]objectForKey:@"other"];
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









@end
