//
//  AddActivitiesViewController.h
//  HouseManagement
//
//  Created by 吴泽钦 on 12/31/14.
//  Copyright (c) 2014 michael. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReloadDelegate
-(void)reloadActivityTableView;
@end
@interface AddActivitiesViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(assign,nonatomic)id<ReloadDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *addActivityTextView;
@property(nonatomic,strong) NSUserDefaults *data;
@property (weak, nonatomic) IBOutlet UIButton *cancel;

@property (weak, nonatomic) IBOutlet UIButton *submit;

@property (weak, nonatomic) IBOutlet UILabel *placeHolder;

@property (weak, nonatomic) IBOutlet UIButton *addPicture;

@property (weak, nonatomic) IBOutlet UITextField *activityTitle;

@property (weak, nonatomic) IBOutlet UIImageView *activityImage;

@property (weak, nonatomic) IBOutlet UIButton *addImageButton;

@end
