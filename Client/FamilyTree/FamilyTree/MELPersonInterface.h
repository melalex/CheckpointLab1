//
//  MELPersonInterface.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MELPersonInterface <NSObject>

@required

@property (copy) NSString *name;
@property (copy) NSString *middleName;
@property (copy) NSString *surname;

@property (copy) NSString *selectedMother;
@property (copy) NSString *selectedFather;

@property (retain) NSArray<NSString *> *mothers;
@property (retain) NSArray<NSString *> *fathers;

- (void)selectGender:(NSInteger)gender;

- (void)selectMother:(NSString *)mother;
- (void)selectFather:(NSString *)father;

@optional

@property (retain) NSArray<NSString *> *children;
@property (retain) NSArray<NSString *> *potentialChildren;

@end
