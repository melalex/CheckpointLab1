//
//  MELWireframe.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELMainMenuWireframe.h"

@interface MELMainMenuWireframe()
{
@private
    MELFamilyWireframe *_familyWireframe;
    
    MELMainMenuPresenter *_presenter;
}

@end

@implementation MELMainMenuWireframe

- (void)showFamilyWithNumber:(NSInteger)index
{
    [self.familyWireframe showFamilyWithNumber:index];
}

- (void)dealloc
{
    [_familyWireframe release];
    
    [super dealloc];
}

#pragma mark - MELMainMenuWireframeSetters

- (void)setFamilyWireframe:(MELFamilyWireframe *)familyWireframe
{
    if (_familyWireframe != familyWireframe)
    {
        [_familyWireframe release];
        _familyWireframe = [familyWireframe retain];
    }
}

- (void)setPresenter:(MELMainMenuPresenter *)presenter
{
    _presenter = presenter;
}

#pragma mark - MELMainMenuWireframeGetters

- (MELFamilyWireframe *)familyWireframe
{
    return _familyWireframe;
}

- (MELMainMenuPresenter *)presenter
{
    return _presenter;
}

@end
