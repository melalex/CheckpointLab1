//
//  AppDelegate.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELMainMenuInterface.h"
#import "MELMainMenuModuleInterface.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, MELMainMenuInterface>

@property (retain) id<MELMainMenuModuleInterface> presenter;

@end

