//
//  MELDocumentView.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/8/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELDocumentView.h"
#import "MELPerson.h"

@interface MELDocumentView()

@property (assign) NSMutableDictionary<NSString *, NSValue *> *personPosicionOnView;
@property (assign) NSArray<NSArray *> *treeGraph;
@end

@implementation MELDocumentView

- (void)displayTreeGraphConections:(NSMutableDictionary<NSString *, NSValue *> *)personPosicionOnView inGraph:(NSArray<NSArray *> *)treeGraph;
{
    self.personPosicionOnView = personPosicionOnView;
    self.treeGraph = treeGraph;
    
    self.needsDisplay = YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    NSBezierPath * path = [NSBezierPath bezierPath];
    
    NSPoint firstPoint, secondPoint;
    
    NSArray<MELPerson *> *generation = nil;
    for (NSInteger i = self.treeGraph.count - 1; i >= 0; i--)
    {
        generation = [self.treeGraph objectAtIndex:i];
        for (MELPerson *person in generation)
        {
            if (person.father)
            {
                firstPoint = [self.personPosicionOnView[person.identifier] pointValue];
                secondPoint = [self.personPosicionOnView[person.father.identifier] pointValue];
                
                [path  moveToPoint:firstPoint];
                [path lineToPoint:secondPoint];
            }
            
            if (person.mother)
            {
                firstPoint = [self.personPosicionOnView[person.identifier] pointValue];
                secondPoint = [self.personPosicionOnView[person.mother.identifier] pointValue];
                
                [path  moveToPoint:firstPoint];
                [path lineToPoint:secondPoint];
            }
        }
    }

    
    [[NSColor blackColor] set];
    [path stroke];
}

- (BOOL)isFlipped
{
    return YES;
}

@end
