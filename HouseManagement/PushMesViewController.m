//
//  PushMesViewController.m
//  HouseManagement
//
//  Created by 吴泽钦 on 3/19/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import "PushMesViewController.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@interface PushMesViewController()
@property   (strong,nonatomic) NSMutableArray *pickerArr;
@property   NSInteger typeNumber;
@end
static NSString *staticStr = @"http://192.168.137.185:8080/Property/servlet/";

@implementation PushMesViewController

- (void)viewDidLoad{
    
    
    
    
    [super viewDidLoad];
    self.data = [NSUserDefaults standardUserDefaults];
    CALayer *layer1=[self.cancelButton layer];
    layer1.cornerRadius=5.0f;
    CALayer *layer2=[self.confirmButton layer];
    layer2.cornerRadius=5.0f;
    self.textContent.delegate=self;
    self.pickerView.delegate=self;
    self.pickerView.dataSource=self;
    self.pickerArr = [NSMutableArray arrayWithObjects:@"新公告",@"商铺",@"维修已受理",@"反馈",@"最新消息",nil];
    self.typeNumber=(int)[self.pickerView selectedRowInComponent:0];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
        return [self.pickerArr count];
    
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self.pickerArr objectAtIndex:row];
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.typeNumber=(int)[self.pickerView selectedRowInComponent:0];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:25]];
        pickerLabel.textColor=[UIColor blackColor];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textContent  resignFirstResponder];
}


- (IBAction)pushMes:(id)sender {
    [SVProgressHUD showWithStatus:@"发送中"];
    
    NSDictionary *parameter=@{@"title":self.titleLabel.text,@"person":[self.data objectForKey:@"userAccount"],@"content": self.textContent.text,@"type":[[NSString alloc]initWithFormat:@"%ld",(long)self.typeNumber+1],@"receiver":self.userStr};
    NSLog(@"%@",self.titleLabel.text);
    NSLog(@"%@",[self.data objectForKey:@"userAccount"]);
    NSLog(@"%@",self.textContent.text);
    NSLog(@"%@",[[NSString alloc]initWithFormat:@"%ld",(long)self.typeNumber+1]);
     NSLog(@"%@",self.userStr);
    AFHTTPRequestOperationManager *manger = [AFHTTPRequestOperationManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manger GET:[staticStr stringByAppendingString:@"addpush"] parameters: parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",staticStr);
        NSDictionary *response=(NSDictionary *)responseObject;
        NSLog(@"%@",response);
        if ([[response objectForKey:@"status"]intValue ] ==1)
        {
            
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [SVProgressHUD showErrorWithStatus:@"发送失败"];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"发送信息格式有误"
                                                        delegate:nil cancelButtonTitle:@"重新发送" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        NSLog(@"%@",error);
    }];
    
    
    
}




- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}




@end
