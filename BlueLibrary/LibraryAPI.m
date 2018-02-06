//
//  LibraryAPI.m
//  BlueLibrary
//
//  Created by Olya Tilichenko on 06.02.18.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI ()
{
    PersistencyManager * persistencyManager;
    HTTPClient * httpClient;
    BOOL isOnline;
}
@end

@implementation LibraryAPI

+ (LibraryAPI *)sharedInstance
{
    // 1
    static LibraryAPI * _sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}
- (id)init
{
    self = [super init];
    if (self)
    {
        persistencyManager = [[PersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        isOnline = NO;
    }
    return self;
}
- (NSArray *)albums
{
    return [persistencyManager albums];
}

- (void)addAlbum:(Album *)album atIndex:(int)index
{
    [persistencyManager addAlbum:album atIndex:index];
    if (isOnline)
    {
        [httpClient postRequest:@"/api/addAlbum" body:[album description]];
    }
}

- (void)deleteAlbumAtIndex:(int)index
{
    [persistencyManager deleteAlbumAtIndex:index];
    if (isOnline)
    {
        [httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
}
@end
