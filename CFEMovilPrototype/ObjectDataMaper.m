//
//  ObjectDataMaper.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "ObjectDataMaper.h"

@implementation ObjectDataMaper

- (BOOL)saveService:(NSDictionary *)service {
    NSError *error;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    Service *serv;
    serv = [NSEntityDescription insertNewObjectForEntityForName:@"Service" inManagedObjectContext:self.context];
    
    serv.number = [service objectForKey:@"number"];
    serv.name = [service objectForKey:@"name"];
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)saveEmail:(NSString *)email {
    NSDictionary *userData = [self getUser];
    
    NSError *error;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    User *user;
    if (userData == nil) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    }
    else {
        [self.request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", [userData objectForKey:@"id"]];
        [self.request setPredicate:predicate];
        user = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    }
    
    user.email = email;
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)saveTwitter:(NSString *)twitter {
    NSDictionary *userData = [self getUser];
    
    NSError *error;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    User *user;
    if (userData == nil) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.context];
    }
    else {
        [self.request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", [userData objectForKey:@"id"]];
        [self.request setPredicate:predicate];
        user = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    }
    
    user.twitter = twitter;
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (NSDictionary *)getServiceByNumber:(NSString *)number {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    Service *service;
    [self.request setEntity:[NSEntityDescription entityForName:@"Service" inManagedObjectContext:self.context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"number == %@", number];
    [self.request setPredicate:predicate];
    service = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    if (error != nil || service == nil)
        return nil;
    
    NSDictionary *result = @{
                             @"id": [service objectID],
                             @"number": (service.number == nil) ? @"" : service.number,
                             @"name": (service.name == nil) ? @"" : service.name
                            };
    return result;
}

- (NSMutableArray *)getServices {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Service" inManagedObjectContext:self.context]];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *services = [self.context executeFetchRequest:self.request error:&error];
    
    if (error != nil)
        return result;
    
    for (Service *service in services) {
        NSDictionary *obj = @{
                @"id": [service objectID],
                @"number": service.number,
                @"name": service.name
              };
        [result insertObject:obj atIndex:0];
    }
    return result;
}

- (NSDictionary *)getUser {
    NSError *error;
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context]];
    User *user = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    if (error != nil || user == nil)
        return nil;
    
    NSDictionary *result = @{
                            @"id": [user objectID],
                            @"email": (user.email == nil) ? @"" : user.email,
                            @"twitter": (user.twitter == nil) ? @"" : user.twitter
                           };
    return result;
}

- (NSMutableArray *)getNotifications {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Notification" inManagedObjectContext:self.context]];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *notifications = [self.context executeFetchRequest:self.request error:&error];
    
    if (error != nil)
        return result;
    
    for (Notification *notification in notifications) {
        NSDictionary *obj = @{
                @"id": [notification objectID],
                @"identifier": notification.identifier,
                @"type": notification.type,
                @"image": notification.image,
                @"title": notification.title,
                @"message": notification.message
              };
        [result insertObject:obj atIndex:0];
    }
    return result;
}

- (BOOL)saveReport:(NSDictionary *)data {
    
    NSError *error;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    Report *report;
    report = [NSEntityDescription insertNewObjectForEntityForName:@"Report" inManagedObjectContext:self.context];
    
    report.type = [data objectForKey:@"type"];
    report.image = [data objectForKey:@"image"];
    report.title = [data objectForKey:@"title"];
    report.observations = [data objectForKey:@"observations"];
    report.service = [data objectForKey:@"service"];
    report.email = [data objectForKey:@"email"];
    report.twitter = [data objectForKey:@"twitter"];
    report.date = [data objectForKey:@"date"];
    report.qualified = @"0";
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)qualifyndReport:(NSDictionary *)rate {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Report" inManagedObjectContext:self.context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", [rate objectForKey:@"id"]];
    [self.request setPredicate:predicate];
    Report *report = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    report.qualified = [rate objectForKey:@"rate"];
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (NSMutableArray *)getReports:(NSString *)type {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Report" inManagedObjectContext:self.context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", type];
    [self.request setPredicate:predicate];

    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *reports = [self.context executeFetchRequest:self.request error:&error];

    if (error != nil)
        return result;
    
    for (Report *report in reports) {
        NSDictionary *obj = @{
                              @"id": [report objectID],
                              @"type": report.type,
                              @"image": report.image,
                              @"title": report.title,
                              @"observations": report.observations,
                              @"service": report.service,
                              @"email": report.email,
                              @"twitter": report.twitter,
                              @"date": report.date,
                              @"qualified": report.qualified
                            };
        [result insertObject:obj atIndex:0];
    }
    
    return result;
}

- (BOOL)editService:(NSDictionary *)serviceData {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Service" inManagedObjectContext:self.context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", [serviceData objectForKey:@"id"]];
    [self.request setPredicate:predicate];
    Service *service = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    service.number = [serviceData objectForKey:@"number"];
    service.name = [serviceData objectForKey:@"name"];
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)deleteService:(id)objectId {
    NSError *error;
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Service" inManagedObjectContext:self.context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", objectId];
    [self.request setPredicate:predicate];
    
    [self.context deleteObject:[[self.context executeFetchRequest:self.request error:&error] lastObject]];
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)editEmail:(NSString *)email {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context]];
    User *user = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    user.email = email;
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)editTwitter:(NSString *)twitter {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context]];
    User *user = [[self.context executeFetchRequest:self.request error:&error] firstObject];
    
    user.twitter = twitter;
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (BOOL)saveComment:(NSDictionary *)data {
    NSError *error;
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    Comment *comment;
    comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:self.context];
    
    comment.user = [data objectForKey:@"user"];
    comment.report = [NSString stringWithFormat:@"%@", [data objectForKey:@"report"]];
    comment.comment = [data objectForKey:@"comment"];
    
    [self.context save:&error];
    
    if (error != nil)
        return NO;
    return YES;
}

- (NSMutableArray *)getComments:(id)objectId {
    NSError *error;
    
    self.request = [[NSFetchRequest alloc] init];
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.context = [self.appDelegate managedObjectContext];
    
    [self.request setEntity:[NSEntityDescription entityForName:@"Comment" inManagedObjectContext:self.context]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"report == %@", [NSString stringWithFormat:@"%@", objectId]];
    [self.request setPredicate:predicate];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSArray *comments = [self.context executeFetchRequest:self.request error:&error];
    
    if (error != nil)
        return result;
    
    for (Comment *comment in comments) {
        NSDictionary *obj = @{
                              @"id": [comment objectID],
                              @"report": comment.report,
                              @"user": comment.user,
                              @"comment": comment.comment
                             };
        [result addObject:obj];
    }
    
    return result;
}

@end
