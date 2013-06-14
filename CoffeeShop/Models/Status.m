//
//  Status.m
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Status.h"


@interface Status ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Status

@synthesize message = _message;
@synthesize version = _version;
@synthesize code = _code;


+ (Status *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Status *instance = [[Status alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.message = [self objectOrNilForKey:@"message" fromDictionary:dict];
            self.version = [self objectOrNilForKey:@"version" fromDictionary:dict];
            self.code = [[dict objectForKey:@"code"] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:@"message"];
    [mutableDict setValue:self.version forKey:@"version"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:@"code"];

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

    self.message = [aDecoder decodeObjectForKey:@"message"];
    self.version = [aDecoder decodeObjectForKey:@"version"];
    self.code = [aDecoder decodeDoubleForKey:@"code"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_message forKey:@"message"];
    [aCoder encodeObject:_version forKey:@"version"];
    [aCoder encodeDouble:_code forKey:@"code"];
}


@end
