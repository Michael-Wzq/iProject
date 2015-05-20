//
//  StoreViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 1/1/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreTableViewCell.h"
#import "DetailViewController.h"
#import "AFNetworking.h"
@interface StoreViewController ()
@property (strong,nonatomic) NSMutableArray *storeArray;
@property (strong,nonatomic) NSMutableDictionary *storeDic;

@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";
@implementation StoreViewController




- (void)viewDidLoad{
    
    
   
    [self jasonRequest];
    UINib *nib = [UINib nibWithNibName:@"StoreTableViewCell" bundle:nil];
    [self.storeTableView registerNib:nib forCellReuseIdentifier:@"storeCell"];
    self.storeTableView.delegate=self;
    self.storeTableView.dataSource=self;
}


- (void)jasonRequest{
     NSString * str =[staticStr stringByAppendingString:@"marketlist"];
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.storeDic = responseObject;
        self.storeArray = [self.storeDic objectForKey:@"list"];
        
        [self.storeTableView reloadData];
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
    return [self.storeArray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreTableViewCell   *cell = [self.storeTableView dequeueReusableCellWithIdentifier:@"storeCell"];
    if(cell==nil){
        cell = [[StoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storeCell"];}
    
    cell.content.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.storeArray objectAtIndex:indexPath.row] objectForKey:@"content"]];
//    cell.date.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.storeArray objectAtIndex:indexPath.row] objectForKey:@"date"]];
    cell.marketName.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.storeArray objectAtIndex:indexPath.row] objectForKey:@"marketname"]];
//    cell.person.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.storeArray objectAtIndex:indexPath.row] objectForKey:@"person"]];
    
    [cell.storeImageView setImage:[UIImage imageNamed:@"1234567890.gif"] ];
    
    return cell;
}      






-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    view.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:view animated:YES completion:^(void){
        view.goodsDic = [[self.storeArray objectAtIndex:indexPath.row] objectForKey:@"goods"];;
        view.goodsArr = [view.goodsDic objectForKey:@"data"];
        [view.GoodsTable reloadData];
    }];
    

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

















- (IBAction)buyRecordButton:(id)sender {
}





@end
