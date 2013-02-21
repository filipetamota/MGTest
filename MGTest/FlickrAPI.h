//
//  FlickrAPI.h
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrAPI : NSObject {
    
}

-(NSString*)userIdForUserName:(NSString *)username;          
-(NSArray*)photoSetListWithUserId:(NSString *)userId;   
-(NSArray*)photosWithPhotoSetId:(NSString *)photoSetId;
-(NSString*)photoSetIdWithTitle:(NSString *)title photoSets:(NSArray *)photoSets;
-(NSURL*)buildFlickrURLWithParameters:(NSDictionary *)parameters;
-(NSString*)stringByRemovingFlickrJavaScript:(NSData *)data;
-(NSString*)stringWithData:(NSData *)data;
-(id)flickrJSONSWithParameters:(NSDictionary *)parameters;

@end
