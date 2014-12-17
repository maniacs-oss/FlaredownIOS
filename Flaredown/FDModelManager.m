//
//  FDModelManager.m
//  Flaredown
//
//  Created by Cole Cunningham on 11/3/14.
//  Copyright (c) 2014 Flaredown. All rights reserved.
//

#import "FDModelManager.h"

@implementation FDModelManager

static NSString *userObjectSessionLocation = @"userObject";
static NSString *entrySessionLocation = @"entry";
static NSString *inputsSessionLocation = @"inputs";

+ (id)sharedManager
{
    static FDModelManager *sharedModelManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedModelManager = [[self alloc] init];
    });
    return sharedModelManager;
}

- (id)init
{
    if(self = [super init]) {
        
    }
    return self;
}

- (NSArray *)questionsForSection:(int)section
{
    NSMutableArray *mutableQuestions = [[NSMutableArray alloc] init];
    for(FDQuestion *question in [_entry questions]) {
        if([question section] == section) {
            [mutableQuestions addObject:question];
        }
    }
    return [mutableQuestions count] > 0 ? mutableQuestions : nil;
}

- (int)numberOfQuestionSections
{
    int highestSection = 0;
    for (FDQuestion *question in [_entry questions]) {
        if([question section] > highestSection)
            highestSection = (int)[question section];
    }
    return highestSection + 1;
}

- (void)saveSession
{
    if(_userObject != nil) {
        NSData *userObjectData = [NSKeyedArchiver archivedDataWithRootObject:[_userObject dictionaryCopy]];
        [[NSUserDefaults standardUserDefaults] setObject:userObjectData forKey:userObjectSessionLocation];
    }
    
    if(_entry != nil) {
        NSData *entryData = [NSKeyedArchiver archivedDataWithRootObject:[_entry dictionaryCopy]];
        [[NSUserDefaults standardUserDefaults] setObject:entryData forKey:entrySessionLocation];
    }
    
    if(_inputs != nil) {
        NSMutableArray *mutableInputs = [[NSMutableArray alloc] init];
        for (FDInput *input in _inputs) {
            [mutableInputs addObject:[input dictionaryCopy]];
        }
        NSData *inputsData = [NSKeyedArchiver archivedDataWithRootObject:mutableInputs];
        [[NSUserDefaults standardUserDefaults] setObject:inputsData forKey:inputsSessionLocation];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)restoreSession
{
    if([[NSUserDefaults standardUserDefaults] objectForKey:userObjectSessionLocation]) {
        NSData *userObjectData = [[NSUserDefaults standardUserDefaults] objectForKey:userObjectSessionLocation];
        NSDictionary *userObjectDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:userObjectData];
        _userObject = [[FDUser alloc] initWithDictionary:userObjectDictionary];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:entrySessionLocation]) {
        NSData *entryData = [[NSUserDefaults standardUserDefaults] objectForKey:entrySessionLocation];
        NSDictionary *entryDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:entryData];
        _entry = [[FDEntry alloc] initWithDictionary:entryDictionary];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:inputsSessionLocation]) {
        NSData *inputsData = [[NSUserDefaults standardUserDefaults] objectForKey:inputsSessionLocation];
        NSArray *inputsArray = [NSKeyedUnarchiver unarchiveObjectWithData:inputsData];
        NSMutableArray *mutableInputs = [[NSMutableArray alloc] init];
        for (NSDictionary *input in inputsArray) {
            [mutableInputs addObject:[[FDInput alloc] initWithDictionary:input]];
        }
        _inputs = [mutableInputs copy];
    }
}

- (void)clearCurrentEntry
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:entrySessionLocation];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:inputsSessionLocation];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)clearSession
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userObjectSessionLocation];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:entrySessionLocation];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:inputsSessionLocation];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
