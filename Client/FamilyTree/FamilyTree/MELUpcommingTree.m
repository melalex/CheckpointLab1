//
//  MESimpleTreeRepresentation.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELUpcommingTree.h"

@interface MELUpcommingTree()
{
@private
    NSString *_title;
    NSString *_author;
    
    NSInteger _numberOfPersons;
}

@end


@implementation MELUpcommingTree

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author numberOfPersons:(NSInteger)numberOfPersons
{
    if (self = [self init])
    {
        _title = [title copy];
        _author = [author copy];
        
        _numberOfPersons = numberOfPersons;
    }
    return self;
}

- (void)dealloc
{
    [_title release];
    [_author release];
    
    [super dealloc];
}

//#pragma mark - MELTreeSetters
//
//- (void)setTitle:(NSString *)title
//{
//    if (_title != title)
//    {
//        [_title release];
//        _title = [title copy];
//    }
//}
//
//- (void)setAuthor:(NSString *)author
//{
//    if (_author != author)
//    {
//        [_author release];
//        _author = [author copy];
//    }
//}
//
//- (void)setNumberOfPersons:(NSInteger)numberOfPersons
//{
//    _numberOfPersons = numberOfPersons;
//}

#pragma mark - MELTreeGetters

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
    return _numberOfPersons;
}

@end
