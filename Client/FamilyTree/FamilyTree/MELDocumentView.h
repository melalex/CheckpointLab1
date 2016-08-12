//
//  MELDocumentView.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/8/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MELDocumentView : NSView

- (void)displayTreeGraphConections:(NSMutableDictionary<NSString *, NSValue *> *)personPosicionOnView inGraph:(NSArray<NSArray *> *)treeGraph;

@end
