//
//  ServiceNumberTableViewCell.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 18/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceNumberTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *lblNumber;
@property (nonatomic, weak) IBOutlet UILabel *lblDescription;
@property (nonatomic, weak) IBOutlet UIImageView *check;

@end
