//
//  LibraryAPI.h
//  BlueLibrary
//
//  Created by Olya Tilichenko on 06.02.18.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface LibraryAPI : NSObject

+ (LibraryAPI *)sharedInstance;
- (NSArray *)albums;
- (void)addAlbum:(Album *)album atIndex:(int)index;
- (void)deleteAlbumAtIndex:(int)index;

@end
