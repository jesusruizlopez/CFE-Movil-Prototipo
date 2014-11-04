//
//  TutorialViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 19/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "TutorialViewController.h"
#import "SlideViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.messages = @[
                      @"Una empresa de clase mundial",
                      @"Reporta fallas en tu servicio de luz de forma fácil y rápida",
                      @"Expón tus quejas y denuncias, obtén el seguimiento del caso",
                      @"Toda la información de los servicios de CFE de forma clara",
                      @"Recordatorios, mensajes y respuestas en tiempo real",
                      @"Consulta reportes, configura tu información y mucho más"
                    ];
    
    self.images = @[@"tutorial_1.png", @"tutorial_2.png", @"tutorial_3.png", @"tutorial_4.png", @"tutorial_5.png", @"tutorial_6.png"];
    
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"slidesContentView"];
    self.pageViewController.dataSource = self;
    
    SlideViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 95);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    self.background.image = [UIImage imageNamed:@"fondo.png"];
    self.background.layer.contentsRect = CGRectMake(-0.05, 0.1, 0.8, 0.8);
    self.btnStart.layer.cornerRadius = 8.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((SlideViewController*) viewController).index;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((SlideViewController*) viewController).index;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index > 0) {
        if (self.lblInfo.alpha != 0.0f) {
            [UIView animateWithDuration:1.0f animations:^{
                [self.lblInfo setAlpha:0.0f];
            }];
        }
    }
    if (index == [self.messages count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (SlideViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    if (([self.messages count] == 0) || (index >= [self.messages count])) {
        return nil;
    }
    
    SlideViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"slideView"];
    pageContentViewController.text = self.messages[index];
    pageContentViewController.image = self.images[index];
    pageContentViewController.index = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return [self.messages count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
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
