//
//  AddServiceTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 18/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddServiceTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *txtNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtDescription;
@property (strong, nonatomic) NSDictionary *service;

@end
