//
//  ReportCommentsTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 21/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCommentsTableViewController : UITableViewController<UIAlertViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSDictionary *report;

@end
