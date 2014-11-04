//
//  ReportTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTableViewController : UITableViewController<UITextViewDelegate>

@property (strong, nonatomic) NSDictionary *report;
@property (strong, nonatomic) NSString *type;
@property (weak, nonatomic) IBOutlet UILabel *lblTitleReport;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UITextView *txtObservations;
@property (weak, nonatomic) IBOutlet UILabel *lblService;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtTwitter;
@property (weak, nonatomic) IBOutlet UILabel *lblCharacters;

@end
