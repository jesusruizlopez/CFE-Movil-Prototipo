//
//  InfoTableViewController.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "InfoTableViewController.h"
#import "API.h"
#import "UbicationTableViewController.h"
#import "RateTableViewCell.h"

@interface InfoTableViewController ()

@end

@implementation InfoTableViewController {
    GMSMapView *mapView;
    int sections;
    int rows;
    NSInteger selectedSegment;
    NSMutableArray *ratesList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    //Configure Accuracy depending on your needs, default is kCLLocationAccuracyBest
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    
    [locationManager requestWhenInUseAuthorization];
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
    
    sections = 1;
    rows = 1;
    selectedSegment = 0;
    
    NSString *titleString = @"";
    if (selectedSegment == 0)
        titleString = @"Mapa CFE";
    else
        titleString = @"Tarifas 2014";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:titleString style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // México
    // GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:27.6266557 longitude:-102.5375006 zoom:4];
    
    // Culiacán
    // GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:24.78883 longitude:-107.396274 zoom:14];
    
    // DF
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:19.4050704 longitude:-99.1714784 zoom:14];
    
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    mapView.delegate = self;
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    
    [self loadUbications];
    
    [self.tableView setBackgroundView:mapView];
    
    // Rates
    
    ratesList = [[NSMutableArray alloc] init];
    NSDictionary *rate = @{
                            @"type": @"1",
                            @"description": @"Servicio doméstico"
                          };
    [ratesList addObject:rate];

    rate = @{
            @"type": @"1A",
            @"description": @"Servicio doméstico para localidades con temperaturas media mínima en verano de 25 grados centígrados"
            };
    [ratesList addObject:rate];
    
    rate = @{
             @"type": @"1B",
             @"description": @"Servicio doméstico para localidades con temperaturas media mínima en verano de 28 grados centígrados"
             };
    [ratesList addObject:rate];

    rate = @{
             @"type": @"1C",
             @"description": @"Servicio doméstico para localidades con temperaturas media mínima en verano de 30 grados centígrados"
             };
    [ratesList addObject:rate];
    
    rate = @{
             @"type": @"1D",
             @"description": @"Servicio doméstico para localidades con temperaturas media mínima en verano de 31 grados centígrados"
             };
    [ratesList addObject:rate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUbications {
    
    dispatch_queue_t queue = dispatch_queue_create("ubicationsQueue", nil);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cargando..." message:@"Obteniendo ubicaciones, por favor espere" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
    [alert show];
    
    dispatch_async(queue, ^{
        
        NSDictionary *response = [API getUbications];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [alert dismissWithClickedButtonIndex:0 animated:YES];
            
            if ([[response objectForKey:@"success"] boolValue]) {
                
                for (NSDictionary *ubication in [response objectForKey:@"ubications"]) {
                    
                    NSString *string = [ubication objectForKey:@"latitude"];
                    string = [string stringByReplacingOccurrencesOfString:@"," withString:@"."];
                    double latitude = [string doubleValue];
                    
                    string = [ubication objectForKey:@"longitude"];
                    string = [string stringByReplacingOccurrencesOfString:@"," withString:@"."];
                    double longitude = [string doubleValue];
                    
                    GMSMarker *marker = [[GMSMarker alloc] init];
                    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
                    marker.title = [ubication objectForKey:@"schedule_of_attention"];
                    marker.snippet = [ubication objectForKey:@"available_days"];
                    [marker setUserData:ubication];
                    marker.map = mapView;
                }
            }
            else {
                [alert dismissWithClickedButtonIndex:-1 animated:YES];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:[response objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
                [alert show];
            }
        });
        
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedSegment == 0)
        return 44;
    return 85;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (selectedSegment == 0)
        return nil;
    
    UILabel *header = [[UILabel alloc] init];
    header.frame = CGRectMake(10, 20, 320, 30);
    [header setFont:[UIFont fontWithName:@"Avenir-Heavy" size:14]];
    header.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/250.0 alpha:1.0f];
    header.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:header];
    
    return headerView;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (selectedSegment == 0)
        return @"";
    return @"TARIFAS DOMÉSTICAS";
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (selectedSegment == 0)
        return 0;
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedSegment == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionsCell" forIndexPath:indexPath];
        return cell;
    }
    else {
        RateTableViewCell *rateCell = [tableView dequeueReusableCellWithIdentifier:@"rateCell" forIndexPath:indexPath];

        NSDictionary *rate = [ratesList objectAtIndex:indexPath.row];
        rateCell.lblType.text = [rate objectForKey:@"type"];
        rateCell.lblDescription.text = [rate objectForKey:@"description"];
        
        UIView *view = [[[[rateCell subviews] objectAtIndex:0] subviews] objectAtIndex:0];
        view.layer.cornerRadius = 6;
        view.layer.borderColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/250.0 alpha:1.0f].CGColor;
        view.layer.borderWidth = 1.0f;
        
        return rateCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (selectedSegment == 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Demo" message:@"Esta funcionalidad no se encuentra disponible en la versión demo" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
        [alert show];
    }
}


#pragma mark - IBAction

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    selectedSegment = segmentedControl.selectedSegmentIndex;
    if (selectedSegment == 0) {
        sections = 1;
        rows = 1;
        [self.tableView setScrollEnabled:NO];
        [self.tableView reloadData];
        [self.tableView setBackgroundView:mapView];
    }
    else{
        sections = 1;
        rows = (int)[ratesList count];
        [self.tableView setScrollEnabled:YES];
        [self.tableView setBackgroundView:nil];
        [self.tableView reloadData];
    }
}

- (IBAction)changeView:(id)sender {
    if (mapView.mapType == kGMSTypeNormal) {
        [sender setTitle:@"  Cambiar a vista: Normal" forState:UIControlStateNormal];
        [mapView setMapType:kGMSTypeHybrid];
    }
    else {
        [sender setTitle:@"  Cambiar a vista: Satélite" forState:UIControlStateNormal];
        [mapView setMapType:kGMSTypeNormal];
    }
}

- (IBAction)load:(id)sender {
    [self loadUbications];
}

#pragma mark - Google Maps

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    UbicationTableViewController *utvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ubicationView"];
    
    utvc.ubication = marker.userData;
    
    [self.navigationController pushViewController:utvc animated:YES];
    return YES;
}

- (BOOL)didTapMyLocationButtonForMapView:(GMSMapView *)mapView {
    [locationManager startUpdatingLocation];
    return YES;
}

#pragma mark - Location

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    
    // NSLog(@"location: %f - %f", location.coordinate.latitude, location.coordinate.longitude);
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude zoom:14];
    [mapView setCamera:camera];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Ocurrió un error al intentar obtener la ubicación, inténtelo de nuevo" delegate:nil cancelButtonTitle:@"Entendido" otherButtonTitles:nil, nil];
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
