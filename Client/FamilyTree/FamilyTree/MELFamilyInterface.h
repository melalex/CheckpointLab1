//
//  MELFamilyInterface.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/1/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MELUpcommingPerson;

@protocol MELFamilyInterface <NSObject>

@property (copy) NSString *title;
@property (copy) NSString *author;

@property (retain) NSArray<MELUpcommingPerson *> *persons;

- (void)setTreeGraph:(NSView *)view;

@end
