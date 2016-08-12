//
//  MELAddChildViewController.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/7/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELPersonModuleInterface.h"

@class MELPersonViewController;

@interface MELAddChildViewController : NSViewController

@property (retain) id<MELPersonModuleInterface> presenter;

@property (retain) NSArray<NSString *> *potentialChildren;

@property (assign) MELPersonViewController *personViewController;
@property (assign) NSView *viewInPersonWindow;

@end
