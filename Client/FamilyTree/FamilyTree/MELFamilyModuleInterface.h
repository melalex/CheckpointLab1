//
//  MELFamilyModuleInterface.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/3/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MELFamilyModuleInterface <NSObject>

- (void)editTitle:(NSString *)newTitle;
- (void)editAuthor:(NSString *)newAuthor;

- (void)addPerson;
- (void)deletePersonAtIndex:(NSInteger)index;

- (void)selectPerson:(NSInteger)index;

- (void)save;

@end
