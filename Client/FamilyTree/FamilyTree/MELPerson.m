//
//  MELPerson.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPerson.h"

@interface MELPerson()
{
@private
    NSString *_identifier;
    
    MELGender _gender;
    NSInteger _generation;
    
    NSString *_name;
    NSString *_middleName;
    NSString *_surname;
    
    NSString *_motherIdentifier;
    NSString *_fatherIdentifier;

    MELPerson *_father;
    MELPerson *_mother;
    
    NSMutableArray<MELPerson *> *_children;
}

@property (readonly) NSMutableArray<MELPerson *> *mChildren;

@end

static NSInteger sMELPersonLastGeneration = 0;

@implementation MELPerson

+ (instancetype)personWithName:(NSString *)name middleName:(NSString *)middleName surname:(NSString *)surname
{
    MELPerson *newPerson = [[MELPerson alloc] init];
    
    newPerson.name = name;
    newPerson.middleName = middleName;
    newPerson.surname = surname;
    
    return [newPerson autorelease];
}

+ (NSInteger)lastGeneration
{
    return sMELPersonLastGeneration;
}

+ (BOOL)isAncestor:(MELPerson *)potencialAncestor toPerson:(MELPerson *)person
{
    BOOL result = NO;
    
    if ([potencialAncestor isEqual:person])
    {
        return YES;
    }
    
    if (person.father && result == NO)
    {
        result = [self isAncestor:potencialAncestor toPerson:person.father];
    }
    
    if (person.mother && result == NO)
    {
        result = [self isAncestor:potencialAncestor toPerson:person.mother];
    }
    
    return result;
}

+ (BOOL)isDescendant:(MELPerson *)descendant of:(MELPerson *)ancestor
{
    if ([descendant isEqual:ancestor])
    {
        return YES;
    }
    
    BOOL result = NO;
    
    for (MELPerson *child in ancestor.children)
    {
        result = [self isDescendant:descendant of:child];
        
        if (result == YES)
        {
            return YES;
        }
    }
    
    return result;
}

+ (BOOL)isChild:(MELPerson *)person to:(MELPerson *)parent
{
    BOOL result = NO;
    for (MELPerson *child in parent.children)
    {
        if ([person isEqual:child])
        {
            result = YES;
        }
    }
    return result;
}


- (instancetype)init
{
    return [self initWithIdentifier:[[NSUUID UUID] UUIDString]];
}

- (instancetype)initWithIdentifier:(NSString *)identifier
{
    if (self = [super init])
    {
        _gender = kMELGenderUnknown;
        _identifier = [identifier copy];
        _generation = 0;
    }
    return self;
}

- (void)dealloc
{
    [_name release];
    [_middleName release];
    [_surname release];
    [_children release];
    [_identifier release];
    
    [super dealloc];
}


- (void)addChild:(MELPerson *)child
{
    [self.mChildren addObject:child];
    
    if (self.gender == kMELGenderMale)
    {
        if (child.mother)
        {
            if (child.mother.generation > self.generation)
            {
                child.generation = child.mother.generation + 1;
            }
            else
            {
                child.generation = self.generation + 1;
            }
        }
        else
        {
            child.generation = self.generation + 1;
        }
    }
    else if (self.gender == kMELGenderFemale)
    {
        if (child.father)
        {
            if (child.father.generation > self.generation)
            {
                child.generation = child.father.generation + 1;
            }
            else
            {
                child.generation = self.generation + 1;
            }
        }
        else
        {
            child.generation = self.generation + 1;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFamilyNotification object:self];
}

- (void)removeChild:(MELPerson *)child
{
    [self.mChildren removeObject:child];

    if (self.gender == kMELGenderMale)
    {
        if (child.mother)
        {
            child.generation = child.mother.generation + 1;
        }
        else
        {
            child.generation = 0;
        }
    }
    else if (self.gender == kMELGenderFemale)
    {
        if (child.father)
        {
            child.generation = child.father.generation + 1;
        }
        else
        {
            child.generation = 0;
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFamilyNotification object:self];
}

- (BOOL)isSameParents:(MELPerson *)person
{
    BOOL result = NO;
    
    if (self.father == person.father && self.mother == person.mother)
    {
        result = YES;
    }
    
    return result;
}

#pragma mark - MELPersonSetters

- (void)setGender:(MELGender)gender
{
    if (_gender == kMELGenderUnknown)
    {
        _gender = gender;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeGenderNotification object:self];
}

- (void)setName:(NSString *)name
{
    if (_name != name)
    {
        [_name release];
        _name = [name copy];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFullnameNotification object:self];
    }
}

- (void)setMiddleName:(NSString *)middleName
{
    if (_middleName != middleName)
    {
        [_middleName release];
        _middleName = [middleName copy];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFullnameNotification object:self];
    }
}

- (void)setSurname:(NSString *)surname
{
    if (_surname != surname)
    {
        [_surname release];
        _surname = [surname copy];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFullnameNotification object:self];
    }
}

- (void)setFather:(MELPerson *)father
{
    _father = father;
    self.fatherIdentifier = father.identifier;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFamilyNotification object:self];
}

- (void)setMother:(MELPerson *)mother
{
    _mother = mother;
    self.motherIdentifier = mother.identifier;

    [[NSNotificationCenter defaultCenter] postNotificationName:kMELPersonDidChangeFamilyNotification object:self];
}

- (void)setGeneration:(NSInteger)generation
{
    if (_generation != generation)
    {
        _generation = generation;
        
        
        for (MELPerson *child in self.children)
        {
            if (self.gender == kMELGenderMale)
            {
                if (child.mother)
                {
                    if (child.mother.generation > self.generation)
                    {
                        child.generation = child.mother.generation + 1;
                    }
                    else
                    {
                        child.generation = self.generation + 1;
                    }
                }
                else
                {
                    child.generation = self.generation + 1;
                }
            }
            else if (self.gender == kMELGenderFemale)
            {
                if (child.father)
                {
                    if (child.father.generation > self.generation)
                    {
                        child.generation = child.father.generation + 1;
                    }
                    else
                    {
                        child.generation = self.generation + 1;
                    }
                }
                else
                {
                    child.generation = self.generation + 1;
                }
            }
        }
        
        if (self.generation - self.father.generation > 1 && ![MELPerson isAncestor:self.father toPerson:self.mother] && ![MELPerson isAncestor:self.mother toPerson:self.father])
        {
            self.father.generation = self.generation - 1;
        }
        
        if (self.generation - self.mother.generation > 1 && ![MELPerson isAncestor:self.mother toPerson:self.father] && ![MELPerson isAncestor:self.father toPerson:self.mother])
        {
            self.mother.generation = self.generation - 1;
        }
        
        if (sMELPersonLastGeneration < _generation)
        {
            sMELPersonLastGeneration = _generation;
        }
    }
}

- (void)setMotherIdentifier:(NSString *)motherIdentifier
{
    if (_motherIdentifier != motherIdentifier)
    {
        [_motherIdentifier release];
        _motherIdentifier = [motherIdentifier copy];
    }
}

- (void)setFatherIdentifier:(NSString *)fatherIdentifier
{
    if (_fatherIdentifier != fatherIdentifier)
    {
        [_fatherIdentifier release];
        _fatherIdentifier = [fatherIdentifier copy];
    }
}

#pragma mark - MELPersonGetters

- (NSMutableArray<MELPerson *> *)mChildren
{
    if (_children == nil)
    {
        _children = [[NSMutableArray alloc] init];
    }
    return _children;
}

- (NSString *)identifier
{
    return _identifier;
}

- (MELGender)gender
{
    return _gender;
}

- (NSString *)name
{
    return _name;
}

- (NSString *)middleName
{
    return _middleName;
}

- (NSString *)surname
{
    return _surname;
}

- (NSString *)fullName
{
    return [[[NSString alloc] initWithFormat:@"%@ %@ %@", self.name, self.middleName, self.surname] autorelease];
}

- (MELPerson *)father
{
    return _father;
}

- (MELPerson *)mother
{
    return _mother;
}

- (NSArray<MELPerson *> *)children
{
    return [[self.mChildren copy] autorelease];
}

- (NSInteger)generation
{
    return _generation;
}

-(NSString *)motherIdentifier
{
    return _motherIdentifier;
}

- (NSString *)fatherIdentifier
{
    return _fatherIdentifier;
}

@end
