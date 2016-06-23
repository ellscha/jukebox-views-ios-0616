//
//  FISJukeboxViewController.m
//  JukeboxViews
//
//  Created by Elli Scharlin on 6/22/16.
//  Copyright © 2016 FIS. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "FISJukeboxViewController.h"
#import "FISPlaylist.h"
#import "MarqueeLabel.h"
@interface FISJukeboxViewController ()
@property (weak, nonatomic) IBOutlet UITextField *songTrackTextField;
@property (weak, nonatomic) IBOutlet UITextView *songListTextView;
@property (weak, nonatomic) IBOutlet MarqueeLabel *currentSongLabel;
@property (strong, nonatomic) FISPlaylist *playlist;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@end

@implementation FISJukeboxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.playlist = [FISPlaylist new];
    NSLog(@"%@", self.playlist.text);
    self.songListTextView.text = self.playlist.text;
    // Do any additional setup after loading the view.
}
- (IBAction)sortTitleTapped:(id)sender {
    [self.playlist sortSongsByTitle];
    self.songListTextView.text = self.playlist.text;
}
- (IBAction)sortAlbumTapped:(id)sender {
    [self.playlist sortSongsByAlbum];
    self.songListTextView.text = self.playlist.text;
}
- (IBAction)sortArtistTapped:(id)sender {
    [self.playlist sortSongsByArtist];
    self.songListTextView.text = self.playlist.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)playTapped:(id)sender {

    [self.view endEditing:true];
    NSString *track = self.songTrackTextField.text;
    if ([[self.playlist songForTrackNumber:[track integerValue]].title isEqualToString:@""]) {
        [self.audioPlayer stop];
        self.currentSongLabel.text = @"Not a valid input.";
    }
    else{
        
    
    NSLog(@"%@", track);
    [self.playlist songForTrackNumber:[track intValue]];
    NSLog(@"%@ playing", [self.playlist songForTrackNumber:[track intValue]].title);
    NSString *displayInfo = [NSString stringWithFormat:@"%@ ∆ %@ ∆ %@ ∆", [self.playlist songForTrackNumber:[track intValue]].title, [self.playlist songForTrackNumber:[track intValue]].artist, [self.playlist songForTrackNumber:[track intValue]].album];
    self.currentSongLabel.text = displayInfo;
    [self setUpAVAudioPlayerWithFileName:[self.playlist songForTrackNumber:[track integerValue]].fileName];
    [self.audioPlayer play];
    [self.currentSongLabel unpauseLabel];
    }

}
- (IBAction)stopTapped:(id)sender {
    [self.audioPlayer stop];
    [self.currentSongLabel pauseLabel];
    NSLog(@"Music has been stopped.");
}
- (void)setUpAVAudioPlayerWithFileName:(NSString *)fileName
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:@"mp3"];
    NSError *error = nil;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!self.audioPlayer)
    {
        NSLog(@"Error in audioPlayer: %@",
              [error localizedDescription]);
    } else {
        [self.audioPlayer prepareToPlay];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
