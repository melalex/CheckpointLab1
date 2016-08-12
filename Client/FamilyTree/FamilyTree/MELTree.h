//
//  MELTree.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MELPerson;

static NSString *const kMELTreeDidChangeStructureNotification = @"kMELTreeDidChangeStructureNotification";
static NSString *const kMELTreeDidChangeFullnameOfSomePersonNotification = @"kMELTreeDidChangeFullnameOfSomePersonNotification";
static NSString *const kMELTreeDidChangeTitleOrAuthorNotification = @"kMELTreeDidChangeNotification";

@interface MELTree : NSObject

@property (readonly) NSString *identifier;

@property (copy) NSString *title;
@property (copy) NSString *author;

@property NSInteger numberOfPersons;

@property (retain) NSArray<MELPerson *> *persons;

+ (instancetype)emptyTree;

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author numberOfPersons:(NSInteger)numberOfPersons;
- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author numberOfPersons:(NSInteger)numberOfPersons identifier:(NSString *)identifier;

- (void)addPerson:(MELPerson *)person;
- (void)removePerson:(MELPerson *)person;

@end
