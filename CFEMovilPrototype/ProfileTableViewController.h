//
//  ProfileTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *lblService;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblTwitter;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@end
