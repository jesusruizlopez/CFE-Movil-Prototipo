//
//  ProfileTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ProfileTableViewController.h"
#import "ObjectDataMaper.h"
#import "Colors.h"
#import "ReportTableViewCell.h"

@interface ProfileTableViewController ()

@end

@implementation ProfileTableViewController {
    NSMutableArray *failuresList;
    NSMutableArray *problemsList;
    ObjectDataMaper *odm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    failuresList = [[NSMutableArray alloc] init];
    problemsList = [[NSMutableArray alloc] init];
    
    odm = [[ObjectDataMaper alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadReports];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    self.lblService.text = ([ud objectForKey:@"serviceSelected"] == nil) ? @"No hay número!" : [ud objectForKey:@"serviceSelected"];
    NSDictionary *user = [odm getUser];
    
    self.lblEmail.text = ([[user objectForKey:@"email"] isEqualToString:@""]) ? @"No hay correo!" : [user objectForKey:@"email"];
    self.lblTwitter.text = ([[user objectForKey:@"twitter"] isEqualToString:@""]) ? @"No hay twitter!" : [NSString stringWithFormat:@"@%@", [user objectForKey:@"twitter"]];
}

- (void)loadReports {
    failuresList = [odm getReports:@"failure"];
    problemsList = [odm getReports:@"problem"];
    
    [self.segmentedControl setTitle:[NSString stringWithFormat:@"Reportes de Fallas (%ld)", [failuresList count]] forSegmentAtIndex:0];
        [self.segmentedControl setTitle:[NSString stringWithFormat:@"Quejas y Denuncias (%ld)", [problemsList count]] forSegmentAtIndex:1];
    
    [self.tableView reloadData];
    
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        if ([failuresList count] == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 270, 80, 80)];
            imageView.image = [UIImage imageNamed:@"empty.png"];
            [view addSubview:imageView];
            
            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 360, 320, 20)];
            message.text = @"No hay reportes para mostrar";
            [message setTextAlignment:NSTextAlignmentCenter];
            [message setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
            message.textColor = GRIS;
            [view addSubview:message];
            
            [self.tableView setBackgroundView:view];
        }
        else {
            [self.tableView setBackgroundView:nil];
        }
    }
    else {
        if ([problemsList count] == 0) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 270, 80, 80)];
            imageView.image = [UIImage imageNamed:@"empty.png"];
            [view addSubview:imageView];
            
            UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 360, 320, 20)];
            message.text = @"No hay reportes para mostrar";
            [message setTextAlignment:NSTextAlignmentCenter];
            [message setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
            message.textColor = GRIS;
            [view addSubview:message];
            
            [self.tableView setBackgroundView:view];
        }
        else {
            [self.tableView setBackgroundView:nil];
        }
    }
}

#pragma mark - IBAction

- (IBAction)changeReport:(id)sender {
    [self loadReports];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (self.segmentedControl.selectedSegmentIndex == 0)
        return [failuresList count];
    else
        return [problemsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReportTableViewCell *reportCell = [tableView dequeueReusableCellWithIdentifier:@"reportCell" forIndexPath:indexPath];
    
    NSMutableDictionary *report;
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
        report = [failuresList objectAtIndex:indexPath.row];
    else
        report = [problemsList objectAtIndex:indexPath.row];
    
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
    NSString *message;
    
    if (self.segmentedControl.selectedSegmentIndex == 0)
        message = [[failuresList objectAtIndex:indexPath.row] objectForKey:@"observations"];
    else
        message = [[problemsList objectAtIndex:indexPath.row] objectForKey:@"observations"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
