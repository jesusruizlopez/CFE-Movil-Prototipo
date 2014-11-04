//
//  ProblemCollectionViewCell.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProblemCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imgProblem;
@property (nonatomic, weak) IBOutlet UILabel *lblDescription;

@end
