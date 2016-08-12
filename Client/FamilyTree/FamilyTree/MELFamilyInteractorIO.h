//
//  MELFamilyInteractorIO.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MELPersonInteractorIO.h"
@class MELUpcommingPerson;
@class MELDataStore;

@protocol MELFamilyInteractorInput <NSObject>

@property (assign) NSString *title;
@property (assign) NSString *author;

- (void)setTree:(NSInteger)index;

- (void)addPerson;
- (void)deletePersonAtIndex:(NSInteger)index;

- (void)save;

@end

@protocol MELFamilyInteractorOutput <NSObject>

- (void)configureTitle:(NSString *)title;
- (void)configureAuthor:(NSString *)author;
- (void)configureTreeStructure:(NSArray<MELUpcommingPerson *> *)persons;
- (void)configureTreeGraph:(NSArray<NSArray *> *)treeGraph treeWidth:(NSInteger)width;

@end
