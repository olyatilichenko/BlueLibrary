//
//  Album+TableRepresentation.h
//  BlueLibrary
//
//  Created by Olya Tilichenko on 06.02.18.
//  Copyright © 2018 Eli Ganem. All rights reserved.
//

#import "Album.h"

@interface Album (TableRepresentation)

- (NSDictionary *)tr_tableRepresentation;

@end
