//
//  ChilloutTracks.m
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ChilloutTracks.h"
#import "Status.h"
#import "Response.h"


@interface ChilloutTracks ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ChilloutTracks

@synthesize status = _status;
@synthesize response = _response;


+ (ChilloutTracks *)modelObjectWithDictionary:(NSDictionary *)dict
{
    ChilloutTracks *instance = [[ChilloutTracks alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.status = [Status modelObjectWithDictionary:[dict objectForKey:@"status"]];
            self.response = [Response modelObjectWithDictionary:[dict objectForKey:@"response"]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.status dictionaryRepresentation] forKey:@"status"];
    [mutableDict setValue:[self.response dictionaryRepresentation] forKey:@"response"];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.status = [aDecoder decodeObjectForKey:@"status"];
    self.response = [aDecoder decodeObjectForKey:@"response"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:@"status"];
    [aCoder encodeObject:_response forKey:@"response"];
}


@end
