//
//  MELFamilyTreesPresenter.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELMainMenuPresenter.h"
#import "MELMainMenuInteractor.h"
#import "MELMainMenuWireframe.h"

@interface MELMainMenuPresenter()
{
@private
    id<MELMainMenuInterface> _view;
    id<MELMainMenuInteractorInput> _interactor;
    
    MELMainMenuWireframe *_wireframe;
}

@end

@implementation MELMainMenuPresenter

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_interactor release];
    [_wireframe release];
    
    [super dealloc];
}


- (void)configureTreesList:(NSArray<MELUpcommingTree *> *)treesList
{
    [self.view setTrees:treesList];
}

- (void)addTree
{
    [self.interactor addNewTree];
}

- (void)deleteTreeAtIndex:(NSInteger)index
{
    [self.interactor deleteTreeAtIndex:index];
}

- (void)selectTree:(NSInteger)index
{
    [self.wireframe showFamilyWithNumber:index];
}

- (void)loadData
{
    [self.interactor loadData];
}

#pragma mark - MELMainMenuPresenterSetters

- (void)setView:(id<MELMainMenuInterface>)view
{
    _view = view;
}

- (void)setInteractor:(id<MELMainMenuInteractorInput>)interactor
{
    if (_interactor != interactor)
    {
        [_interactor release];
        _interactor = [interactor retain];
    }
}

- (void)setWireframe:(MELMainMenuWireframe *)wireframe
{
    if (_wireframe != wireframe)
    {
        [_wireframe release];
        _wireframe = [wireframe retain];
    }
}

#pragma mark - MELMainMenuPresenterGetters

- (id<MELMainMenuInterface>)view
{
    return _view;
}

- (id<MELMainMenuInteractorInput>)interactor
{
    return _interactor;
}

- (MELMainMenuWireframe *)wireframe
{
    return _wireframe;
}

@end
