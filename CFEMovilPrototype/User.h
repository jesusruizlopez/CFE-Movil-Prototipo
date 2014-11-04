//
//  User.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface User : NSManagedObject

@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *twitter;

@end
