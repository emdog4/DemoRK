//
//  Artists.h
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Artists : NSObject <NSCoding>

@property (nonatomic, assign) double artistsIdentifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *slug;

+ (Artists *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
