//
//  HelpTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 03/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "HelpTableViewController.h"
#import "InfoTableViewCell.h"

@interface HelpTableViewController ()

@end

@implementation HelpTableViewController {
    NSMutableArray *tutorialsList;
    NSMutableArray *faqList;
    NSMutableArray *tipsList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    tutorialsList = [[NSMutableArray alloc] init];
    NSDictionary *info = @{
                            @"description": @"Como usar los números de servicios correctamente"
                          };
    
    [tutorialsList addObject:info];
    
    info = @{
             @"description": @"Como usar el mapa de lugares de pago"
            };
    
    [tutorialsList addObject:info];
    
    info = @{
             @"description": @"Como crear un reporte nuevo"
            };
    
    [tutorialsList addObject:info];
    
    faqList = [[NSMutableArray alloc] init];
    NSDictionary *faq = @{
                           @"description": @"¿Que hagó si mi medidor está fallando?"
                           };
    
    [faqList addObject:faq];
    
    faq = @{
             @"description": @"¿Cómo reactivo mi servicio si este ha sido suspendido?"
             };
    
    [faqList addObject:faq];
    
    faq = @{
             @"description": @"Si se me pierde la tarjeta, ¿qué hago?"
             };
    
    [faqList addObject:faq];
    
    tipsList = [[NSMutableArray alloc] init];
    NSDictionary *tip = @{
                          @"description": @"No te dejes sorprender"
                          };
    
    [tipsList addObject:tip];
    
    tip = @{
            @"description": @"Ahorro de energía"
            };
    
    [tipsList addObject:tip];
    
    tip = @{
            @"description": @"Consejos para ahorar energía"
            };
    
    [tipsList addObject:tip];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0)
        return [tutorialsList count];
    else if (section == 1)
        return [faqList count];
    else
        return [tipsList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 72;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

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
    if (section == 0)
        return @"TUTORIALES CFE MÓVIL";
    else if (section == 1)
        return @"PREGUNTAS FRECUENTES";
    else
        return @"CONSEJOS Y AYUDAS";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"infoCell" forIndexPath:indexPath];
    
    UIView *view = [[[[cell subviews] objectAtIndex:0] subviews] objectAtIndex:0];
    view.layer.cornerRadius = 6;
    view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    view.layer.borderWidth = 1.0f;

    
    if (indexPath.section == 0) {
        NSDictionary *info = [tutorialsList objectAtIndex:indexPath.row];
        cell.lblDescription.text = [info objectForKey:@"description"];
        
        return cell;
    }
    else if (indexPath.section == 1) {
        NSDictionary *info = [faqList objectAtIndex:indexPath.row];
        cell.lblDescription.text = [info objectForKey:@"description"];
        
        return cell;
    }
    else {
        NSDictionary *info = [tipsList objectAtIndex:indexPath.row];
        cell.lblDescription.text = [info objectForKey:@"description"];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo" message:@"Esta funcionalidad no se encuentra disponible en la versión demo" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    [alert show];
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
