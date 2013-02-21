//
//  WebServiceClient.m
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import "WebServiceClient.h"


@implementation WebServiceClient

//makes the request to the server
+ (NSData *)fetchResponseWithURL:(NSURL *)URL
{
   NSURLRequest *request = [NSURLRequest requestWithURL:URL];
   NSURLResponse *response = nil;
   NSError *error = nil;
   NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   return data;
}

@end
