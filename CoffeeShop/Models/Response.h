//
//  Response.h
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Response : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *tracks;

+ (Response *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
