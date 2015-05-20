//
//  DetailViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 2/4/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailTableViewCell.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad{
    
    UINib *nib = [UINib nibWithNibName:@"DetailTableViewCell" bundle:nil];
    [self.GoodsTable registerNib:nib forCellReuseIdentifier:@"DetailGoodsCell"];
    self.GoodsTable.delegate=self;
    self.GoodsTable.dataSource=self;
}
#pragma tableviewmethod
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.goodsArr count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailTableViewCell   *cell = [self.GoodsTable dequeueReusableCellWithIdentifier:@"DetailGoodsCell"];
    if(cell==nil){
        cell = [[DetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DetailGoodsCell"];}
    
    cell.content.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.goodsArr objectAtIndex:indexPath.row] objectForKey:@"content"]];
    cell.name.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.goodsArr objectAtIndex:indexPath.row] objectForKey:@"name"]];
    cell.Id.text = [[NSString alloc] initWithFormat:@"%@" ,[[self.goodsArr objectAtIndex:indexPath.row] objectForKey:@"id"]];
    [cell.goodsImage setImage:[UIImage imageNamed:@"1098933.gif"]];
    return cell;
}




- (IBAction)back:(id)sender {
        [self dismissViewControllerAnimated:YES completion:^(void){}];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
