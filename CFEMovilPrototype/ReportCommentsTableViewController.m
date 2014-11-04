//
//  ReportCommentsTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 21/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ReportCommentsTableViewController.h"
#import "Colors.h"
#import "ReportTableViewCell.h"
#import "ReportCommentTableViewCell.h"
#import "ObjectDataMaper.h"
#import "AddCommentTableViewController.h"
#import "RateReportTableViewCell.h"

@interface ReportCommentsTableViewController ()

@property (strong, nonatomic) UIView *fixedTableFooterView;

@end

@implementation ReportCommentsTableViewController {
    UIView *textView;
    NSMutableDictionary *headerReport;
    NSMutableArray *commentsList;
    ObjectDataMaper *odm;
    BOOL qualified;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    commentsList = [[NSMutableArray alloc] init];
    odm = [[ObjectDataMaper alloc] init];
    qualified = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([[self.report objectForKey:@"qualified"] integerValue] > 0) {
        qualified = YES;
    }
    
    commentsList = [odm getComments:[self.report objectForKey:@"id"]];
    [self.tableView reloadData];
    [self setBackground];
}

- (void)setBackground {
    if ([commentsList count] == 0) {
        
        double plus = 0;
        if (!qualified)
            plus = 130;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] frame].size.height + 30 + plus, 80, 80)];
        imageView.image = [UIImage imageNamed:@"empty_comments.png"];
        [view addSubview:imageView];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, [[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] frame].size.height + 120 + plus, 320, 20)];
        message.text = @"No hay comentarios en este reporte";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)rate:(id)sender {
    
    NSDictionary *rate = @{
                            @"id": [self.report objectForKey:@"id"],
                            @"rate": [NSString stringWithFormat:@"%ld", [sender tag]]
                          };
    
    NSString *message = @"Ocurrió un error al intentar calificar el reporte";
    if ([odm qualifyndReport:rate]) {
        message = @"Tu calificación se ha enviado correctamente, la tomaremos en cuenta para mejorar en futuros reportes";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gracias" message:message delegate:self cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    alert.tag = 1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView tag] == 1) {
        UIView *view = [self.tableView viewWithTag:1001];
        [view removeFromSuperview];
        qualified = YES;
        [self.tableView reloadData];
        [self setBackground];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0) {
        if (!qualified)
            return 2;
        return 1;
    }
    return [commentsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0)
            return 121;
        
        NSString *message = [self.report objectForKey:@"observations"];
        
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
    else {
        NSString *message = [[commentsList objectAtIndex:indexPath.row] objectForKey:@"comment"];
        
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
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (!qualified) {
            if (indexPath.row == 0) {
                RateReportTableViewCell *rateReportCell = [tableView dequeueReusableCellWithIdentifier:@"rateReportCell" forIndexPath:indexPath];
                return rateReportCell;
            }
        }
        ReportTableViewCell *headerReportCell = [tableView dequeueReusableCellWithIdentifier:@"reportHeaderCell" forIndexPath:indexPath];
        headerReportCell.imgReport.image = [UIImage imageNamed:[self.report objectForKey:@"image"]];
        headerReportCell.lblTitle.text = [self.report objectForKey:@"title"];
        headerReportCell.lblDate.text = [self.report objectForKey:@"date"];
        headerReportCell.txtMessage.text = [self.report objectForKey:@"observations"];
        
        UIView *view = [[[[headerReportCell subviews] objectAtIndex:0] subviews] objectAtIndex:0];
        
        CGRect rect = view.frame;
        
        long longitud = [headerReportCell.txtMessage.text length];
        
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
        
        return headerReportCell;
    }
    else {
        ReportCommentTableViewCell *reportCommentCell = [tableView dequeueReusableCellWithIdentifier:@"reportCommentCell" forIndexPath:indexPath];
        
        NSMutableDictionary *comment = [commentsList objectAtIndex:indexPath.row];
        
        reportCommentCell.imgUser.image = [UIImage imageNamed:[comment objectForKey:@"user"]];
        reportCommentCell.txtMessage.text = [comment objectForKey:@"comment"];
        
        UIView *view = [[[[reportCommentCell subviews] objectAtIndex:0] subviews] objectAtIndex:0];
        
        CGRect rect = view.frame;
        
        long longitud = [reportCommentCell.txtMessage.text length];
        
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
        
        return reportCommentCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return 0.1;
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return nil;
    else {
        if ([commentsList count] == 0)
            return nil;
    }
    
    UILabel *header = [[UILabel alloc] init];
    header.frame = CGRectMake(10, 10, 320, 20);
    [header setFont:[UIFont fontWithName:@"Avenir-Heavy" size:14]];
    header.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/250.0 alpha:1.0f];
    header.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:header];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return @"";
    else {
        if ([commentsList count] == 0)
            return @"";
        return @"COMENTARIOS";
    }
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"addCommentSegue"]) {
        UINavigationController *nc = segue.destinationViewController;
        AddCommentTableViewController *actvc = [[nc viewControllers] firstObject];
        actvc.report = self.report;
    }
}

@end
