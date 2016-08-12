//
//  MELConnectionManager.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/8/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MELDataStore;
@class MELTree;

@interface MELConnectionManager : NSObject

- (instancetype)initWithDataStore:(MELDataStore *)dataStore;

- (void)addTree:(NSDictionary *)tree;
- (void)addPerson:(NSDictionary *)person;

- (void)pushTree:(NSDictionary *)tree;
- (void)pushPerson:(NSDictionary *)person;

- (void)deleteTree:(NSString *)identifier;
- (void)deletePerson:(NSString *)identifier;

- (void)setTreesList;

- (void)setPersonsOfTree:(MELTree *)tree;

@end
