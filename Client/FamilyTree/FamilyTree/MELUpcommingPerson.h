//
//  MELUpcommingPerson.h
//  FamilyTree
//
//  Created by Александр Мелащенко on 8/2/16.
//  Copyright © 2016 Александр Мелащенко. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MELUpcommingPerson : NSObject

@property (readonly) NSString *fullname;
@property (readonly) NSString *father;
@property (readonly) NSString *mother;
@property (readonly) NSString *children;

- (instancetype)initWithFullname:(NSString *)fullname fatherName:(NSString *)father motherName:(NSString *)mother childrenNames:(NSString *)children;

@end
