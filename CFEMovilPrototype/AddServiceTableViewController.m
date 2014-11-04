//
//  AddServiceTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 18/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "AddServiceTableViewController.h"
#import "ObjectDataMaper.h"

@interface AddServiceTableViewController ()

@end

@implementation AddServiceTableViewController {
    ObjectDataMaper *odm;
    BOOL editing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    odm = [[ObjectDataMaper alloc] init];
    editing = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        for (int j = 0; j < 2; j++) {
            UIView *view = [[[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]] subviews] objectAtIndex:0] subviews]objectAtIndex:0];
            view.layer.cornerRadius = 6;
            view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
            view.layer.borderWidth = 1.0f;
        }
    }
    
    if (self.service != nil) {
        editing = YES;
        self.txtNumber.text = [self.service objectForKey:@"number"];
        self.txtDescription.text = [self.service objectForKey:@"name"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    if (editing) {
        NSDictionary *service = @{
                                  @"id": [self.service objectForKey:@"id"],
                                  @"number": self.txtNumber.text,
                                  @"name": self.txtDescription.text
                                 };
        
        if ([odm editService:service]) {
            if (![self.txtNumber.text isEqualToString:[self.service objectForKey:@"number"]]) {
                [ud setValue:self.txtNumber.text forKey:@"serviceSelected"];
                [ud synchronize];
            }
        }
    }
    else {
        NSDictionary *service = @{
                                  @"number": self.txtNumber.text,
                                  @"name": self.txtDescription.text
                                 };
        
        [odm saveService:service];
    }
    
    [ud setValue:self.txtNumber.text forKey:@"serviceSelected"];
    [ud synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)info:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Número de Servicio" message:@"Puedes consultar tu número de servicio en la sección superior derecha de tu recibo de luz" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 6;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
