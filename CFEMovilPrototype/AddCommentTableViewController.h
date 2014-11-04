//
//  AddCommentTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 03/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentTableViewController : UITableViewController<UITextViewDelegate>

@property (strong, nonatomic) NSDictionary *report;
@property (weak, nonatomic) IBOutlet UILabel *lblCharacters;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;

@end
