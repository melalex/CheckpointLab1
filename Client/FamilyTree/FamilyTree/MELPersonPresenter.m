//
//  MELPersonPresenter.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPersonPresenter.h"
#import "MELPersonWireframe.h"

@interface MELPersonPresenter()
{
@private
    id<MELPersonInterface> _view;
    id<MELPersonInteractorInput> _interactor;
    
    MELPersonWireframe *_wireframe;
}
@end

@implementation MELPersonPresenter

- (void)dealloc
{
    [_interactor release];
    
    [super dealloc];
}

#pragma mark - MELPersonModuleInterface

- (void)setName:(NSString *)name
{
    self.interactor.name = name;
}

- (void)setMiddleName:(NSString *)middleName
{
    self.interactor.middleName = middleName;
}

- (void)setSurname:(NSString *)surname
{
    self.interactor.surname = surname;
}

- (void)setGender:(NSInteger)gender
{
    [self.interactor setGender:gender];
}

- (void)setFather:(NSInteger)father
{
    [self.interactor setFather:(father - 1)];
}

- (void)setMother:(NSInteger)mother
{
    [self.interactor setMother:(mother - 1)];
}

- (void)addChild:(NSInteger)child
{
    [self.interactor addChild:(child - 1)];
}

- (void)removeChild:(NSInteger)child
{
    [self.interactor removeChild:child];
}

- (void)save
{
    [self.interactor save];
}

#pragma mark - MELPersonInteractorOutput

- (void)configureName:(NSString *)name
{
    self.view.name = name;
}

- (void)configureMiddleName:(NSString *)middleName
{
    self.view.middleName = middleName;
}

- (void)configureSurname:(NSString *)surname
{
    self.view.surname = surname;
}

- (void)configureGender:(NSInteger)gender
{
    [self.view selectGender:gender];
}

- (void)configurePotentialFathers:(NSArray<NSString *> *)fathers mothers:(NSArray<NSString *> *)mothers children:(NSArray<NSString *> *)children;
{
    NSMutableArray<NSString *> *fathersList = [NSMutableArray array];
    NSMutableArray<NSString *> *mothersList = [NSMutableArray array];
    NSMutableArray<NSString *> *childrenList = [NSMutableArray array];
    
    [fathersList addObject:@""];
    [fathersList addObjectsFromArray:fathers];
    
    [mothersList addObject:@""];
    [mothersList addObjectsFromArray:mothers];
    
    [childrenList addObject:@""];
    [childrenList addObjectsFromArray:children];
    
    self.view.fathers = fathersList;
    self.view.mothers = mothersList;
    self.view.potentialChildren = childrenList;
}

- (void)configureFather:(NSString *)father andMother:(NSString *)mother;
{
    [self.view selectFather:father];
    [self.view selectMother:mother];
}

- (void)configureChildren:(NSArray<NSString *> *)children
{
    self.view.children = children;
}

#pragma mark - MELPersonPresenterSetters

- (void)setView:(id<MELPersonInterface>)view
{
    _view = view;
}

- (void)setInteractor:(id<MELPersonInteractorInput>)interactor
{
    if (_interactor != interactor)
    {
        [_interactor release];
        _interactor = [interactor retain];
    }
}

- (void)setWireframe:(MELPersonWireframe *)wireframe
{
    _wireframe = wireframe;
}

#pragma mark - MELPersonPresenterGetters

- (id<MELPersonInterface>)view
{
    return _view;
}

- (id<MELPersonInteractorInput>)interactor
{
    return _interactor;
}

- (MELPersonWireframe *)wireframe
{
    return _wireframe;
}


@end
