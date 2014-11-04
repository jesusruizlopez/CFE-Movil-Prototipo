//
//  UbicationTableViewController.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 03/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface UbicationTableViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *ubication;
@property (weak, nonatomic) IBOutlet UILabel *lblUbication;
@property (weak, nonatomic) IBOutlet UILabel *lblSchedule;
@property (weak, nonatomic) IBOutlet UILabel *lblDays;

@end
