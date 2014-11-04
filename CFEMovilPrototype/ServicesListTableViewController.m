//
//  ServicesListTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 18/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ServicesListTableViewController.h"
#import "ServiceNumberTableViewCell.h"
#import "Colors.h"
#import "ObjectDataMaper.h"

@interface ServicesListTableViewController ()

@end

@implementation ServicesListTableViewController {
    NSMutableArray *servicesList;
    ObjectDataMaper *odm;
    NSUserDefaults *ud;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    odm = [[ObjectDataMaper alloc] init];
    ud = [NSUserDefaults standardUserDefaults];
}

- (void)agregarServicio {
    UINavigationController *astvc = [self.storyboard instantiateViewControllerWithIdentifier:@"addServiceView"];
    [self presentViewController:astvc animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    servicesList = [odm getServices];
    
    if ([servicesList count] == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 100, 80, 80)];
        imageView.image = [UIImage imageNamed:@"empty_services.png"];
        [view addSubview:imageView];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 190, 320, 20)];
        message.text = @"No hay servicios disponibles";
        [message setTextAlignment:NSTextAlignmentCenter];
        [message setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
        message.textColor = GRIS;
        [view addSubview:message];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(87, 230, 150, 50)];
        [btn.titleLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:15]];
        btn.layer.cornerRadius = 8.0f;
        btn.backgroundColor = PRINCIPAL_COLOR;
        [btn setTitle:@"Agregar Servicio" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(agregarServicio) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [servicesList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([servicesList count] == 0)
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([servicesList count] == 0)
        return @"";
    return @"NÚMEROS DE SERVICIOS";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceNumberTableViewCell *serviceCell = [tableView dequeueReusableCellWithIdentifier:@"serviceNumberCell" forIndexPath:indexPath];
    
    NSMutableDictionary *service = [servicesList objectAtIndex:indexPath.row];
    serviceCell.lblNumber.text = [service objectForKey:@"number"];
    serviceCell.lblDescription.text = [service objectForKey:@"name"];
    serviceCell.check.image = nil;
    
    if ([[ud objectForKey:@"serviceSelected"] integerValue] == [[service objectForKey:@"number"] integerValue])
        serviceCell.check.image = [UIImage imageNamed:@"icon_checkon.png"];
    
    UIView *view = [[[[serviceCell subviews] objectAtIndex:0] subviews] objectAtIndex:0];
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    view.layer.borderWidth = 1.0f;
    
    return serviceCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceNumberTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"serviceNumberCell" forIndexPath:indexPath];
    cell.check.image = [UIImage imageNamed:@"icon_checkon.png"];
    
    NSDictionary *service = [servicesList objectAtIndex:indexPath.row];
    [ud setValue:[service objectForKey:@"number"] forKey:@"serviceSelected"];
    [ud synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
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
