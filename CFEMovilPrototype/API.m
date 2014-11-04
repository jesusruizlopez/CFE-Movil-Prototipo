//
//  API.m
//  CFEMovilPrototype
//
//  Created by Jesús Ruiz on 02/11/14.
//  Copyright (c) 2014 Pretzel. All rights reserved.
//

#import "API.h"

// #define BASE_URL @"http://localhost:3000"
#define BASE_URL @"http://cfeapi-experimentos.rhcloud.com"
#define APIKEY @"b3a2a122ab1a51fb74c929b96798f892b719bb97d1e45b4d79787c8af8dac1dc"

@implementation API

+ (NSDictionary *)getUbications {
    NSError *error;
    NSURLResponse *response;
    
    NSString *url = [NSString stringWithFormat:@"%@/ubications", BASE_URL];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:APIKEY forHTTPHeaderField:@"apikey"];
    [request setTimeoutInterval:20];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    if (error)
        return @{@"success": @"0", @"message": @"Ocurrió un error en el servidor"};
    else
        return [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableContainers error:&error];
}

@end
