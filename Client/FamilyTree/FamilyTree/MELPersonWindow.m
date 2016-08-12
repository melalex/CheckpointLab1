//
//  MELPersonWindow.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPersonWindow.h"
#import "MELAddChildViewController.h"
#import "MELPersonViewController.h"

@interface MELPersonWindow()
{
@private
    id<MELPersonModuleInterface> _presenter;
    
    NSArray<NSString *> *_children;
}

@property (assign) IBOutlet MELAddChildViewController *addChildViewController;
@property (assign) IBOutlet MELPersonViewController *personViewController;

@property (assign) IBOutlet NSView *customView;

@property (assign) IBOutlet NSTableView *childrenTable;

@end

@implementation MELPersonWindow

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    self.personViewController.presenter = self.presenter;
    self.addChildViewController.presenter = self.presenter;
    
    self.addChildViewController.viewInPersonWindow = self.customView;
    self.addChildViewController.personViewController = self.personViewController;
    
    [self.addChildViewController.view removeFromSuperview];
    [self.customView addSubview:self.personViewController.view];
    [self.personViewController.view setFrame:self.customView.bounds];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [self.presenter save];
}

- (void)dealloc
{
    [_presenter release];
    
    [super dealloc];
}

#pragma mark - UIEvents

- (IBAction)addButtonPressed:(id)sender
{
    [self.personViewController.view removeFromSuperview];
    [self.customView addSubview:self.addChildViewController.view];
    [self.addChildViewController.view setFrame:self.customView.bounds];
}

- (IBAction)deleteButtonPressed:(id)sender
{
    [self.presenter removeChild:self.childrenTable.selectedRow];
}

#pragma mark - MELPersonInterface

- (void)selectGender:(NSInteger)gender
{
    [self.personViewController selectGender:gender];
}

- (void)selectFather:(NSString *)father
{
    [self.personViewController selectFather:father];
}

- (void)selectMother:(NSString *)mother
{
    [self.personViewController selectMother:mother];
}

#pragma mark - MELPersonWindowSetters

- (void)setPresenter:(id<MELPersonModuleInterface>)presenter
{
    if (_presenter != presenter)
    {
        [_presenter release];
        _presenter = [presenter retain];
    }
}

- (void)setName:(NSString *)name
{
    self.personViewController.name = name;
}

- (void)setMiddleName:(NSString *)middleName
{
    self.personViewController.middleName = middleName;
}

- (void)setSurname:(NSString *)surname
{
    self.personViewController.surname = surname;
}

- (void)setSelectedMother:(NSString *)selectedMother
{
    self.personViewController.selectedMother = selectedMother;
}

- (void)setSelectedFather:(NSString *)selectedFather
{
    self.personViewController.selectedFather = selectedFather;
}

- (void)setFathers:(NSArray<NSString *> *)fathers
{
    self.personViewController.fathers = fathers;
}

- (void)setMothers:(NSArray<NSString *> *)mothers
{
    self.personViewController.mothers = mothers;
}

- (void)setPotentialChildren:(NSArray<NSString *> *)potentialChildren
{
    self.addChildViewController.potentialChildren = potentialChildren;
}

- (void)setChildren:(NSArray<NSString *> *)children
{
    if (_children != children)
    {
        [_children release];
        _children = [children retain];
    }
}

#pragma mark - MELPersonWindowGetters

- (id<MELPersonModuleInterface>)presenter
{
    return _presenter;
}

- (NSString *)name
{
    return self.personViewController.name;
}

- (NSString *)middleName
{
    return self.personViewController.middleName;
}

- (NSString *)surname
{
    return self.personViewController.surname;
}

- (NSString *)selectedMother
{
    return self.personViewController.selectedMother;
}

- (NSString *)selectedFather
{
    return self.personViewController.selectedFather;
}

- (NSArray<NSString *> *)mothers
{
    return self.personViewController.mothers;
}

- (NSArray<NSString *> *)fathers
{
    return self.personViewController.fathers;
}

- (NSArray<NSString *> *)potentialChildren
{
    return self.addChildViewController.potentialChildren;
}

- (NSArray<NSString *> *)children
{
    return _children;
}

@end
