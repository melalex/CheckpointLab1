//
//  MELAddChildViewController.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/7/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELAddChildViewController.h"
#import "MELPersonViewController.h"
@interface MELAddChildViewController ()
{
@private
    id<MELPersonModuleInterface> _presenter;
    
    NSArray<NSString *> *_potentialChildren;
}

@property NSInteger selectedChild;

@end

@implementation MELAddChildViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //
}

- (void)dealloc
{
    [_presenter release];
    [_potentialChildren release];
    
    [super dealloc];
}

- (void)removeFromSuperView
{
    [self.view removeFromSuperview];
    [self.viewInPersonWindow addSubview:self.personViewController.view];
    [self.personViewController.view setFrame:self.viewInPersonWindow.bounds];
}

#pragma mark - UIEvents

- (IBAction)okButtonPressed:(id)sender
{
    [self.presenter addChild:self.selectedChild];
    
    [self removeFromSuperView];
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self removeFromSuperView];
}

- (IBAction)childSelected:(id)sender
{
    self.selectedChild = [(NSPopUpButton *)sender indexOfSelectedItem];
}

#pragma mark - MELAddChildViewControllerSetters

- (void)setPresenter:(id<MELPersonModuleInterface>)presenter
{
    if (_presenter != presenter)
    {
        [_presenter release];
        _presenter = [presenter retain];
    }
}

- (void)setPotentialChildren:(NSArray<NSString *> *)potentialChildren
{
    if (_potentialChildren != potentialChildren)
    {
        [_potentialChildren release];
        _potentialChildren = [potentialChildren retain];
    }
}


#pragma mark - MELAddChildViewControllerGetters

- (id<MELPersonModuleInterface>)presenter
{
    return _presenter;
}


- (NSArray<NSString *> *)potentialChildren
{
    return _potentialChildren;
}

@end
