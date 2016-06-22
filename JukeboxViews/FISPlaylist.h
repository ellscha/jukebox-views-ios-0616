//
//  FISPlaylist.h
//  JukeboxViews
//
//  Created by Elli Scharlin on 6/22/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FISSong.h"
@interface FISPlaylist : NSObject
@property (strong, nonatomic) NSMutableArray *songs;
@property (strong, nonatomic) NSString *text;

-(void)sortSongsByTitle;

-(void)sortSongsByArtist;

-(void)sortSongsByAlbum;

-(FISSong *)songForTrackNumber:(NSUInteger)trackNumber;


@end
