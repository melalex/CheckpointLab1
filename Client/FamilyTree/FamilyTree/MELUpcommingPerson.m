//
//  MELUpcommingPerson.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/2/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELUpcommingPerson.h"

@interface MELUpcommingPerson()
{
@private
    NSString *_fullname;
    NSString *_father;
    NSString *_mother;
    NSString *_children;
}
@end

@implementation MELUpcommingPerson

- (instancetype)initWithFullname:(NSString *)fullname fatherName:(NSString *)father motherName:(NSString *)mother childrenNames:(NSString *)children;
{
    if (self = [self init])
    {
        _fullname = [fullname copy];
        _father = [father copy];
        _mother = [mother copy];
        _children = [children copy];
    }
    return self;
}

- (void)dealloc
{
    [_fullname release];
    [_father release];
    [_mother release];
    [_children release];
    
    [super dealloc];
}

#pragma mark - MELUpcommingPersonGetters

- (NSString *)fullname
{
    return _fullname;
}

- (NSString *)father
{
    return _father;
}

- (NSString *)mother
{
    return _mother;
}

- (NSString *)children
{
    return _children;
}

@end
