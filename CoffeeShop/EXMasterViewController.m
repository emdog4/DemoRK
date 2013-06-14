//
//  EXMasterViewController.m
//  CoffeeShop
//
//  Created by MacUser1 on 1/14/13.
//  Copyright (c) 2013 Master of Code. All rights reserved.
//

#import "EXMasterViewController.h"
#import <RestKit/RestKit.h>
#import "Venue.h"
#import "EXVenueCell.h"
#import "DataModels.h"

#define kAPIKEY "1d24ce9c5ca0d6d17dbc498e3"

@interface EXMasterViewController ()
{ }
@end

@implementation EXMasterViewController

@synthesize data;

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL *baseURL = [NSURL URLWithString:@"http://console.fm"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    
    RKObjectMapping *tracksMapping = [RKObjectMapping mappingForClass:[Tracks class]];
    [tracksMapping addAttributeMappingsFromArray:@[@"tracksIdentifier", @"idStr", @"publishedAt", @"releasedAt", @"artists", @"length", @"largeImageUrl", @"canonicalUrl", @"smallImageUrl", @"genreId", @"playbackCount", @"trackSourceUrl", @"name", @"mediumImageUrl"]];
    
    RKObjectMapping *artistsMapping = [RKObjectMapping mappingForClass:[Artists class]];
    [artistsMapping addAttributeMappingsFromArray:@[@"artistsIdentifier", @"name", @"slug"]];
    
    RKRelationshipMapping *artistsRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"artistsIdentifier" toKeyPath:@"artists" withMapping:artistsMapping];
    [artistsMapping addPropertyMapping:artistsRelation];
    
    
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:tracksMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:@"response.tracks"
                                                                                       statusCodes:nil];
    
    [objectManager addResponseDescriptor:responseDescriptor];
    
    [self sendRequest];
}

- (void) sendRequest {
    
    NSString *apiKey = [NSString stringWithUTF8String:kAPIKEY];
    
    NSDictionary *queryParams;
    queryParams = [NSDictionary dictionaryWithObjectsAndKeys:apiKey, @"api_key", nil];
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager];
        
    [objectManager getObjectsAtPath:@"/api/v2/genres/2/tracks" parameters:queryParams
     
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                NSLog(@"objects[%d]", [[mappingResult array] count]);
                                self.data = [mappingResult array];
                                [self.tableView reloadData];
                            }
     
                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                NSLog(@"Error: %@", [error localizedDescription]);
                            }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EXVenueCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackCell"];
    Tracks *track = [data objectAtIndex:indexPath.row];
    cell.textLabel.text= [track.name length] > 25 ? [track.name substringToIndex:25] : track.name;
    
    if([track.artists count] != 0) {
        
        __block NSString *string;
        
        [track.artists enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if(string) {
                string = [NSString stringWithFormat:@"%@, %@", string, [obj valueForKey:@"name"]];
            } else {
                string = [obj valueForKey:@"name"];
            }
            
        }];
        
        cell.detailTextLabel.text = string;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
