//
//  WebServiceClient.h
//  MGTest
//
//  Created by Filipe on 19/02/13.
//  Copyright (c) 2013 Filipe. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface WebServiceClient : NSObject 
{
    
}

+ (NSData *)fetchResponseWithURL:(NSURL *)URL;

@end
