//
//  Tracks.m
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Tracks.h"
#import "Artists.h"


@interface Tracks ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Tracks

@synthesize tracksIdentifier = _tracksIdentifier;
@synthesize idStr = _idStr;
@synthesize publishedAt = _publishedAt;
@synthesize releasedAt = _releasedAt;
@synthesize artists = _artists;
@synthesize length = _length;
@synthesize largeImageUrl = _largeImageUrl;
@synthesize canonicalUrl = _canonicalUrl;
@synthesize smallImageUrl = _smallImageUrl;
@synthesize genreId = _genreId;
@synthesize playbackCount = _playbackCount;
@synthesize trackSourceUrl = _trackSourceUrl;
@synthesize name = _name;
@synthesize mediumImageUrl = _mediumImageUrl;


+ (Tracks *)modelObjectWithDictionary:(NSDictionary *)dict
{
    Tracks *instance = [[Tracks alloc] initWithDictionary:dict];
    return instance;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.tracksIdentifier = [[dict objectForKey:@"id"] doubleValue];
            self.idStr = [self objectOrNilForKey:@"id_str" fromDictionary:dict];
            self.publishedAt = [self objectOrNilForKey:@"published_at" fromDictionary:dict];
            self.releasedAt = [self objectOrNilForKey:@"released_at" fromDictionary:dict];
    NSObject *receivedArtists = [dict objectForKey:@"artists"];
    NSMutableArray *parsedArtists = [NSMutableArray array];
    if ([receivedArtists isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedArtists) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedArtists addObject:[Artists modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedArtists isKindOfClass:[NSDictionary class]]) {
       [parsedArtists addObject:[Artists modelObjectWithDictionary:(NSDictionary *)receivedArtists]];
    }

    self.artists = [NSArray arrayWithArray:parsedArtists];
            self.length = [self objectOrNilForKey:@"length" fromDictionary:dict];
            self.largeImageUrl = [self objectOrNilForKey:@"large_image_url" fromDictionary:dict];
            self.canonicalUrl = [self objectOrNilForKey:@"canonical_url" fromDictionary:dict];
            self.smallImageUrl = [self objectOrNilForKey:@"small_image_url" fromDictionary:dict];
            self.genreId = [[dict objectForKey:@"genre_id"] doubleValue];
            self.playbackCount = [[dict objectForKey:@"playback_count"] doubleValue];
            self.trackSourceUrl = [self objectOrNilForKey:@"track_source_url" fromDictionary:dict];
            self.name = [self objectOrNilForKey:@"name" fromDictionary:dict];
            self.mediumImageUrl = [self objectOrNilForKey:@"medium_image_url" fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.tracksIdentifier] forKey:@"id"];
    [mutableDict setValue:self.idStr forKey:@"id_str"];
    [mutableDict setValue:self.publishedAt forKey:@"published_at"];
    [mutableDict setValue:self.releasedAt forKey:@"released_at"];
NSMutableArray *tempArrayForArtists = [NSMutableArray array];
    for (NSObject *subArrayObject in self.artists) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForArtists addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForArtists addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForArtists] forKey:@"artists"];
    [mutableDict setValue:self.length forKey:@"length"];
    [mutableDict setValue:self.largeImageUrl forKey:@"large_image_url"];
    [mutableDict setValue:self.canonicalUrl forKey:@"canonical_url"];
    [mutableDict setValue:self.smallImageUrl forKey:@"small_image_url"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.genreId] forKey:@"genre_id"];
    [mutableDict setValue:[NSNumber numberWithDouble:self.playbackCount] forKey:@"playback_count"];
    [mutableDict setValue:self.trackSourceUrl forKey:@"track_source_url"];
    [mutableDict setValue:self.name forKey:@"name"];
    [mutableDict setValue:self.mediumImageUrl forKey:@"medium_image_url"];

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

    self.tracksIdentifier = [aDecoder decodeDoubleForKey:@"tracksIdentifier"];
    self.idStr = [aDecoder decodeObjectForKey:@"idStr"];
    self.publishedAt = [aDecoder decodeObjectForKey:@"publishedAt"];
    self.releasedAt = [aDecoder decodeObjectForKey:@"releasedAt"];
    self.artists = [aDecoder decodeObjectForKey:@"artists"];
    self.length = [aDecoder decodeObjectForKey:@"length"];
    self.largeImageUrl = [aDecoder decodeObjectForKey:@"largeImageUrl"];
    self.canonicalUrl = [aDecoder decodeObjectForKey:@"canonicalUrl"];
    self.smallImageUrl = [aDecoder decodeObjectForKey:@"smallImageUrl"];
    self.genreId = [aDecoder decodeDoubleForKey:@"genreId"];
    self.playbackCount = [aDecoder decodeDoubleForKey:@"playbackCount"];
    self.trackSourceUrl = [aDecoder decodeObjectForKey:@"trackSourceUrl"];
    self.name = [aDecoder decodeObjectForKey:@"name"];
    self.mediumImageUrl = [aDecoder decodeObjectForKey:@"mediumImageUrl"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_tracksIdentifier forKey:@"tracksIdentifier"];
    [aCoder encodeObject:_idStr forKey:@"idStr"];
    [aCoder encodeObject:_publishedAt forKey:@"publishedAt"];
    [aCoder encodeObject:_releasedAt forKey:@"releasedAt"];
    [aCoder encodeObject:_artists forKey:@"artists"];
    [aCoder encodeObject:_length forKey:@"length"];
    [aCoder encodeObject:_largeImageUrl forKey:@"largeImageUrl"];
    [aCoder encodeObject:_canonicalUrl forKey:@"canonicalUrl"];
    [aCoder encodeObject:_smallImageUrl forKey:@"smallImageUrl"];
    [aCoder encodeDouble:_genreId forKey:@"genreId"];
    [aCoder encodeDouble:_playbackCount forKey:@"playbackCount"];
    [aCoder encodeObject:_trackSourceUrl forKey:@"trackSourceUrl"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_mediumImageUrl forKey:@"mediumImageUrl"];
}


@end
