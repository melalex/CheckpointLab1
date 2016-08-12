//
//  MELFamilyWindow.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELFamilyWindow.h"

@interface MELFamilyWindow()
{
@private
    NSString *_title;
    NSString *_author;
    
    NSArray<MELUpcommingPerson *> *_persons;
}

@property (assign) IBOutlet NSTableView *personsTableView;
@property (assign) IBOutlet NSScrollView *familyTreeScrollView;

@end

@implementation MELFamilyWindow

- (void)windowDidLoad
{
    [self.personsTableView setTarget:self];
    [self.personsTableView setDoubleAction:@selector(doubleClickHandler)];
    
    self.familyTreeScrollView.backgroundColor = [NSColor whiteColor];

    [super windowDidLoad];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [self.presenter save];
}

- (void)dealloc
{
    [_presenter release];
    
    [_title release];
    [_author release];
    [_persons release];
    
    [super dealloc];
}

- (IBAction)titleDidChangeHandler:(id)sender
{
    [self.presenter editTitle:[(NSTextField *)sender stringValue]];
}

- (IBAction)authorDidChangeHandler:(id)sender
{
    [self.presenter editAuthor:[(NSTextField *)sender stringValue]];
}

- (IBAction)addButtonPressed:(id)sender
{
    [self.presenter addPerson];
}

- (IBAction)deleteButtonPressed:(id)sender
{
    NSInteger selectedRow = self.personsTableView.selectedRow;
    
    if (selectedRow >= 0)
    {
        [self.presenter deletePersonAtIndex:selectedRow];
    }
}

- (void)doubleClickHandler
{
    NSInteger selectedRow = self.personsTableView.selectedRow;
    
    if (selectedRow >= 0)
    {
        [self.presenter selectPerson:selectedRow];
    }
}

- (void)setTreeGraph:(NSView *)view
{
    [self.familyTreeScrollView setDocumentView:view];
}

#pragma mark - MELFamilyWindowSetters

- (void)setTitle:(NSString *)title
{
    if (_title != title)
    {
        [_title release];
        _title = [title copy];
    }
}

- (void)setAuthor:(NSString *)author
{
    if (_author != author)
    {
        [_author release];
        _author = [author copy];
    }
}

- (void)setPersons:(NSArray<MELUpcommingPerson *> *)persons
{
    if (_persons != persons)
    {
        [_persons release];
        _persons = [persons retain];
    }
}

#pragma mark - MELFamilyWindowGetters

- (NSString *)title
{
    return _title;
}

- (NSString *)author
{
    return _author;
}

- (NSArray<MELUpcommingPerson *> *)persons
{
    return _persons;
}

@end
