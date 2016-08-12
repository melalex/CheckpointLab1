//
//  MESimpleTreeRepresentation.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MELUpcommingTree : NSObject

@property (readonly) NSString *title;
@property (readonly) NSString *author;

@property (readonly) NSInteger numberOfPersons;

- (instancetype)initWithTitle:(NSString *)title author:(NSString *)author numberOfPersons:(NSInteger)numberOfPersons;

@end
