//
//  SlideViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 19/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *slideImage;
@property (weak, nonatomic) IBOutlet UITextView *slideTitle;

@property NSUInteger index;
@property NSString *text;
@property NSString *image;

@end
