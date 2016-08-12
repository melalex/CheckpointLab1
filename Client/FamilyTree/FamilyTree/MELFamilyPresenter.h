//
//  MELFamilyPresenter.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELFamilyInterface.h"
#import "MELFamilyModuleInterface.h"
#import "MELFamilyInteractorIO.h"

@class MELFamilyWireframe;

@interface MELFamilyPresenter : NSObject<MELFamilyInteractorOutput, MELFamilyModuleInterface>

@property (assign) id<MELFamilyInterface> view;
@property (retain) id<MELFamilyInteractorInput> interactor;
@property (assign) MELFamilyWireframe *wireframe;

- (void)showTreeWithNumber:(NSInteger)index;

@end
