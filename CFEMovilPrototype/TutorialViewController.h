//
//  TutorialViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 19/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialViewController : UIViewController<UIPageViewControllerDataSource>

@property (weak, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) NSArray *messages;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UILabel *lblInfo;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;

@end
