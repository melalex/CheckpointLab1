//
//  MELPersonWireframe.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MELFamilyInteractorIO.h"

@class MELPersonPresenter;

@interface MELPersonWireframe : NSObject

@property (retain) MELPersonPresenter *presenter;

- (void)showPersonWithNumber:(NSInteger)index fromTreeInInteractor:(id<MELFamilyInteractorInput>)interactor;

@end
