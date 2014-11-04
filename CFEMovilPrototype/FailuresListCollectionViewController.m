//
//  FailuresListCollectionViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 10/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "FailuresListCollectionViewController.h"
#import "FailureCollectionViewCell.h"
#import "ReportTableViewController.h"
#import "ReportsListTableViewController.h"

@interface FailuresListCollectionViewController ()

@end

@implementation FailuresListCollectionViewController {
    NSMutableArray *failuresList;
    UIRefreshControl *refreshControl;
}

static NSString * const reuseIdentifier = @"failureCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Fallas" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    failuresList = [[NSMutableArray alloc] init];
    NSMutableDictionary *failure = [[NSMutableDictionary alloc] init];
    [failure setValue:@"No hay luz en la cuadra o colonia" forKey:@"description"];
    [failure setValue:@"calle.png" forKey:@"image"];
    [failuresList addObject:failure];
    
    failure = [[NSMutableDictionary alloc] init];
    [failure setValue:@"No hay luz en la casa" forKey:@"description"];
    [failure setValue:@"casa.png" forKey:@"image"];
    [failuresList addObject:failure];
    
    failure = [[NSMutableDictionary alloc] init];
    [failure setValue:@"Variación de voltaje en la cuadra o colonia" forKey:@"description"];
    [failure setValue:@"voltajecuadra.png" forKey:@"image"];
    [failuresList addObject:failure];

    failure = [[NSMutableDictionary alloc] init];
    [failure setValue:@"Variación de voltaje en la casa" forKey:@"description"];
    [failure setValue:@"voltajecasa.png" forKey:@"image"];
    [failuresList addObject:failure];
    
    failure = [[NSMutableDictionary alloc] init];
    [failure setValue:@"El CFEmático no funciona" forKey:@"description"];
    [failure setValue:@"cfematico.png" forKey:@"image"];
    [failuresList addObject:failure];

    failure = [[NSMutableDictionary alloc] init];
    [failure setValue:@"Otro tipo de falla" forKey:@"description"];
    [failure setValue:@"otrafalla.png" forKey:@"image"];
    [failuresList addObject:failure];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadFailures) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refreshControl];
}

- (void)loadFailures {
    [refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([[segue identifier] isEqualToString:@"formReportSegue"]) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        ReportTableViewController *rtvc = segue.destinationViewController;
        rtvc.report = [failuresList objectAtIndex:indexPath.row];
        rtvc.type = @"failure";
    }
    else if ([[segue identifier] isEqualToString:@"reportsListSegue"]) {
        ReportsListTableViewController *rltvc = segue.destinationViewController;
        rltvc.type = @"failure";
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [failuresList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FailureCollectionViewCell *failureCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSMutableDictionary *obj = [failuresList objectAtIndex:indexPath.row];
    failureCell.lblDescription.text = [obj objectForKey:@"description"];
    UIImage *image = [UIImage imageNamed:[obj objectForKey:@"image"]];
    failureCell.imgFailure.image = image;
    failureCell.layer.cornerRadius = 6;
    failureCell.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    failureCell.layer.borderWidth = 1.0f;
    
    return failureCell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
