//
//  MELPersonViewController.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/7/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPersonViewController.h"

@interface MELPersonViewController ()
{
@private
    id<MELPersonModuleInterface> _presenter;
    
    NSString *_name;
    NSString *_middleName;
    NSString *_surname;
    
    NSString *_selectedMother;
    NSString *_selectedFather;
    
    NSArray<NSString *> *_mothers;
    NSArray<NSString *> *_fathers;
}

@property (assign) IBOutlet NSPopUpButton *genderSelector;

@property (assign) IBOutlet NSPopUpButton *motherSelector;
@property (assign) IBOutlet NSPopUpButton *fatherSelector;

@end

@implementation MELPersonViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do view setup here.
}

- (void)dealloc
{
    [_presenter release];
    
    [_name release];
    [_middleName release];
    [_surname release];
    [_selectedFather release];
    [_selectedMother release];
    [_mothers release];
    [_fathers release];
    
    [super dealloc];
}

#pragma mark - UIEvents

- (IBAction)nameDidChange:(id)sender
{
    [self.presenter setName:[(NSTextField *)sender stringValue]];
}

- (IBAction)middleNameDidChange:(id)sender
{
    [self.presenter setMiddleName:[(NSTextField *)sender stringValue]];
}

- (IBAction)surnameDidChange:(id)sender
{
    [self.presenter setSurname:[(NSTextField *)sender stringValue]];
}

- (IBAction)genderDidChange:(id)sender
{
    [self.presenter setGender:[(NSPopUpButton *)sender indexOfSelectedItem]];
}

- (IBAction)motherDidChange:(id)sender
{
    [self.presenter setMother:[(NSPopUpButton *)sender indexOfSelectedItem]];
}

- (IBAction)fatherDidChange:(id)sender
{
    [self.presenter setFather:[(NSPopUpButton *)sender indexOfSelectedItem]];
}

#pragma mark - MELPersonInterface

- (void)selectGender:(NSInteger)gender
{
    [self.genderSelector selectItemAtIndex:gender];
}

- (void)selectFather:(NSString *)father
{
    [self.fatherSelector selectItemWithTitle:father];
}

- (void)selectMother:(NSString *)mother
{
    [self.motherSelector selectItemWithTitle:mother];
}

#pragma mark - MELPersonViewControllerWindowSetters

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
    if (_name != name)
    {
        [_name release];
        _name = [name copy];
    }
}

- (void)setMiddleName:(NSString *)middleName
{
    if (_middleName != middleName)
    {
        [_middleName release];
        _middleName = [middleName copy];
    }
    
}

- (void)setSurname:(NSString *)surname
{
    if (_surname != surname)
    {
        [_surname release];
        _surname = [surname copy];
    }
    
}

- (void)setSelectedMother:(NSString *)selectedMother
{
    if (_selectedMother != selectedMother)
    {
        [_selectedMother release];
        _selectedMother = [selectedMother copy];
    }
    
}

- (void)setSelectedFather:(NSString *)selectedFather
{
    if (_selectedFather != selectedFather)
    {
        [_selectedFather release];
        _selectedFather = [selectedFather copy];
    }
    
}

- (void)setFathers:(NSArray<NSString *> *)fathers
{
    if (_fathers != fathers)
    {
        [_fathers release];
        _fathers = [fathers retain];
    }
    
}

- (void)setMothers:(NSArray<NSString *> *)mothers
{
    if (_mothers != mothers)
    {
        [_mothers release];
        _mothers = [mothers retain];
    }
    
}

#pragma mark - MELPersonViewControllerGetters

- (id<MELPersonModuleInterface>)presenter
{
    return _presenter;
}

- (NSString *)name
{
    return _name;
}

- (NSString *)middleName
{
    return _middleName;
}

- (NSString *)surname
{
    return _surname;
}

- (NSString *)selectedMother
{
    return _selectedMother;
}

- (NSString *)selectedFather
{
    return _selectedFather;
}

- (NSArray<NSString *> *)mothers
{
    return _mothers;
}

- (NSArray<NSString *> *)fathers
{
    return _fathers;
}

@end
