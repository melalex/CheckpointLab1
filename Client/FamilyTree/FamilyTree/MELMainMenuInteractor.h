//
//  MELInteractor.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MELMainMenuInteractorIO.h"

@class MELUpcommingTree;
@class MELDataStore;

//static NSString *const kMELMainMenuInteractorDidChangeNotification = @"kMELMainMenuInteractorDidChangeNotification";

@interface MELMainMenuInteractor : NSObject<MELMainMenuInteractorInput>

@property (assign) id<MELMainMenuInteractorOutput> output;

- (instancetype)initWithDataStore:(MELDataStore *)dataStore;

@end
