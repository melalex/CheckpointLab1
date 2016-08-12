//
//  MELFamilyInteractor.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/2/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELFamilyInteractor.h"
#import "MELDataStore.h"
#import "MELTree.h"
#import "MELPerson.h"
#import "MELUpcommingPerson.h"
#import "MELPersonInteractorIO.h"

@interface MELFamilyInteractor()
{
@private
    MELDataStore *_dataStore;
    
    MELTree *_selectedTree;
}

@property (readonly, retain) MELDataStore *dataStore;

@property (retain) MELTree *selectedTree;

@property (retain) NSMutableArray<NSMutableArray *> *treeGraph;

@property NSInteger width;

@end

@implementation MELFamilyInteractor

- (instancetype)initWithDataStore:(MELDataStore *)dataStore
{
    if (self = [self init])
    {
        _dataStore = [dataStore retain];
        _width = 0;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
 
    [_dataStore release];
    [_selectedTree release];
    [_treeGraph release];
    
    [super dealloc];
}

- (void)configureNameAndAuthor
{
    [self.output configureTitle:self.selectedTree.title];
    [self.output configureAuthor:self.selectedTree.author];
}

- (void)treeStructureChanged
{
    [self.output configureTreeStructure:[self getPersonsList]];
    [self updateTreeGraph];
    [self.output configureTreeGraph:self.treeGraph treeWidth:self.width];
}

- (void)fullnameOfSomePersonChanged
{
    [self.output configureTreeStructure:[self getPersonsList]];
    [self.output configureTreeGraph:self.treeGraph treeWidth:self.width];
}


- (void)setTree:(NSInteger)index
{
    self.selectedTree = [self.dataStore treeAtIndex:index];
}

- (void)addPerson
{
    MELPerson *person = [MELPerson personWithName:@"Nan" middleName:@"Nan" surname:@"Nan"];
    [self.selectedTree addPerson:person];
    [self.dataStore addPerson:person toTree:self.selectedTree.identifier];
}

- (void)deletePersonAtIndex:(NSInteger)index
{
    MELPerson *personToDelete = [self.selectedTree.persons objectAtIndex:index];
    
    [personToDelete.father removeChild:personToDelete];
    [personToDelete.mother removeChild:personToDelete];
    
    [self.dataStore deletePerson:personToDelete.identifier];
    [self.selectedTree removePerson:personToDelete];
}

- (NSArray<MELUpcommingPerson *> *)getPersonsList
{
    NSMutableArray<MELUpcommingPerson *> *result = [[NSMutableArray alloc] init];
    
    for (MELPerson *person in self.selectedTree.persons)
    {
        [result addObject:[self upcommingPersonFromPerson:person]];
    }
    
    return [result autorelease];
}

- (MELUpcommingPerson *)upcommingPersonFromPerson:(MELPerson *)person
{
    MELUpcommingPerson *result = nil;
    NSMutableString *children = [[[NSMutableString alloc] init] autorelease];
    
    for (MELPerson *child in person.children)
    {
        [children appendFormat:@"%@; ", child.fullName];
    }
    
    result = [[[MELUpcommingPerson alloc] initWithFullname:person.fullName
                                                fatherName:person.father.fullName
                                                motherName:person.mother.fullName
                                             childrenNames:children] autorelease];
    
    return result;
}

- (void)setTreeAndPersonAtIndex:(NSInteger)index toInteractor:(id<MELPersonInteractorSetup>)interactor;
{
    [interactor setTree:self.selectedTree person:[self.selectedTree.persons objectAtIndex:index]];
}

- (void)save
{
    [self.dataStore pushTree:self.selectedTree];
}

#pragma mark - TreeGraph

- (void)updateTreeGraph
{
    NSMutableArray<NSMutableArray *> *result = [NSMutableArray array];
    NSMutableArray<MELPerson *> *generation = nil;
    
    for (NSInteger i = 0; i <= MELPerson.lastGeneration; i++)
    {
        generation = [NSMutableArray array];
        for (MELPerson *person in self.selectedTree.persons)
        {
            if (person.generation == i)
            {
                [generation addObject:person];
            }
        }
        [result addObject:generation];
        
        if (self.width < generation.count)
        {
            self.width = generation.count;
        }
    }
    
    self.treeGraph = result;
}

#pragma mark - MELFamilyInteractorSetters

- (void)setSelectedTree:(MELTree *)selectedTree
{
    if (_selectedTree != selectedTree)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        
        if (_selectedTree != nil)
        {
            [self.dataStore pushTree:_selectedTree];
        }
        
        [_selectedTree release];
        _selectedTree = [selectedTree retain];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(configureNameAndAuthor)
                                                     name:kMELTreeDidChangeTitleOrAuthorNotification
                                                   object:_selectedTree];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(fullnameOfSomePersonChanged)
                                                     name:kMELTreeDidChangeFullnameOfSomePersonNotification
                                                   object:_selectedTree];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(treeStructureChanged)
                                                     name:kMELTreeDidChangeStructureNotification
                                                   object:_selectedTree];
        
        [self configureNameAndAuthor];
        [self treeStructureChanged];
    }
}

- (void)setTitle:(NSString *)title
{
    self.selectedTree.title = title;
}

- (void)setAuthor:(NSString *)author
{
    self.selectedTree.author = author;
}

#pragma mark - MELFamilyInteractorGetters

- (MELDataStore *)dataStore
{
    return _dataStore;
}

- (MELTree *)selectedTree
{
    return _selectedTree;
}

- (NSString *)title
{
    return self.selectedTree.title;
}

- (NSString *)author
{
    return self.selectedTree.author;
}

@end
