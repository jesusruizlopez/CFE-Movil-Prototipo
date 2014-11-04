//
//  ObjectDataMaper.h
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#import "Service.h"
#import "User.h"
#import "Notification.h"
#import "Report.h"
#import "Comment.h"

@interface ObjectDataMaper : NSObject

@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (strong, nonatomic) NSEntityDescription *entity;
@property (strong, nonatomic) NSFetchRequest *request;

- (BOOL)saveService:(NSDictionary *)service;
- (NSMutableArray *)getServices;
- (BOOL)saveEmail:(NSString *)email;
- (BOOL)editEmail:(NSString *)email;
- (BOOL)saveTwitter:(NSString *)twitter;
- (BOOL)editTwitter:(NSString *)twitter;
- (NSDictionary *)getServiceByNumber:(NSString *)number;
- (NSDictionary *)getUser;
- (NSMutableArray *)getNotifications;
- (BOOL)saveReport:(NSDictionary *)report;
- (BOOL)qualifyndReport:(NSDictionary *)rate;
- (NSMutableArray *)getReports:(NSString *)type;
- (BOOL)editService:(NSDictionary *)serviceData;
- (BOOL)deleteService:(id)objectId;
- (BOOL)saveComment:(NSDictionary *)data;
- (NSMutableArray *)getComments:(id)objectId;

@end
