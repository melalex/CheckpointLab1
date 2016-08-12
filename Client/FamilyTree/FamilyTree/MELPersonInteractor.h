//
//  MELPersonInteractor.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MELPersonInteractorIO.h"

@class MELDataStore;

@interface MELPersonInteractor : NSObject<MELPersonInteractorInput, MELPersonInteractorSetup>

@property (assign) id<MELPersonInteractorOutput> output;

- (instancetype)initWithDataStore:(MELDataStore *)dataStore;

@end
