//
//  ProblemsListCollectionViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 19/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ProblemsListCollectionViewController.h"
#import "ProblemCollectionViewCell.h"
#import "ReportTableViewController.h"
#import "ReportsListTableViewController.h"

@interface ProblemsListCollectionViewController ()

@end

@implementation ProblemsListCollectionViewController {
    NSMutableArray *problemsList;
    UIRefreshControl *refreshControl;
}

static NSString * const reuseIdentifier = @"problemCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Problemas" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    problemsList = [[NSMutableArray alloc] init];
    NSMutableDictionary *problem = [[NSMutableDictionary alloc] init];
    [problem setValue:@"Alto consumo de recibo de luz" forKey:@"description"];
    [problem setValue:@"consumo.png" forKey:@"image"];
    [problemsList addObject:problem];
    
    problem = [[NSMutableDictionary alloc] init];
    [problem setValue:@"Mala atención en el Centro de Atención de Clientes" forKey:@"description"];
    [problem setValue:@"atencion.png" forKey:@"image"];
    [problemsList addObject:problem];
    
    problem = [[NSMutableDictionary alloc] init];
    [problem setValue:@"Extorsión o Corrupción" forKey:@"description"];
    [problem setValue:@"extorsion.png" forKey:@"image"];
    [problemsList addObject:problem];
    
    problem = [[NSMutableDictionary alloc] init];
    [problem setValue:@"Otro problema" forKey:@"description"];
    [problem setValue:@"otroproblema.png" forKey:@"image"];
    [problemsList addObject:problem];
    
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
        rtvc.report = [problemsList objectAtIndex:indexPath.row];
        rtvc.type = @"problem";
    }
    else if ([[segue identifier] isEqualToString:@"reportsListSegue"]) {
        ReportsListTableViewController *rltvc = segue.destinationViewController;
        rltvc.type = @"problem";
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [problemsList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProblemCollectionViewCell *problemCell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSMutableDictionary *obj = [problemsList objectAtIndex:indexPath.row];
    problemCell.lblDescription.text = [obj objectForKey:@"description"];
    UIImage *image = [UIImage imageNamed:[obj objectForKey:@"image"]];
    problemCell.imgProblem.image = image;
    problemCell.layer.cornerRadius = 6;
    problemCell.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    problemCell.layer.borderWidth = 1.0f;
    
    return problemCell;
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
