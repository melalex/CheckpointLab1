//
//  MELFamilyWindow.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELFamilyInterface.h"
#import "MELFamilyModuleInterface.h"

@interface MELFamilyWindow : NSWindowController<MELFamilyInterface, NSWindowDelegate>

@property (retain) id<MELFamilyModuleInterface> presenter;

@end
