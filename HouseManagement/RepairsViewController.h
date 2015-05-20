//
//  RepairsViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 1/2/15.
//  Copyright (c) 2015 michael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepairsViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property(nonatomic,strong) NSUserDefaults *data;
@property (weak, nonatomic) IBOutlet UITextView *repairContent;
@property (weak, nonatomic) IBOutlet UIButton *repairPhoto;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;


- (IBAction)callImage:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *cancalButton;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;



@end
