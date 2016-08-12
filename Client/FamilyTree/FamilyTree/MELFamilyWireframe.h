//
//  MELFamilyWireframe.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MELFamilyPresenter;
@class MELPersonWireframe;

@interface MELFamilyWireframe : NSObject

@property (retain) MELFamilyPresenter *presenter;
@property (retain) MELPersonWireframe *personWireframe;

- (void)showFamilyWithNumber:(NSInteger)index;
- (void)showPersonWithNumber:(NSInteger)index;

@end
