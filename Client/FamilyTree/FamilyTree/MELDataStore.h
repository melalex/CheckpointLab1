//
//  MELDataStore.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MELTree;
@class MELPerson;

static NSString *const kMELDataStoreDidChangeTreesListNotification = @"kMELMainMenuInteractorDidChangeNotification";

@interface MELDataStore : NSObject

@property (retain) NSArray<MELTree *> *trees;

- (void)setTreesList;

- (void)addTree:(MELTree *)tree;
- (void)addPerson:(MELPerson *)person toTree:(NSString *)tree;

- (void)deleteTreeAtIndex:(NSInteger)index;
- (void)deletePerson:(NSString *)identifier;

- (MELTree *)treeAtIndex:(NSInteger)index;

- (void)pushTree:(MELTree *)tree;
- (void)pushPerson:(MELPerson *)person ofTree:(NSString *)tree;

- (void)updateTreesLocally;

- (NSArray<MELPerson *> *)personsListFromDictionaryRepresentation:(NSArray<NSDictionary *> *)personList;
- (NSArray<MELTree *> *)treesListFromDictionaryRepresentation:(NSArray<NSDictionary *> *)treesList;

@end
