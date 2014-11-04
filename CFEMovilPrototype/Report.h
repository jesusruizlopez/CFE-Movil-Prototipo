//
//  Report.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Report : NSManagedObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *observations;
@property (strong, nonatomic) NSString *service;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *twitter;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *qualified;

@end
