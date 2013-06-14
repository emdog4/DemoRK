//
//  ChilloutTracks.h
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Status, Response;

@interface ChilloutTracks : NSObject <NSCoding>

@property (nonatomic, strong) Status *status;
@property (nonatomic, strong) Response *response;

+ (ChilloutTracks *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
