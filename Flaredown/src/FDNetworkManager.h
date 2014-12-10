//
//  FDNetworkManager.h
//  Flaredown
//
//  Created by Cole Cunningham on 10/7/14.
//  Copyright (c) 2014 Flaredown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface FDNetworkManager : NSObject

@property (strong, nonatomic) NSURL *baseUrl;

+ (id)sharedManager;
- (void)loginUserWithEmail:(NSString *)email password:(NSString *)password completion:(void (^)(bool success, id response))completionBlock;
//- (void)getEntryFromDate:(NSString *)date email:(NSString *)email authenticationToken:(NSString *)authenticationToken completion:(void (^)(bool success, id response))completionBlock;
- (void)createEntryWithEmail:(NSString *)email authenticationToken:(NSString *)authenticationToken date:(NSString *)date completion:(void (^)(bool success, id response))completionBlock;
- (void)putEntry:(NSDictionary *)entry atId:(NSString *)entryId email:(NSString *)email authenticationToken:(NSString *)authenticationToken completion:(void (^)(bool success, id response))completionBlock;

+ (BOOL)networkReachable;

@end
