//
//  MELPersonWireframe.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPersonWireframe.h"
#import "MELPersonWindow.h"
#import "MELPersonPresenter.h"

@interface MELPersonWireframe()
{
@private
    MELPersonWindow *_personWindow;
    
    MELPersonPresenter *_presenter;
}

@property (readonly) MELPersonWindow *personWindow;

@end

@implementation MELPersonWireframe

- (void)dealloc
{
    [_presenter release];
    [_personWindow release];
    
    [super dealloc];
}

- (void)showPersonWithNumber:(NSInteger)index fromTreeInInteractor:(id<MELPersonInteractorSetter>)interactor;
{
    [self.personWindow showWindow:self];
    
    [interactor setTreeAndPersonAtIndex:index toInteractor:self.presenter.interactor];
}

#pragma mark - MELFamilyWireframeSetters

- (void)setPresenter:(MELPersonPresenter *)presenter
{
    if (_presenter != presenter)
    {
        [_presenter release];
        _presenter = [presenter retain];
    }
}

#pragma mark - MELFamilyWireframeGetters

- (MELPersonWindow *)personWindow
{
    if (_personWindow == nil)
    {
        _personWindow = [[MELPersonWindow alloc] initWithWindowNibName:@"MELPersonWindow"];
        _personWindow.presenter = self.presenter;
        self.presenter.view = _personWindow;
    }
    return _personWindow;
}

- (MELPersonPresenter *)presenter
{
    return _presenter;
}


@end
