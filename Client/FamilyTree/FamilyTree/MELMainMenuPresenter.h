//
//  MELFamilyTreesPresenter.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELMainMenuInterface.h"
#import "MELMainMenuInteractorIO.h"
#import "MELMainMenuModuleInterface.h"

@class MELMainMenuInteractor;
@class MELMainMenuWireframe;

@interface MELMainMenuPresenter : NSObject<MELMainMenuInteractorOutput, MELMainMenuModuleInterface>

@property (assign) id<MELMainMenuInterface> view;
@property (retain) id<MELMainMenuInteractorInput> interactor;
@property (retain) MELMainMenuWireframe *wireframe;

@end
