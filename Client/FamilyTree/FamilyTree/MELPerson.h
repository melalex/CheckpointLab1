//
//  MELPerson.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>

static NSString *const kMELPersonDidChangeFamilyNotification = @"kMELPersonDidChangeFamilyNotification";
static NSString *const kMELPersonDidChangeFullnameNotification = @"kMELPersonDidChangeFullnameNotification";
static NSString *const kMELPersonDidChangeGenderNotification = @"kMELPersonDidChangeGenderNotification";

typedef NS_ENUM (NSInteger, MELGender)
{
    kMELGenderUnknown = 0,
    kMELGenderMale = 1,
    kMELGenderFemale = 2
};

@interface MELPerson : NSObject

@property (readonly) NSString *identifier;

@property MELGender gender;

@property NSInteger generation;

@property (copy) NSString *name;
@property (copy) NSString *middleName;
@property (copy) NSString *surname;

@property (readonly) NSString *fullName;

@property (copy) NSString *motherIdentifier;
@property (copy) NSString *fatherIdentifier;

@property (assign) MELPerson *father;
@property (assign) MELPerson *mother;

@property (readonly) NSArray<MELPerson *> *children;

+ (instancetype)personWithName:(NSString *)name middleName:(NSString *)middleName surname:(NSString *)surname;

+ (NSInteger)lastGeneration;

+ (BOOL)isAncestor:(MELPerson *)potencialAncestor toPerson:(MELPerson *)person;
+ (BOOL)isDescendant:(MELPerson *)descendant of:(MELPerson *)ancestor;
+ (BOOL)isChild:(MELPerson *)person to:(MELPerson *)parent;

- (instancetype)initWithIdentifier:(NSString *)identifier;

- (void)addChild:(MELPerson *)child;
- (void)removeChild:(MELPerson *)child;

- (BOOL)isSameParents:(MELPerson *)person;

@end
