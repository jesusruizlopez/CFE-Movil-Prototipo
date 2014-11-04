//
//  EditProfileTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileTableViewController : UITableViewController<UIActionSheetDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtTwitter;
@property (weak, nonatomic) IBOutlet UIImageView *checkEmail;
@property (weak, nonatomic) IBOutlet UIImageView *checkTwitter;

@end
