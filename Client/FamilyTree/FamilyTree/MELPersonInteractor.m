//
//  MELPersonInteractor.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPersonInteractor.h"
#import "MELPerson.h"
#import "MELTree.h"
#import "MELDataStore.h"

@interface MELPersonInteractor()
{
@private
    MELDataStore *_dataStore;
    
    MELTree *_selectedTree;
    MELPerson *_selectedPerson;
}

@property (readonly, retain) MELDataStore *dataStore;

@property (retain) MELTree *selectedTree;
@property (retain) MELPerson *selectedPerson;

@property (retain) NSArray<MELPerson *> *potentialFather;
@property (retain) NSArray<MELPerson *> *potentialMother;
@property (retain) NSArray<MELPerson *> *potencialChildren;

@end

@implementation MELPersonInteractor

- (instancetype)initWithDataStore:(MELDataStore *)dataStore
{
    if (self = [self init])
    {
        _dataStore = [dataStore retain];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_selectedTree release];
    [_selectedPerson release];
    
    [_potentialFather release];
    [_potentialFather release];
    [_potencialChildren release];
    
    [_dataStore release];
    
    [super dealloc];
}

- (void)setTree:(MELTree *)tree person:(MELPerson *)person;
{
    if (self.selectedPerson != person)
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];

        self.selectedTree = tree;
        self.selectedPerson = person;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(configureParents)
                                                     name:kMELPersonDidChangeFamilyNotification
                                                   object:self.selectedPerson];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(configureChildren)
                                                     name:kMELPersonDidChangeFamilyNotification
                                                   object:self.selectedPerson];

        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(configureFullname)
                                                     name:kMELPersonDidChangeFullnameNotification
                                                   object:self.selectedPerson];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(configureGender)
                                                     name:kMELPersonDidChangeGenderNotification
                                                   object:self.selectedPerson];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(setPotentialRelative)
                                                     name:kMELTreeDidChangeStructureNotification
                                                   object:self.selectedTree];
        
        
        [self configureFullname];
        [self configureGender];
        [self setPotentialRelative];
        [self configureParents];
        [self configureChildren];
    }
}

- (void)setGender:(NSInteger)gender
{
    self.selectedPerson.gender = gender;
}

- (void)addChild:(NSInteger)child
{
    if (child >= 0)
    {
        MELPerson *newChild = [self.potencialChildren objectAtIndex:child];
        
        if (self.selectedPerson.gender == kMELGenderFemale)
        {
            [newChild.mother removeChild:newChild];
            newChild.mother = self.selectedPerson;
            [self.selectedPerson addChild:newChild];
        }
        else if (self.selectedPerson.gender == kMELGenderMale)
        {
            [newChild.father removeChild:newChild];
            newChild.father = self.selectedPerson;
            [self.selectedPerson addChild:newChild];
        }
    }
}

- (void)removeChild:(NSInteger)child
{
    if (child >= 0)
    {
        MELPerson *removedChild = [self.selectedPerson.children objectAtIndex:child];
        
        if (self.selectedPerson.gender == kMELGenderFemale)
        {
            removedChild.mother = nil;
        }
        else if (self.selectedPerson.gender == kMELGenderMale)
        {
            removedChild.father = nil;
        }

        [self.selectedPerson removeChild:removedChild];
    }
}

- (void)save
{
    [self.dataStore pushPerson:self.selectedPerson ofTree:self.selectedTree.identifier];
}

- (void)configureFullname
{
    [self.output configureName:self.name];
    [self.output configureMiddleName:self.middleName];
    [self.output configureSurname:self.surname];
}

- (void)configureGender
{
    [self.output configureGender:self.selectedPerson.gender];
}

- (void)configureParents
{
    [self.output configureFather:self.selectedPerson.father.fullName andMother:self.selectedPerson.mother.fullName];
}

- (void)configureChildren
{
    NSMutableArray<NSString *> *children = [NSMutableArray array];
    
    for (MELPerson *child in self.selectedPerson.children)
    {
        [children addObject:child.fullName];
    }
    
    [self.output configureChildren:children];
}

#pragma mark - potentialRelative

- (void)setPotentialRelative
{
    BOOL (^isPotentialMotherBlock)(MELPerson *, NSDictionary *) = ^(MELPerson *evaluatedObject, NSDictionary *bindings)
    {
        BOOL result = YES;
        if (evaluatedObject.gender != kMELGenderFemale || [MELPerson isDescendant:evaluatedObject of:self.selectedPerson])
        {
            result = NO;
        }
        return result;
    };
    
    BOOL (^isPotentialFatherBlock)(MELPerson *, NSDictionary *) = ^(MELPerson *evaluatedObject, NSDictionary *bindings)
    {
        BOOL result = YES;
        if (evaluatedObject.gender != kMELGenderMale || [MELPerson isDescendant:evaluatedObject of:self.selectedPerson])
        {
            result = NO;
        }
        return result;
    };
    
    BOOL (^isPotencialChildBlock)(MELPerson *, NSDictionary *) = ^(MELPerson *evaluatedObject, NSDictionary *bindings)
    {
        BOOL result = YES;
        if (self.selectedPerson.gender == kMELGenderUnknown || [MELPerson isChild:evaluatedObject to:self.selectedPerson] || [MELPerson isAncestor:evaluatedObject toPerson:self.selectedPerson])
        {
            result = NO;
        }
        return result;
    };

    
    NSPredicate *isMotherPredicate = [NSPredicate predicateWithBlock:isPotentialMotherBlock];
    NSPredicate *isFatherPredicate = [NSPredicate predicateWithBlock:isPotentialFatherBlock];
    NSPredicate *isPotencialChild = [NSPredicate predicateWithBlock:isPotencialChildBlock];
    
    self.potentialMother = [self.selectedTree.persons filteredArrayUsingPredicate:isMotherPredicate];
    self.potentialFather = [self.selectedTree.persons filteredArrayUsingPredicate:isFatherPredicate];
    self.potencialChildren = [self.selectedTree.persons filteredArrayUsingPredicate:isPotencialChild];

    [self configurePotentialRelative];
}

- (void)configurePotentialRelative
{
    NSMutableArray<NSString *> *fathers = [NSMutableArray array];
    NSMutableArray<NSString *> *mothers = [NSMutableArray array];
    NSMutableArray<NSString *> *children = [NSMutableArray array];
    
    for (MELPerson *person in self.potentialFather)
    {
        [fathers addObject:person.fullName];
    }
    
    for (MELPerson *person in self.potentialMother)
    {
        [mothers addObject:person.fullName];
    }
    
    for (MELPerson *person in self.potencialChildren)
    {
        [children addObject:person.fullName];
    }
    
    [self.output configurePotentialFathers:fathers mothers:mothers children:children];
}

#pragma mark - setParents

- (void)setFather:(NSInteger)father
{
    MELPerson *newFather = nil;
    
    if (father >= 0)
    {
        newFather = [self.potentialFather objectAtIndex:father];
    }
    
    [self.selectedPerson.father removeChild:self.selectedPerson];
    [newFather addChild:self.selectedPerson];
    
    self.selectedPerson.father = newFather;
}

- (void)setMother:(NSInteger)mother
{
    MELPerson *newMother = nil;
    
    if (mother >= 0)
    {
        newMother = [self.potentialMother objectAtIndex:mother];
    }
    
    [self.selectedPerson.mother removeChild:self.selectedPerson];
    [newMother addChild:self.selectedPerson];
    
    self.selectedPerson.mother = newMother;
}

#pragma mark - MELPersonInteractorSetters

- (void)setSelectedPerson:(MELPerson *)selectedPerson
{
    if (_selectedPerson != selectedPerson)
    {
        if (_selectedPerson != nil)
        {
            [self.dataStore pushPerson:_selectedPerson ofTree:self.selectedTree.identifier];
        }
        
        [_selectedPerson release];
        _selectedPerson = [selectedPerson retain];
    }
}

- (void)setSelectedTree:(MELTree *)selectedTree
{
    if (_selectedTree != selectedTree)
    {
        [_selectedTree release];
        _selectedTree = [selectedTree retain];
    }
}


- (void)setName:(NSString *)name
{
    self.selectedPerson.name = name;
}

- (void)setMiddleName:(NSString *)middleName
{
    self.selectedPerson.middleName = middleName;
}

- (void)setSurname:(NSString *)surname
{
    self.selectedPerson.surname = surname;
}

#pragma mark - MELPersonInteractorGetters

- (MELTree *)selectedTree
{
    return _selectedTree;
}

- (MELPerson *)selectedPerson
{
    return _selectedPerson;
}

- (NSString *)name
{
    return self.selectedPerson.name;
}

- (NSString *)middleName
{
    return self.selectedPerson.middleName;
}

- (NSString *)surname
{
    return self.selectedPerson.surname;
}

@end
