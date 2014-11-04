//
//  EditProfileTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "EditProfileTableViewController.h"
#import "ObjectDataMaper.h"
#import "Colors.h"
#import "ServiceNumberTableViewCell.h"
#import "AddServiceTableViewController.h"

@interface EditProfileTableViewController ()

@end

@implementation EditProfileTableViewController {
    ObjectDataMaper *odm;
    NSUserDefaults *ud;
    NSMutableArray *servicesList;
    NSDictionary *selectService;
    NSDictionary *user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    odm = [[ObjectDataMaper alloc] init];
    ud = [NSUserDefaults standardUserDefaults];
    servicesList = [[NSMutableArray alloc] init];
    
    self.txtEmail.delegate = self;
    self.txtTwitter.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIView *view = [self.tableView viewWithTag:1001];
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    view.layer.borderWidth = 1.0f;
    
    view = [self.tableView viewWithTag:1002];
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    view.layer.borderWidth = 1.0f;
    
    view = [self.tableView viewWithTag:1003];
    view.layer.cornerRadius = 6;
    
    [self.tableView reloadData];
    servicesList = [odm getServices];
    
    user = [odm getUser];
    self.txtEmail.text = [user objectForKey:@"email"];
    self.txtTwitter.text = [user objectForKey:@"twitter"];
    
    [self setBackground];
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
    NSDictionary *service = [servicesList objectAtIndex:indexPath.row];
    
    selectService = service;
    
    NSString *title = [NSString stringWithFormat:@"%@ (%@)", [service objectForKey:@"number"], [service objectForKey:@"name"]];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:
                            @"Editar Servicio",
                            @"Seleccionar como Principal",
                            @"Eliminar Servicio",
                            nil];
    actionSheet.tag = 1;
    actionSheet.destructiveButtonIndex = 2;
    [actionSheet showInView:self.tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

#pragma mark - Action sheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        if (buttonIndex == 0) {
            UINavigationController *nc = [self.storyboard instantiateViewControllerWithIdentifier:@"addServiceView"];
            AddServiceTableViewController *astcv = [nc.viewControllers objectAtIndex:0];
            astcv.service = selectService;
            [self presentViewController:nc animated:YES completion:nil];
        }
        else if (buttonIndex == 1) {
            [ud setValue:[selectService objectForKey:@"number"] forKey:@"serviceSelected"];
            [ud synchronize];
            [self.tableView reloadData];
        }
        else if (buttonIndex == 2) {
            [odm deleteService:[selectService objectForKey:@"id"]];
            if ([[ud objectForKey:@"serviceSelected"] integerValue] == [[selectService objectForKey:@"number"] integerValue]) {
                [ud setValue:nil forKey:@"serviceSelected"];
                [ud synchronize];
            }
            servicesList = [odm getServices];
            [self.tableView reloadData];
            [self setBackground];
        }
    }
}

- (void)setBackground {
    if ([servicesList count] == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(120, 270, 80, 80)];
        imageView.image = [UIImage imageNamed:@"empty_services.png"];
        [view addSubview:imageView];
        
        UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(0, 360, 320, 20)];
        message.text = @"No hay servicios disponibles";
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

#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([text length] == 0)
        text = @"";
    
    if (textField == self.txtEmail) {
        if ([[user objectForKey:@"email"] isEqualToString:text])
            self.checkEmail.image = [UIImage imageNamed:@"icon_checkoff.png"];
        else
            self.checkEmail.image = [UIImage imageNamed:@"icon_checkon.png"];
        [odm editEmail:text];
    }
    else if (textField == self.txtTwitter) {
        if ([[user objectForKey:@"twitter"] isEqualToString:text])
            self.checkTwitter.image = [UIImage imageNamed:@"icon_checkoff.png"];
        else
            self.checkTwitter.image = [UIImage imageNamed:@"icon_checkon.png"];
        [odm editTwitter:text];
    }
    
    return YES;
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
