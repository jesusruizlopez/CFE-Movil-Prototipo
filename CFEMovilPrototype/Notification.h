//
//  Notification.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Notification : NSManagedObject

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;

@end
