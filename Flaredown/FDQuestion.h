//
//  FDQuestion.h
//  Flaredown
//
//  Created by Cole Cunningham on 11/10/14.
//  Copyright (c) 2014 Flaredown. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FDQuestion : NSObject

@property NSString *catalog;
@property NSString *group;
@property NSInteger questionId;
@property NSArray *inputIds;
@property NSString *kind;
@property NSString *localizedName;
@property NSString *name;
@property NSInteger section;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (NSDictionary *)dictionaryCopy;

@end
