//
//  InfoTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 20/10/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface InfoTableViewController : UITableViewController<CLLocationManagerDelegate, GMSMapViewDelegate> {
    CLLocationManager *locationManager;
}

@end
