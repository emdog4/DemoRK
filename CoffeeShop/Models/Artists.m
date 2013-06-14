//
//  Artists.m
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Artists.h"


@interface Artists ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Artists

@synthesize artistsIdentifier = _artistsIdentifier;
@synthesize name = _name;
@synthesize slug = _slug;


+ (Artists *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Artists *instance = [[Artists alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.artistsIdentifier = [[dict objectForKey:@"id"] doubleValue];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.slug = [self objectOrNilForKey:@"slug" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.artistsIdentifier] forKey:@"id"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.slug forKey:@"slug"];

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

    self.artistsIdentifier = [aDecoder decodeDoubleForKey:@"artistsIdentifier"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.slug = [aDecoder decodeObjectForKey:@"slug"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_artistsIdentifier forKey:@"artistsIdentifier"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_slug forKey:@"slug"];
}


@end
