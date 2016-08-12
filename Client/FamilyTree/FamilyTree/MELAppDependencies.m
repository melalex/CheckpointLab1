//
//  MELAppDependencies.m
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/2/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import "MELAppDependencies.h"

#import "MELDataStore.h"

#import "MELMainMenuPresenter.h"
#import "MELMainMenuInteractor.h"
#import "MELMainMenuWireframe.h"

#import "MELFamilyWindow.h"
#import "MELFamilyPresenter.h"
#import "MELFamilyInteractor.h"
#import "MELFamilyWireframe.h"

#import "MELPersonWindow.h"
#import "MELPersonPresenter.h"
#import "MELPersonInteractor.h"
#import "MELPersonWireframe.h"

@implementation MELAppDependencies

- (void)configureDependencies:(AppDelegate *)mainWindow;
{
    MELDataStore *dataStore = [[[MELDataStore alloc] init] autorelease];

    //PersonWindow
    
    MELPersonPresenter *personPresenter = [[[MELPersonPresenter alloc] init] autorelease];
    MELPersonInteractor *personInteractor = [[[MELPersonInteractor alloc] initWithDataStore:dataStore] autorelease];
    MELPersonWireframe *personWireframe = [[[MELPersonWireframe alloc] init] autorelease];

    personPresenter.interactor = personInteractor;
    personPresenter.wireframe = personWireframe;
    personWireframe.presenter = personPresenter;
    personInteractor.output = personPresenter;
    
    //FamilyWindow
    
    MELFamilyPresenter *familyPresenter = [[[MELFamilyPresenter alloc] init] autorelease];
    MELFamilyInteractor *familyInteractor = [[[MELFamilyInteractor alloc] initWithDataStore:dataStore] autorelease];
    MELFamilyWireframe *familyWireframe = [[[MELFamilyWireframe alloc] init] autorelease];
    
    familyPresenter.interactor = familyInteractor;
    familyPresenter.wireframe = familyWireframe;
    familyWireframe.presenter = familyPresenter;
    familyWireframe.personWireframe = personWireframe;
    familyInteractor.output = familyPresenter;
    
    //MainWindow
    
    MELMainMenuPresenter *mainMenuPresenter = [[[MELMainMenuPresenter alloc] init] autorelease];
    MELMainMenuInteractor *mainMenuInteractor = [[[MELMainMenuInteractor alloc] initWithDataStore:dataStore] autorelease];
    MELMainMenuWireframe *mainMenuWireframe = [[[MELMainMenuWireframe alloc] init] autorelease];
    
    mainWindow.presenter = mainMenuPresenter;
    mainMenuPresenter.view = mainWindow;
    mainMenuPresenter.interactor = mainMenuInteractor;
    mainMenuPresenter.wireframe = mainMenuWireframe;
    mainMenuWireframe.presenter = mainMenuPresenter;
    mainMenuWireframe.familyWireframe = familyWireframe;
    mainMenuInteractor.output = mainMenuPresenter;
}

@end
