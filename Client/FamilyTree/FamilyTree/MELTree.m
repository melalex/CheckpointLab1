//
//  MELTree.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELTree.h"
#import "MELPerson.h"

@interface MELTree()
{
@private
    NSString *_identifier;
    
    NSString *_title;
    NSString *_author;
    
    NSInteger _numberOfPersons;
    
    NSMutableArray<MELPerson *> *_persons;
}

@property (readonly) NSMutableArray<MELPerson *> *mPersons;

@end

@implementation MELTree

+ (instancetype)emptyTree
{ 
    return [[[MELTree alloc] initWithTitle:@"Nan" author:@"Nan" numberOfPersons:0] autorelease];
}

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author numberOfPersons:(NSInteger)numberOfPersons
{
    return [self initWithTitle:title author:author numberOfPersons:numberOfPersons identifier:[[NSUUID UUID] UUIDString]];
}

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author numberOfPersons:(NSInteger)numberOfPersons identifier:(NSString *)identifier
{
    if (self = [self init])
    {
        _title = [title retain];
        _author = [author retain];
        
        _numberOfPersons = numberOfPersons;
        
        _persons = [[NSMutableArray alloc] init];
        
        _identifier = [identifier copy];
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_persons release];
    [_title release];
    [_author release];
    [_identifier release];
    
    [super dealloc];
}


- (void)addPerson:(MELPerson *)person
{
    [self.mPersons addObject:person];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(treeDidChangeFullnameOfSomePersonStructure)
                                                 name:kMELPersonDidChangeFullnameNotification object:person];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(treeDidChangeStructure)
                                                 name:kMELPersonDidChangeFamilyNotification object:person];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(treeDidChangeStructure)
                                                 name:kMELPersonDidChangeGenderNotification object:person];
    
    [self treeDidChangeStructure];
}

- (void)removePerson:(MELPerson *)person
{
    [self.mPersons removeObject:person];
    
    [self treeDidChangeStructure];
}

- (void)treeDidChangeFullnameOfSomePersonStructure
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELTreeDidChangeFullnameOfSomePersonNotification object:self];
}

- (void)treeDidChangeStructure
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELTreeDidChangeStructureNotification object:self];
}

#pragma mark - MELTreeSetters

- (void)setTitle:(NSString *)title
{
    if (_title != title)
    {
        [_title release];
        _title = [title copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:kMELTreeDidChangeTitleOrAuthorNotification object:self];

    }
}

- (void)setAuthor:(NSString *)author
{
    if (_author != author)
    {
        [_author release];
        _author = [author copy];
        [[NSNotificationCenter defaultCenter] postNotificationName:kMELTreeDidChangeTitleOrAuthorNotification object:self];
    }
}

- (void)setNumberOfPersons:(NSInteger)numberOfPersons
{
    _numberOfPersons = numberOfPersons;
}

- (void)setPersons:(NSArray<MELPerson *> *)persons
{
    if (_persons != persons)
    {
        [_persons release];
        _persons = [[NSMutableArray alloc] initWithArray:persons];
        
        for (MELPerson *person in _persons)
        {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(treeDidChangeFullnameOfSomePersonStructure)
                                                         name:kMELPersonDidChangeFullnameNotification object:person];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(treeDidChangeStructure)
                                                         name:kMELPersonDidChangeFamilyNotification object:person];
            
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(treeDidChangeStructure)
                                                         name:kMELPersonDidChangeGenderNotification object:person];

        }
        
        [self treeDidChangeStructure];
    }
}

#pragma mark - MELTreeGetters

- (NSString *)identifier
{
    return _identifier;
}

- (NSString *)title
{
    return _title;
}

- (NSString *)author
{
    return _author;
}

- (NSInteger)numberOfPersons
{
    NSInteger result = _numberOfPersons;
    if (self.mPersons != nil)
    {
        result = self.mPersons.count;
    }
    return result;
}

- (NSMutableArray<MELPerson *> *)mPersons
{
    return _persons;
}

- (NSArray<MELPerson *> *)persons
{
    return [[self.mPersons copy] autorelease];
}

@end
