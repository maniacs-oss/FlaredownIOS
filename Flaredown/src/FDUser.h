//
//  FDUser.h
//  Flaredown
//
//  Created by Cole Cunningham on 11/3/14.
//  Copyright (c) 2014 Flaredown. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FDTreatment;
@class FDSymptom;


typedef enum : NSUInteger {
    SexMale,
    SexFemale,
    SexOther,
    SexUndisclosed,
    SexNone
} Sex;

@interface FDUser : NSObject

@property NSInteger userId;
@property NSString *email;
@property NSString *authenticationToken;

@property NSInteger birthDateDay;
@property NSInteger birthDateMonth;
@property NSInteger birthDateYear;
@property NSString *location;
@property Sex sex;

@property BOOL onboarded;
@property NSDate *createdAt;
@property NSDate *updatedAt;

@property NSMutableArray *treatments;
@property NSMutableDictionary *previousDoses;
@property NSMutableArray *symptoms;
@property NSMutableArray *conditions;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSString *)sexString;
- (NSDate *)birthdayDate;
- (NSDictionary *)dictionaryCopy;

@end
