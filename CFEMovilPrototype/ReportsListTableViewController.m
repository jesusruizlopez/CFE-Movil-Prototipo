//
//  ReportsListTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ReportsListTableViewController.h"
#import "ReportTableViewCell.h"
#import "Colors.h"
#import "ObjectDataMaper.h"
#import "ReportCommentsTableViewController.h"

@interface ReportsListTableViewController ()

@end

@implementation ReportsListTableViewController {
    NSMutableArray *reportsList;
    ObjectDataMaper *odm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reportes" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    reportsList = [[NSMutableArray alloc] init];
    odm = [[ObjectDataMaper alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    reportsList = [odm getReports:self.type];
    [self.tableView reloadData];
    
    if ([reportsList count] == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 100, 80, 80)];
        imageView.image = [UIImage imageNamed:@"empty.png"];
        [view addSubview:imageView];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 320, 20)];
        message.text = @"No hay reportes para mostrar";
        [message setTextAlignment:NSTextAlignmentCenter];
        [message setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
        message.textColor = GRIS;
        [view addSubview:message];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(87, 230, 150, 50)];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
        btn.layer.cornerRadius = 8.0f;
        btn.backgroundColor = PRINCIPAL_COLOR;
        [btn setTitle:@"Crear Reporte" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(crearReporte) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
        [self.tableView setBackgroundView:view];
    }
    else {
        [self.tableView setBackgroundView:nil];
    }
}

- (void)crearReporte {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [reportsList count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([reportsList count] == 0)
        return nil;
    UILabel *header = [[UILabel alloc] init];
    header.frame = CGRectMake(10, 30, 320, 20);
    [header setFont:[UIFont fontWithName:@"Avenir-Heavy" size:14]];
    header.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/250.0 alpha:1.0f];
    header.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:header];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([reportsList count] == 0)
        return @"";
    else {
        if ([self.type isEqualToString:@"failure"])
            return @"REPORTES DE FALLAS";
        else
            return @"QUEJAS Y DENUNCIAS";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportTableViewCell *reportCell = [tableView dequeueReusableCellWithIdentifier:@"reportCell" forIndexPath:indexPath];
    
    NSMutableDictionary *report = [reportsList objectAtIndex:indexPath.row];
    reportCell.lblTitle.text = [report objectForKey:@"title"];
    reportCell.txtMessage.text = [report objectForKey:@"observations"];
    reportCell.imgReport.image = [UIImage imageNamed:[report objectForKey:@"image"]];
    reportCell.lblDate.text = [report objectForKey:@"date"];
    
    UIView *view = [[[[reportCell subviews] objectAtIndex:0] subviews] objectAtIndex:0];
    
    CGRect rect = view.frame;
    
    long longitud = [reportCell.txtMessage.text length];
    
    if (longitud > 240)
        rect.size.height = 230;
    else if (longitud > 210)
        rect.size.height = 225;
    else if (longitud > 180)
        rect.size.height = 205;
    else if (longitud > 150)
        rect.size.height = 185;
    else if (longitud > 120)
        rect.size.height = 160;
    else if (longitud > 90)
        rect.size.height = 140;
    else if (longitud > 60)
        rect.size.height = 120;
    else
        rect.size.height = 108;
    
    view.frame = rect;
    
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    view.layer.borderWidth = 1.0f;
    
    return reportCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *message = [[reportsList objectAtIndex:indexPath.row] objectForKey:@"observations"];

    CGFloat heigth;
    long longitud = [message length];
    
    if (longitud > 240)
        heigth = 240;
    else if (longitud > 210)
        heigth = 230;
    else if (longitud > 180)
        heigth = 210;
    else if (longitud > 150)
        heigth = 190;
    else if (longitud > 120)
        heigth = 165;
    else if (longitud > 90)
        heigth = 145;
    else if (longitud > 60)
        heigth = 125;
    else
        heigth = 111;
    
    return heigth;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if ([[segue identifier] isEqualToString:@"commentReportSegue"]) {
        NSDictionary *report = [reportsList objectAtIndex:indexPath.row];
        ReportCommentsTableViewController *rctvc = segue.destinationViewController;
        rctvc.report = report;
    }
}

@end
