//
//  Status.h
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Status : NSObject <NSCoding>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, assign) double code;

+ (Status *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
