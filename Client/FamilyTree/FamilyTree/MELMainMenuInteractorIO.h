//
//  MELMainMenuInteractorIO.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MELDataStore;

@protocol MELMainMenuInteractorInput <NSObject>

- (void)loadData;

- (void)addNewTree;
- (void)deleteTreeAtIndex:(NSInteger)index;

@end

@protocol MELMainMenuInteractorOutput <NSObject>

- (void)configureTreesList:(NSArray<MELUpcommingTree *> *)treesList;

@end
