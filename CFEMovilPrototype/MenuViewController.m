//
//  MenuViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 19/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setImage:[[UIImage imageNamed:@"icon_failures_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setSelectedImage:[[UIImage imageNamed:@"icon_failures.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setTitle:@""];
    [[[self.viewControllers objectAtIndex:0] tabBarItem] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setImage:[[UIImage imageNamed:@"icon_complaints_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setSelectedImage:[[UIImage imageNamed:@"icon_complaints.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setTitle:@""];
    [[[self.viewControllers objectAtIndex:1] tabBarItem] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setImage:[[UIImage imageNamed:@"icon_cfeinfo_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setSelectedImage:[[UIImage imageNamed:@"icon_cfeinfo.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setTitle:@""];
    [[[self.viewControllers objectAtIndex:2] tabBarItem] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setImage:[[UIImage imageNamed:@"icon_notifications_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setSelectedImage:[[UIImage imageNamed:@"icon_notifications.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setTitle:@""];
    [[[self.viewControllers objectAtIndex:3] tabBarItem] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
    
    [[[self.viewControllers objectAtIndex:4] tabBarItem] setImage:[[UIImage imageNamed:@"icon_profile_off.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:4] tabBarItem] setSelectedImage:[[UIImage imageNamed:@"icon_profile.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[[self.viewControllers objectAtIndex:4] tabBarItem] setTitle:@""];
    [[[self.viewControllers objectAtIndex:4] tabBarItem] setImageInsets:UIEdgeInsetsMake(5, 0, -5, 0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
