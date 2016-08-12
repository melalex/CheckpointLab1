//
//  MELMainMenuInterface.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MELUpcommingTree;

@protocol MELMainMenuInterface <NSObject>

@property (retain) NSArray<MELUpcommingTree *> *trees;

@end
