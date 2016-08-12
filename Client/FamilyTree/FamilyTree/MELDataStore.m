//
//  MELDataStore.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELDataStore.h"
#import "MELTree.h"
#import "MELPerson.h"
#import "MELConnectionManager.h"

@interface MELDataStore()
{
@private
    NSMutableArray<MELTree *> *_trees;
    MELConnectionManager *_connectionManager;
}

@property (retain) NSMutableArray<MELTree *> *mTrees;
@property (readonly) MELConnectionManager *connectionManager;

@end

@implementation MELDataStore

- (instancetype)init
{
    if (self = [super init])
    {
        _trees = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_trees release];
    [_connectionManager release];
    
    [super dealloc];
}

- (void)setTreesList
{
    [self.connectionManager setTreesList];
}

- (void)addTree:(MELTree *)tree
{
    [self.mTrees addObject:tree];
    [self.connectionManager addTree:[self treeDictionaryRepresentation:tree]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTreesLocally)
                                                 name:kMELTreeDidChangeStructureNotification
                                               object:tree];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTreesLocally)
                                                 name:kMELTreeDidChangeTitleOrAuthorNotification
                                               object:tree];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELDataStoreDidChangeTreesListNotification object:self];
}

- (void)addPerson:(MELPerson *)person toTree:(NSString *)tree
{
    [self.connectionManager addPerson:[self personDictionaryRepresentation:person ofTree:tree]];
}

- (void)deleteTreeAtIndex:(NSInteger)index
{
    [self.connectionManager deleteTree:[[self.mTrees objectAtIndex:index] identifier]];
    [self.mTrees removeObjectAtIndex:index];
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELDataStoreDidChangeTreesListNotification object:self];
}

- (void)deletePerson:(NSString *)identifier
{
    [self.connectionManager deletePerson:identifier];
}

- (MELTree *)treeAtIndex:(NSInteger)index;
{
    MELTree *tree = [self.trees objectAtIndex:index];
    [self.connectionManager setPersonsOfTree:tree];
    return tree;
}

- (void)pushTree:(MELTree *)tree
{
    [self.connectionManager pushTree:[self treeDictionaryRepresentation:tree]];
}

- (void)pushPerson:(MELPerson *)person ofTree:(NSString *)tree
{
    [self.connectionManager pushPerson:[self personDictionaryRepresentation:person ofTree:tree]];
}



- (void)updateTreesLocally
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELDataStoreDidChangeTreesListNotification object:self];
}

#pragma mark - dictionaryRepresentation

- (NSDictionary *)personDictionaryRepresentation:(MELPerson *)person ofTree:(NSString *)tree
{
    return @{@"identifier"     : person.identifier,
             @"gender"         : [NSNumber numberWithInt:person.gender],
             @"name"           : person.name,
             @"middleName"     : person.middleName,
             @"surname"        : person.surname,
             @"father"         : person.father ? person.fatherIdentifier : @"Nan",
             @"mother"         : person.mother ? person.motherIdentifier : @"Nan",
             @"treeIdentifier" : tree};
}

- (NSDictionary *)treeDictionaryRepresentation:(MELTree *)tree
{
    return @{@"identifier" : tree.identifier,
             @"title"      : tree.title,
             @"author"     : tree.author};
}

- (MELPerson *)personFromDictionaryRepresentation:(NSDictionary *)person
{
    MELPerson *result = [[MELPerson alloc] initWithIdentifier:person[@"identifier"]];
    
    result.gender = [person[@"gender"] longLongValue];
    result.name = person[@"name"];
    result.middleName = person[@"middleName"];
    result.surname = person[@"surname"];
    result.motherIdentifier = person[@"father"];
    result.fatherIdentifier = person[@"mother"];

    return [result autorelease];
}

- (MELTree *)treeFromDictionaryRepresentation:(NSDictionary *)tree
{
    return [[[MELTree alloc] initWithTitle:tree[@"title"] author:tree[@"author"] numberOfPersons:[tree[@"numberOfPersons"][0][@"0"] longLongValue] identifier:tree[@"identifier"]] autorelease];
}

- (NSArray<MELPerson *> *)personsListFromDictionaryRepresentation:(NSArray<NSDictionary *> *)personList
{
    NSMutableArray<MELPerson *> *result = [NSMutableArray array];
    
    for (NSDictionary *person in personList)
    {
        [result addObject:[self personFromDictionaryRepresentation:person]];
    }
    
    for (MELPerson *person in result)
    {
        for (MELPerson *parent in result)
        {
            if ([person.fatherIdentifier isEqualToString:parent.identifier])
            {
                [parent addChild:person];
                person.father = parent;
            }
            else if ([person.motherIdentifier isEqualToString:parent.identifier])
            {
                [parent addChild:person];
                person.mother = parent;
            }
        }
    }
    
    return result;
}

- (NSArray<MELTree *> *)treesListFromDictionaryRepresentation:(NSArray<NSDictionary *> *)treesList
{
    NSMutableArray<MELTree *> *result = [NSMutableArray array];
    
    for (NSDictionary *tree in treesList)
    {
        [result addObject:[self treeFromDictionaryRepresentation:tree]];
    }
    
    return result;
}

#pragma mark - MELDataStoreSetters

- (void)setMTrees:(NSMutableArray<MELTree *> *)mTrees
{
    if (_trees != mTrees)
    {
        [_trees release];
        _trees = [mTrees retain];
        [[NSNotificationCenter defaultCenter] postNotificationName:kMELDataStoreDidChangeTreesListNotification object:self];
    }
}

- (void)setTrees:(NSArray<MELTree *> *)trees
{
    self.mTrees = [NSMutableArray arrayWithArray:trees];
    
    for (MELTree *tree in self.mTrees)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTreesLocally)
                                                     name:kMELTreeDidChangeStructureNotification
                                                   object:tree];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTreesLocally)
                                                     name:kMELTreeDidChangeTitleOrAuthorNotification
                                                   object:tree];

    }
}

#pragma mark - MELDataStoreGetters

- (NSMutableArray<MELTree *> *)mTrees
{
    return _trees;
}

- (NSArray<MELTree *> *)trees
{
    return [(NSArray<MELTree *> *)[self.mTrees copy] autorelease];
}

- (MELConnectionManager *)connectionManager
{
    if (_connectionManager == nil)
    {
        _connectionManager = [[MELConnectionManager alloc] initWithDataStore:self];
    }
    return _connectionManager;
}

@end
