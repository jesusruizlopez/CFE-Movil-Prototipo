//
//  UbicationTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 03/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "UbicationTableViewController.h"

@interface UbicationTableViewController ()

@end

@implementation UbicationTableViewController {
    GMSMapView *mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UIView *view = [self.tableView viewWithTag:1001];
    mapView = [[GMSMapView alloc] initWithFrame:CGRectMake(8, 9, 304, 126)];
    mapView.layer.cornerRadius = 6;
    mapView.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
    mapView.layer.borderWidth = 1.0f;
    
    [view addSubview:mapView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *string = [self.ubication objectForKey:@"latitude"];
    string = [string stringByReplacingOccurrencesOfString:@"," withString:@"."];
    double latitude = [string doubleValue];
    
    string = [self.ubication objectForKey:@"longitude"];
    string = [string stringByReplacingOccurrencesOfString:@"," withString:@"."];
    double longitude = [string doubleValue];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.map = mapView;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude longitude:longitude zoom:14];
    [mapView setCamera:camera];
    
    for (int i = 0; i < self.tableView.numberOfSections; i++) {
        for (int j = 0; j < 4; j++) {
            UIView *view = [[[[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:j inSection:i]] subviews] objectAtIndex:0] subviews]objectAtIndex:0];

            view.layer.cornerRadius = 6;
            view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
            view.layer.borderWidth = 1.0f;
        }
    }
    
    self.lblUbication.text = [NSString stringWithFormat:@"%@. Col. %@", [self.ubication objectForKey:@"address"], [self.ubication objectForKey:@"colony"]];
    self.lblSchedule.text = [self.ubication objectForKey:@"schedule_of_attention"];
    self.lblDays.text = [self.ubication objectForKey:@"available_days"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)goWalk:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo" message:@"Esta funcionalidad no se encuentra disponible en la versión demo" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)goDrive:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo" message:@"Esta funcionalidad no se encuentra disponible en la versión demo" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 4;
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
