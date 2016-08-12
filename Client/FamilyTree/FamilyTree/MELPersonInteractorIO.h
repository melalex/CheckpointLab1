//
//  MELPersonInteractorIO.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/4/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MELPerson;
@class MELTree;

@protocol MELPersonInteractorInput <NSObject>

@property (assign) NSString *name;
@property (assign) NSString *middleName;
@property (assign) NSString *surname;

- (void)setGender:(NSInteger)gender;

- (void)setFather:(NSInteger)father;
- (void)setMother:(NSInteger)mother;

- (void)addChild:(NSInteger)child;
- (void)removeChild:(NSInteger)child;

- (void)save;

@end

@protocol MELPersonInteractorOutput <NSObject>

- (void)configureName:(NSString *)name;
- (void)configureMiddleName:(NSString *)middleName;
- (void)configureSurname:(NSString *)surname;

- (void)configureGender:(NSInteger)gender;

- (void)configurePotentialFathers:(NSArray<NSString *> *)fathers mothers:(NSArray<NSString *> *)mothers children:(NSArray<NSString *> *)children;

- (void)configureFather:(NSString *)father andMother:(NSString *)mother;

- (void)configureChildren:(NSArray<NSString *> *)children;

@end

@protocol MELPersonInteractorSetup <NSObject>

- (void)setTree:(MELTree *)tree person:(MELPerson *)person;

@end

@protocol MELPersonInteractorSetter <NSObject>

- (void)setTreeAndPersonAtIndex:(NSInteger)index toInteractor:(id<MELPersonInteractorSetup>)interactor;

@end
