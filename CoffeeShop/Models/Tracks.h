//
//  Tracks.h
//
//  Created by   on 4/11/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Tracks : NSObject <NSCoding>

@property (nonatomic, assign) double tracksIdentifier;
@property (nonatomic, strong) NSString *idStr;
@property (nonatomic, strong) NSString *publishedAt;
@property (nonatomic, strong) NSString *releasedAt;
@property (nonatomic, strong) NSArray *artists;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *largeImageUrl;
@property (nonatomic, strong) NSString *canonicalUrl;
@property (nonatomic, strong) NSString *smallImageUrl;
@property (nonatomic, assign) double genreId;
@property (nonatomic, assign) double playbackCount;
@property (nonatomic, strong) NSString *trackSourceUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *mediumImageUrl;

+ (Tracks *)modelObjectWithDictionary:(NSDictionary *)dict;
- (id)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
