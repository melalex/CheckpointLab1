//
//  MELMainMenuModuleInterface.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MELMainMenuModuleInterface <NSObject>

- (void)loadData;

- (void)addTree;
- (void)deleteTreeAtIndex:(NSInteger)index;

- (void)selectTree:(NSInteger)index;

@end
