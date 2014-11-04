//
//  ReportCommentTableViewCell.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 21/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
