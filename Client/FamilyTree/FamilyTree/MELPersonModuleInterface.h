//
//  MELPersonModuleInterface.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/4/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MELPersonWireframe.h"

@protocol MELPersonModuleInterface <NSObject>

- (void)setName:(NSString *)name;
- (void)setMiddleName:(NSString *)middleName;
- (void)setSurname:(NSString *)surname;

- (void)setGender:(NSInteger)gender;

- (void)setFather:(NSInteger)father;
- (void)setMother:(NSInteger)mother;

- (void)addChild:(NSInteger)child;
- (void)removeChild:(NSInteger)child;

- (void)save;

@end
