//
//  RateReportTableViewCell.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 03/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "RateReportTableViewCell.h"

@implementation RateReportTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)check:(id)sender {
    UIImage *image = [UIImage imageNamed:@"star_on.png"];
    
    switch ([sender tag]) {
        case 5:
            [self.star5 setImage:image forState:UIControlStateNormal];
        case 4:
            [self.star4 setImage:image forState:UIControlStateNormal];
        case 3:
            [self.star3 setImage:image forState:UIControlStateNormal];
        case 2:
            [self.star2 setImage:image forState:UIControlStateNormal];
        case 1:
            [self.star1 setImage:image forState:UIControlStateNormal];
        default:
            break;
    }
}

@end
