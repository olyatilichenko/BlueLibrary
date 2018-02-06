//
//  Album+TableRepresentation.m
//  BlueLibrary
//
//  Created by Olya Tilichenko on 06.02.18.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation
{
    return @{@"titles":@[@"Исполнитель", @"Альбом", @"Жанр", @"Год"],
             @"values":@[self.artist, self.title, self.genre, self.year]};
}

@end
