//
//  MELFamilyInteractor.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/2/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MELFamilyInteractorIO.h"

@interface MELFamilyInteractor : NSObject<MELFamilyInteractorInput, MELPersonInteractorSetter>

@property (assign) id<MELFamilyInteractorOutput> output;

- (instancetype)initWithDataStore:(MELDataStore *)dataStore;

@end
