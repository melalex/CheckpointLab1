//
//  MELInteractor.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELUpcommingTree.h"
#import "MELTree.h"
#import "MELMainMenuInteractor.h"
#import "MELDataStore.h"

@interface MELMainMenuInteractor()
{
@private
    MELDataStore *_dataStore;
}

@property (readonly) MELDataStore *dataStore;

@end

@implementation MELMainMenuInteractor

- (instancetype)initWithDataStore:(MELDataStore *)dataStore
{
    if (self = [self init])
    {
        _dataStore = [dataStore retain];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePresenter)
                                                     name:kMELDataStoreDidChangeTreesListNotification
                                                   object:_dataStore];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_dataStore release];
    
    [super dealloc];
}

- (void)addNewTree
{
    [self.dataStore addTree:[MELTree emptyTree]];
}

- (void)deleteTreeAtIndex:(NSInteger)index
{
    [self.dataStore deleteTreeAtIndex:index];
}

- (NSArray<MELUpcommingTree *> *)getTreesList
{
    NSMutableArray<MELUpcommingTree *> *result = [[NSMutableArray alloc] init];
    
    for (MELTree *tree in self.dataStore.trees)
    {
        [result addObject:[self upcommingTreeFromTree:tree]];
    }
    
    return [result autorelease];
}

- (MELUpcommingTree *)upcommingTreeFromTree:(MELTree *)tree
{
    return [[[MELUpcommingTree alloc] initWithTitle:tree.title author:tree.author numberOfPersons:tree.numberOfPersons] autorelease];
}

- (void)updatePresenter
{
    [self.output configureTreesList:[self getTreesList]];
}

- (void)loadData
{
    [self.dataStore setTreesList];
}

#pragma mark - MELMainMenuInteractorSetters


#pragma mark - MELMainMenuInteractorGetters

- (MELDataStore *)dataStore
{
    return _dataStore;
}

@end
