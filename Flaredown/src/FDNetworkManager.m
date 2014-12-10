//
//  FDNetworkManager.m
//  Flaredown
//
//  Created by Cole Cunningham on 10/7/14.
//  Copyright (c) 2014 Flaredown. All rights reserved.
//

#import "FDNetworkManager.h"
#import "MBProgressHUD.h"

static NSString *host = @"http://192.168.1.15:5000";
static NSString *api = @"/v1";

@implementation FDNetworkManager

+ (id)sharedManager
{
    static FDNetworkManager *sharedNetworkManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkManager = [[self alloc] init];
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    });
    return sharedNetworkManager;
}

- (id)init
{
    if(self = [super init]) {
        self.baseUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", host, api]];
    }
    return self;
}

/*
 *  Logs in the user with email and password, returns auth token
 */
- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(bool success, id response))completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/users/sign_in", self.baseUrl];
    NSDictionary *parameters = @{@"v1_user[email]":email, @"v1_user[password]":password};
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        completionBlock(true, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(false, nil);
    }];
}

- (void)createEntryWithEmail:(NSString *)email authenticationToken:(NSString *)authenticationToken date:(NSString *)date completion:(void (^)(bool success, id response))completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/entries", self.baseUrl];
    
    NSDictionary *parameters = @{@"user_email":email, @"user_token":authenticationToken, @"date":date};
    
    [manager POST:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        completionBlock(true, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(false, nil);
    }];
}

//- (void)getEntryFromDate:(NSString *)date email:(NSString *)email authenticationToken:(NSString *)authenticationToken completion:(void (^)(bool success, id response))completionBlock
//{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    NSString *url = [NSString stringWithFormat:@"%@/entries/%@", self.baseUrl, date];
//    
//    NSDictionary *parameters = @{@"user_email":email, @"user_token":authenticationToken};
//    
//    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        completionBlock(true, responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//        completionBlock(false, nil);
//    }];
//}

- (void)putEntry:(NSDictionary *)entry atId:(NSString *)entryId email:(NSString *)email authenticationToken:(NSString *)authenticationToken completion:(void (^)(bool success, id response))completionBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *url = [NSString stringWithFormat:@"%@/entries/%@", self.baseUrl, entryId];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:entry options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary *parameters = @{@"entry":jsonString, @"user_email":email, @"user_token":authenticationToken};
    
    [manager PUT:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        completionBlock(true, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        completionBlock(false, nil);
    }];

}

+ (BOOL)networkReachable
{
    if([AFNetworkReachabilityManager sharedManager].reachable)
        return YES;
    NSLog(@"No network connection");
    [[[UIAlertView alloc] initWithTitle:@"Network Connection Unavailable"
                                message:@"This app requires an active network connection. Please connect to a network and try again."
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
    return NO;
}

@end