//
//  MELPersonPresenter.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELPersonInterface.h"
#import "MELPersonModuleInterface.h"
#import "MELPersonInteractorIO.h"

@class MELPersonWireframe;

@interface MELPersonPresenter : NSObject<MELPersonModuleInterface, MELPersonInteractorOutput>

@property (retain) id<MELPersonInteractorInput, MELPersonInteractorSetup> interactor;
@property (assign) id<MELPersonInterface> view;
@property (assign) MELPersonWireframe *wireframe;

@end
