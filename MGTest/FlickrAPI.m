//
//  FlickrAPI.m
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import "FlickrAPI.h"
#import "JSONKit.h"
#import "WebServiceClient.h"

#define flickrAPIKey @"739e7b161b5d9b4b78bce6da0ca5800a"

#define flickrBaseURL @"http://api.flickr.com/services/rest/?format=json&"

#define flickrParamMethod @"method"
#define flickrParamAppKey @"api_key"
#define flickrParamUsername @"username"
#define flickrParamUserid @"user_id"
#define flickrParamPhotoSetId @"photoset_id"
#define flickrParamExtras @"extras"

#define flickrMethodFindByUsername @"flickr.people.findByUsername"
#define flickrMethodGetPhotoSetList @"flickr.photosets.getList"
#define flickrMethodGetPhotosWithPhotoSetId @"flickr.photosets.getPhotos"


@implementation FlickrAPI

// Returns the Flickr NSID for the given user name.
- (NSString *)userIdForUserName:(NSString *)username
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:flickrMethodFindByUsername, flickrParamMethod, flickrAPIKey, flickrParamAppKey, username, flickrParamUsername, nil];
    NSDictionary *json = [self flickrJSONSWithParameters:parameters];
    NSDictionary *userDict = [json objectForKey:@"user"];
    NSString *nsid = [userDict objectForKey:@"nsid"];
    return nsid;
}

//returns the photoSets from a given user name
// userId is the Flickr NSID of the user.
- (NSArray *)photoSetListWithUserId:(NSString *)userId
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:flickrMethodGetPhotoSetList, flickrParamMethod, flickrAPIKey, flickrParamAppKey, userId, flickrParamUserid, nil];
    NSDictionary *json = [self flickrJSONSWithParameters:parameters];
    NSDictionary *photosets = [json objectForKey:@"photosets"];
    NSArray *photoSet = [photosets objectForKey:@"photoset"];
    return photoSet;
}

//returns a photoSet from an given set name
- (NSString *)photoSetIdWithTitle:(NSString *)title photoSets:(NSArray *)photoSets
{
    NSString *result;
    for (NSDictionary *photoSet in photoSets) {
        NSDictionary *titleDict = [photoSet objectForKey:@"title"];
        NSString *titleContent = [titleDict objectForKey:@"_content"];
        if ([titleContent isEqualToString:title]) {
            result = [photoSet objectForKey:@"id"];
            break;
        }
    }
    
    return result;
}

//returns the photos from a set, given the set name
- (NSArray *)photosWithPhotoSetId:(NSString *)photoSetId
{
    NSDictionary *parameters = [NSDictionary dictionaryWithObjectsAndKeys:flickrMethodGetPhotosWithPhotoSetId, flickrParamMethod, flickrAPIKey, flickrParamAppKey, photoSetId, flickrParamPhotoSetId, @"url_t, url_s, url_m", flickrParamExtras, nil];
    NSDictionary *json = [self flickrJSONSWithParameters:parameters];
    NSDictionary *photoset = [json objectForKey:@"photoset"];
    NSArray *photos = [photoset objectForKey:@"photo"];
    return photos;
}


//builds the url used in the request to flickr server
- (NSURL *)buildFlickrURLWithParameters:(NSDictionary *)parameters
{
    NSMutableString *URLString = [[NSMutableString alloc] initWithString:flickrBaseURL];
    for (id key in parameters) {
        NSString *value = [parameters objectForKey:key];
        [URLString appendFormat:@"%@=%@&", key, [value stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    NSURL *URL = [NSURL URLWithString:URLString];
    return URL;
}

// Flickr returns a JavaScript function containing the JSON data.
// We need to strip out the JavaScript part before we can parse the JSON data. Ex: jsonFlickrApi(JSON-DATA-HERE)
- (NSString *)stringByRemovingFlickrJavaScript:(NSData *)data
{

    NSMutableString *string = [[self stringWithData:data] mutableCopy];
    NSRange range = NSMakeRange(0, [@"jsonFlickrApi(" length]);
    [string deleteCharactersInRange:range];
    range = NSMakeRange([string length] - 1, 1);
    [string deleteCharactersInRange:range];
    
    return [string autorelease];
}

- (NSString *)stringWithData:(NSData *)data
{
    NSString *result = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    return [result autorelease];
}

//returns the json data from the request made to the server with the given parameters
- (id)flickrJSONSWithParameters:(NSDictionary *)parameters
{
    NSURL *URL = [self buildFlickrURLWithParameters:parameters];
    NSData *data = [WebServiceClient fetchResponseWithURL:URL];
    NSString *string = [self stringByRemovingFlickrJavaScript:data];
    
    JSONDecoder *parser = [[JSONDecoder alloc] init];
    id json = [parser objectWithUTF8String:(const unsigned char*)[string cStringUsingEncoding:NSASCIIStringEncoding] length:[string length]];
    [parser release];
    
    return json;
}


@end
