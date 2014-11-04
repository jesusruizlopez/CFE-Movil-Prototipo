//
//  ReportTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ReportTableViewController.h"
#import "ObjectDataMaper.h"
#import "Colors.h"

#define CARACTERES 250

@interface ReportTableViewController ()

@end

@implementation ReportTableViewController {
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
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reporte" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.lblCharacters.text = [NSString stringWithFormat:@"%d", CARACTERES];
    
    self.txtObservations.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 0 && j != 1)
                continue;
                
            UIView *view = [[[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]] subviews] objectAtIndex:0] subviews]objectAtIndex:0];
            view.layer.cornerRadius = 6;
            view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
            view.layer.borderWidth = 1.0f;
        }
    }
    
    self.lblTitleReport.text = [self.report objectForKey:@"description"];
    
    if ([ud objectForKey:@"serviceSelected"] == nil) {
        self.lblService.text = @"No hay servicio seleccionado!";
    }
    else {
        NSDictionary *service = [odm getServiceByNumber:[ud objectForKey:@"serviceSelected"]];
        self.lblService.text = [NSString stringWithFormat:@"%@ (%@)", [service objectForKey:@"number"], [service objectForKey:@"name"]];
    }
    
    NSDictionary *user = [odm getUser];
    self.txtEmail.text = [user objectForKey:@"email"];
    self.txtTwitter.text = [user objectForKey:@"twitter"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)sendReport:(id)sender {
    
    
    if ([self.txtEmail.text length] <= 0 || [ud objectForKey:@"serviceSelected"] == nil || [self.txtObservations.text length] <= 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Formulario Incorrecto" message:@"Todos los campos marcados con asterisco son obligatorios" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
        [alert show];
        
        return;
    }
    
    NSDictionary *report = @{
                             @"type": self.type,
                             @"title": [self.report objectForKey:@"description"],
                             @"observations": self.txtObservations.text,
                             @"service": [ud objectForKey:@"serviceSelected"],
                             @"twitter": self.txtTwitter.text,
                             @"email": self.txtEmail.text,
                             @"image": [self.report objectForKey:@"image"],
                             @"date": @"Hoy",
                            };
    
    NSString *message = @"";
    if ([odm saveReport:report]) {
        message = @"Hemos recibido tu reporte, te estaremos informando";
        self.txtObservations.text = @"";
        self.txtEmail.text = @"";
        self.txtTwitter.text = @"";
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else {
        message = @"Ocurrió un problema al enviar el reporte, inténtelo de nuevo";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reporte" message:message delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    [alert show];
    
}

#pragma mark - Text view delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (![self.placeholder isHidden])
        self.placeholder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.txtObservations.text length] > 0)
        self.placeholder.hidden = YES;
    else
        self.placeholder.hidden = NO;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
    NSString *text = [textView.text stringByReplacingCharactersInRange:range withString:string];
    long count = CARACTERES - [text length];
    if (count > 0) {
        self.lblCharacters.textColor = PRINCIPAL_COLOR;
        self.lblCharacters.text = [NSString stringWithFormat:@"%ld", count];
    }
    else {
        self.lblCharacters.textColor = [UIColor redColor];
        self.lblCharacters.text = @"0";
    }
    
    if ([text length] > CARACTERES)
        return NO;
    else
        return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0)
        return 2;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

@end
