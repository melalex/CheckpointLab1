//
//  MELPersonNodeView.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/8/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MELPersonNode;

@interface MELPersonNodeView : NSView

- (instancetype)initWithString:(NSAttributedString *)string frame:(NSRect)frame rectangleColor:(NSColor *)rectangleColor;

@end
