//
//  HolaTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 01/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "HolaTableViewController.h"
#import "ObjectDataMaper.h"

@interface HolaTableViewController ()

@end

@implementation HolaTableViewController {
    ObjectDataMaper *odm;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    odm = [[ObjectDataMaper alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 0 && j > 0)
                continue;
            UIView *view = [[[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]] subviews] objectAtIndex:0] subviews]objectAtIndex:0];
            view.layer.cornerRadius = 6;
            view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
            view.layer.borderWidth = 1.0f;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)info:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Número de Servicio" message:@"Puedes consultar tu número de servicio en la sección superior derecha de tu recibo de luz" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (section == 0)
        return 1;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"goSegue"]) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud setValue:@"1" forKey:@"tutorial"];
        [ud synchronize];
        
        if ([self.txtServiceNumber.text length] > 0) {
            NSDictionary *service = @{
                                      @"number": self.txtServiceNumber.text,
                                      @"name": @"Principal",
                                      };
            [odm saveService:service];
            
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
            [ud setValue:self.txtServiceNumber.text forKey:@"serviceSelected"];
            [ud synchronize];
        }
        
        [odm saveEmail:self.txtEmail.text];
        [odm saveTwitter:self.txtTwitter.text];
    }
}

@end
