//
//  Response.m
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Response.h"
#import "Tracks.h"


@interface Response ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Response

@synthesize tracks = _tracks;


+ (Response *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Response *instance = [[Response alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
    NSObject *receivedTracks = [dict objectForKey:@"tracks"];
    NSMutableArray *parsedTracks = [NSMutableArray array];
    if ([receivedTracks isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedTracks) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedTracks addObject:[Tracks modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedTracks isKindOfClass:[NSDictionary class]]) {
       [parsedTracks addObject:[Tracks modelObjectWithDictionary:(NSDictionary *)receivedTracks]];
    }

    self.tracks = [NSArray arrayWithArray:parsedTracks];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
NSMutableArray *tempArrayForTracks = [NSMutableArray array];
    for (NSObject *subArrayObject in self.tracks) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTracks addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTracks addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTracks] forKey:@"tracks"];

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

    self.tracks = [aDecoder decodeObjectForKey:@"tracks"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_tracks forKey:@"tracks"];
}


@end
