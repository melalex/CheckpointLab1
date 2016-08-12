//
//  MELFamilyPresenter.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELFamilyPresenter.h"
#import "MELFamilyInteractor.h"
#import "MELFamilyWireframe.h"
#import "MELDocumentView.h"
#import "MELPerson.h"
#import "MELPersonNodeView.h"

static CGFloat const kNodeWidth = 80.0;
static CGFloat const kNodeHeight = 50.0;
static CGFloat const kDistanceBetweenNodes = 60.0;

@interface MELFamilyPresenter()
{
@private
    id<MELFamilyInterface> _view;
    id<MELFamilyInteractorInput> _interactor;
    
    NSMutableDictionary<NSString *, NSValue *> *_personPosicionOnView;
    
    MELFamilyWireframe *_wireframe;
}

@property (readonly) NSMutableDictionary<NSString *, NSValue *> *personPosicionOnView;

@end

@implementation MELFamilyPresenter

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [_interactor release];
    [_wireframe release];
    [_personPosicionOnView release];
    
    [super dealloc];
}

- (void)configureTitle:(NSString *)title
{
    [self.view setTitle:title];
}

- (void)configureAuthor:(NSString *)author
{
    [self.view setAuthor:author];
}

- (void)configureTreeStructure:(NSArray<MELUpcommingPerson *> *)persons
{
    [self.view setPersons:persons];
}

- (void)editTitle:(NSString *)newTitle
{
    self.interactor.title = newTitle;
}

- (void)editAuthor:(NSString *)newAuthor
{
    self.interactor.author = newAuthor;
}

- (void)addPerson
{
    [self.interactor addPerson];
}

- (void)deletePersonAtIndex:(NSInteger)index
{
    [self.interactor deletePersonAtIndex:index];
}

- (void)showTreeWithNumber:(NSInteger)index
{
    [self.interactor setTree:index];
}

- (void)selectPerson:(NSInteger)index
{
    [self.wireframe showPersonWithNumber:index];
}

- (void)configureTreeGraph:(NSArray<NSArray *> *)treeGraph treeWidth:(NSInteger)width
{
    MELDocumentView *view = [[[MELDocumentView alloc] initWithFrame:NSMakeRect(0, 0, width * (kNodeWidth + kDistanceBetweenNodes * 2), treeGraph.count * (kNodeHeight + kDistanceBetweenNodes * 2))] autorelease];
    
    CGFloat x;
    CGFloat y = kDistanceBetweenNodes;
    NSAttributedString *fullname;
    NSRect frame;
    
    for (NSArray *generation in treeGraph)
    {
        x = kDistanceBetweenNodes;
        for (MELPerson *person in generation)
        {
            fullname = [[[NSAttributedString alloc] initWithString:person.fullName] autorelease];
            
            [fullname boundingRectWithSize:NSMakeSize(kNodeWidth - 10.0, kNodeHeight - 10.0) options:NSStringDrawingUsesLineFragmentOrigin];
            
            frame = NSMakeRect(x, y, kNodeWidth, kNodeHeight);
            
            x += kNodeWidth + kDistanceBetweenNodes * 2;
            
            if (person.gender == kMELGenderMale)
            {
                [view addSubview:[[[MELPersonNodeView alloc] initWithString:fullname frame:frame rectangleColor:[NSColor blueColor]] autorelease]];
            }
            else if (person.gender == kMELGenderFemale)
            {
                [view addSubview:[[[MELPersonNodeView alloc] initWithString:fullname frame:frame rectangleColor:[NSColor redColor]] autorelease]];
            }
            
            [self.personPosicionOnView setObject:[NSValue valueWithPoint:NSMakePoint((frame.origin.x + (frame.size.width / 2)), (frame.origin.y + (frame.size.height / 2)))] forKey:person.identifier];
        }

        y += kNodeHeight + kDistanceBetweenNodes * 2;
    }
    
    [view displayTreeGraphConections:self.personPosicionOnView inGraph:treeGraph];
    
    [self.view setTreeGraph:view];
}

- (void)save
{
    [self.interactor save];
}

#pragma mark - MELFamilyPresenterSetters

- (void)setView:(id<MELFamilyInterface>)view
{
    _view = view;
}

- (void)setInteractor:(id<MELFamilyInteractorInput>)interactor
{
    if (_interactor != interactor)
    {
        [_interactor release];
        _interactor = [interactor retain];
    }
}

- (void)setWireframe:(MELFamilyWireframe *)wireframe
{
    _wireframe = wireframe;
}

#pragma mark - MELFamilyPresenterGetters

- (NSMutableDictionary<NSString *,NSValue *> *)personPosicionOnView
{
    if (_personPosicionOnView == nil)
    {
        _personPosicionOnView = [[NSMutableDictionary alloc] init];
    }
    return _personPosicionOnView;
}

- (id<MELFamilyInterface>)view
{
    return _view;
}

- (id<MELFamilyInteractorInput>)interactor
{
    return _interactor;
}

- (MELFamilyWireframe *)wireframe
{
    return _wireframe;
}

@end
