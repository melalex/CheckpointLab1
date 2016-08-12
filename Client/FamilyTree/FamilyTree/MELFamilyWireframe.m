//
//  MELFamilyWireframe.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELFamilyWireframe.h"
#import "MELFamilyWindow.h"
#import "MELFamilyPresenter.h"
#import "MELPersonWireframe.h"

@interface MELFamilyWireframe()
{
@private
    MELFamilyWindow *_familyWindow;
    
    MELFamilyPresenter *_presenter;
    MELPersonWireframe *_personWireframe;
}

@property (readonly) MELFamilyWindow *familyWindow;

@end

@implementation MELFamilyWireframe

- (void)dealloc
{
    [_familyWindow release];
    [_presenter release];
    [_personWireframe release];
    
    [super dealloc];
}

- (void)showFamilyWithNumber:(NSInteger)index
{
    [self.familyWindow showWindow:self];
    
    [self.presenter showTreeWithNumber:index];
}

- (void)showPersonWithNumber:(NSInteger)index
{
    [self.personWireframe showPersonWithNumber:index fromTreeInInteractor:self.presenter.interactor];
}

#pragma mark - MELFamilyWireframeSetters

- (void)setPresenter:(MELFamilyPresenter *)presenter
{
    if (_presenter != presenter)
    {
        [_presenter release];
        _presenter = [presenter retain];
    }
}

-(void)setPersonWireframe:(MELPersonWireframe *)personWireframe
{
    if (_personWireframe != personWireframe)
    {
        [_personWireframe release];
        _personWireframe = [personWireframe retain];
    }
}

#pragma mark - MELFamilyWireframeGetters

- (MELFamilyWindow *)familyWindow
{
    if (_familyWindow == nil)
    {
        _familyWindow = [[MELFamilyWindow alloc] initWithWindowNibName:@"MELFamilyWindow"];
        _familyWindow.presenter = self.presenter;
        self.presenter.view = _familyWindow;
    }
    return _familyWindow;
}

-(MELPersonWireframe *)personWireframe
{
    return _personWireframe;
}

- (MELFamilyPresenter *)presenter
{
    return _presenter;
}

@end
