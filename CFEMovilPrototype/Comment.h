//
//  Comment.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 03/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface Comment : NSManagedObject

@property (strong, nonatomic) NSString *report;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *comment;

@end
