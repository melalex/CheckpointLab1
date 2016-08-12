//
//  MELPersonViewController.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/7/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELPersonInterface.h"
#import "MELPersonModuleInterface.h"

@interface MELPersonViewController : NSViewController<MELPersonInterface, NSWindowDelegate>

@property (retain) id<MELPersonModuleInterface> presenter;

@end
