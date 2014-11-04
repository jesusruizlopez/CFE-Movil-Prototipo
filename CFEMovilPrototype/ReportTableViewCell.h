//
//  ReportTableViewCell.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgReport;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
