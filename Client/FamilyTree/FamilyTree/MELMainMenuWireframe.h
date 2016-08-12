//
//  MELWireframe.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELMainMenuPresenter.h"
#import "MELFamilyWireframe.h"

@interface MELMainMenuWireframe : NSObject

@property (retain) MELFamilyWireframe *familyWireframe;

@property (assign) MELMainMenuPresenter *presenter;

- (void)showFamilyWithNumber:(NSInteger)index;

@end
