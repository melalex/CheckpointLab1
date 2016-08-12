//
//  AppDelegate.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "AppDelegate.h"
#import "MELAppDependencies.h"

@interface AppDelegate ()
{
@private
    NSArray<MELUpcommingTree *> *_trees;
    
    id<MELMainMenuModuleInterface> _presenter;
}

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *treesTableView;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    MELAppDependencies *dependencies = [[MELAppDependencies alloc] init];
    [dependencies configureDependencies:self];
    
    [self.treesTableView setTarget:self];
    [self.treesTableView setDoubleAction:@selector(doubleClickHandler)];
    
    [dependencies release];
    
    [self.presenter loadData];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)dealloc
{
    [_trees release];
    [_presenter release];
    
    [super dealloc];
}

- (IBAction)addButtonPressed:(id)sender
{
    [self.presenter addTree];
}

- (IBAction)deleteButtonPressed:(id)sender
{
    NSInteger selectedRow = self.treesTableView.selectedRow;
    
    if (selectedRow >= 0)
    {
        [self.presenter deleteTreeAtIndex:selectedRow];
    }
}

- (void)doubleClickHandler
{
    NSInteger selectedRow = self.treesTableView.selectedRow;
    
    if (selectedRow >= 0)
    {
        [self.presenter selectTree:selectedRow];
    }
}
#pragma mark - AppDelegateSetters

- (void)setTrees:(NSArray<MELUpcommingTree *> *)trees
{
    if (_trees != trees)
    {
        [_trees release];
        _trees = [trees retain];
    }
}

- (void)setPresenter:(id<MELMainMenuModuleInterface>)presenter
{
    if (_presenter != presenter)
    {
        [_presenter release];
        _presenter = [presenter retain];
    }
}

#pragma mark - AppDelegateGetters

- (id<MELMainMenuModuleInterface>)presenter
{
    return _presenter;
}

- (NSArray<MELUpcommingTree *> *)trees
{
    return _trees;
}


@end
