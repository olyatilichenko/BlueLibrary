//
//  PersistencyManager.h
//  BlueLibrary
//
//  Created by Olya Tilichenko on 06.02.18.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface PersistencyManager : NSObject

- (NSArray *)albums;
- (void)addAlbum:(Album *)album atIndex:(NSUInteger)index;
- (void)deleteAlbumAtIndex:(NSUInteger)index;

@end

