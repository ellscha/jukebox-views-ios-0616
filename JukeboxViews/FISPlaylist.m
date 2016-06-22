//
//  FISPlaylist.m
//  JukeboxViews
//
//  Created by Elli Scharlin on 6/22/16.
//  Copyright © 2016 FIS. All rights reserved.
//

#import "FISPlaylist.h"

@implementation FISPlaylist

- (NSMutableArray *)generateSongObjects
{
    NSMutableArray *songs = [[NSMutableArray alloc] init];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Hold on Be Strong"
                                             artist:@"Matoma vs Big Poppa"
                                              album:@"The Internet 1"
                                           fileName:@"hold_on_be_strong"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Higher Love"
                                             artist:@"Matoma ft. James Vincent McMorrow"
                                              album:@"The Internet 2"
                                           fileName:@"higher_love"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Mo Money Mo Problems"
                                             artist:@"Matoma ft. The Notorious B.I.G."
                                              album:@"The Internet 3"
                                           fileName:@"mo_money_mo_problems"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Old Thing Back"
                                             artist:@"The Notorious B.I.G."
                                              album:@"The Internet 4"
                                           fileName:@"old_thing_back"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Gangsta Bleeding Love"
                                             artist:@"Matoma"
                                              album:@"The Internet 5"
                                           fileName:@"gangsta_bleeding_love"] ];
    
    [songs addObject:[[FISSong alloc] initWithTitle:@"Bailando"
                                             artist:@"Enrique Iglesias ft. Sean Paul"
                                              album:@"The Internet 6"
                                           fileName:@"bailando"] ];
    return songs;
}

-(NSString *)generateText{
    NSString *text = @"";
    for (NSUInteger i = 0; i < [self.songs count]; i++) {
        FISSong *currentSong = self.songs[i];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%lu. (Title) %@ (Artist) %@ (Album) %@\n", i +1, currentSong.title, currentSong.artist, currentSong.album]];
    }
    NSLog(@"%@ TEXT###############", text);
    return text;
}

-(instancetype) init {
    self = [self initWithSongs:[self generateSongObjects]];
    return self;
}

-(instancetype) initWithSongs:(NSMutableArray *)songs{
    self = [super init];
    
    if (self) {
        _songs = songs;
        _text = [self generateText];
        
    }
    
    return self;
}

-(void)sortSongsByTitle{
    
    NSSortDescriptor *sortByTitle = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    NSSortDescriptor *sortByArtist = [[NSSortDescriptor alloc]initWithKey:@"artist" ascending:YES];
    NSMutableArray *sortedTitleArray = [self.songs sortedArrayUsingDescriptors:@[sortByTitle, sortByArtist]];
    [self initWithSongs:sortedTitleArray];
    
}

-(void)sortSongsByArtist{
    NSSortDescriptor *sortByArtist = [[NSSortDescriptor alloc]initWithKey:@"artist" ascending:YES];
    NSSortDescriptor *sortByAlbum = [[NSSortDescriptor alloc]initWithKey:@"album" ascending:YES];
    NSMutableArray *sortedArtistArray = [self.songs sortedArrayUsingDescriptors:@[sortByArtist, sortByAlbum]];
    [self initWithSongs:sortedArtistArray];

    
}

-(void)sortSongsByAlbum{
    NSSortDescriptor *sortByAlbum = [[NSSortDescriptor alloc]initWithKey:@"album" ascending:YES];
    NSSortDescriptor *sortByTitle = [[NSSortDescriptor alloc]initWithKey:@"title" ascending:YES];
    NSMutableArray *sortedAlbumArray = [self.songs sortedArrayUsingDescriptors:@[sortByAlbum, sortByTitle]];
    [self initWithSongs:sortedAlbumArray];

}

-(FISSong *)songForTrackNumber:(NSUInteger)trackNumber{
    if ((trackNumber == 0) || trackNumber > self.songs.count) {
        return nil;
    }
    return self.songs[trackNumber -1];
}


@end
