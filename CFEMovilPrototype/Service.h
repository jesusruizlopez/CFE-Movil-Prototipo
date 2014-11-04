//
//  Service.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Service : NSManagedObject

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *name;

@end
