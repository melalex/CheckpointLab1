//
//  MELPersonNodeView.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/8/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELPersonNodeView.h"

static const CGFloat kVBRoundedRectRadius = 10.0;

static const CGFloat kMELdX = 0.5;
static const CGFloat kMELdY = 0.5;

@interface MELPersonNodeView()

@property (copy) NSAttributedString *string;
@property (retain) NSColor *rectangleColor;

@end


@implementation MELPersonNodeView

- (instancetype)initWithString:(NSAttributedString *)string frame:(NSRect)frame rectangleColor:(NSColor *)rectangleColor
{
    if (self = [super initWithFrame:frame])
    {
        _string = [string copy];
        _rectangleColor = [rectangleColor retain];
    }
    return self;
}

- (void)dealloc
{
    [_string release];
    [_rectangleColor release];
    
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];

    [[NSColor clearColor] set];
    
    NSFrameRectWithWidth(self.bounds, 1.0);
    
    NSBezierPath* rectanglePath = [NSBezierPath bezierPath];
    [rectanglePath appendBezierPathWithRoundedRect:NSInsetRect(dirtyRect, kMELdX, kMELdY) xRadius:kVBRoundedRectRadius yRadius:kVBRoundedRectRadius];
    
    [self.rectangleColor set];
    
    [rectanglePath fill];
    [rectanglePath stroke];
    
    NSRect stringRect = NSMakeRect(dirtyRect.origin.x + 5.0,
                                   dirtyRect.origin.y + 5.0,
                                   dirtyRect.size.width - 10.0,
                                   dirtyRect.size.height - 10.0);
    
    [self.string drawInRect:stringRect];
}

@end
