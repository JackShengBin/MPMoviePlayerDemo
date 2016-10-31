//
//  ViewController.m
//  MPMoviePlayer视频播放
//
//  Created by 梦想 on 2016/10/31.
//  Copyright © 2016年 lin_tong. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface ViewController ()
//视频播放控制器
@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation ViewController

- (MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"3.mp4" ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:url];
        _moviePlayer.view.frame = self.view.bounds;
        _moviePlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
        
    }
    return _moviePlayer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.moviePlayer play];
    [self addNotification];
    
}

- (void)addNotification{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayer];
    [center addObserver:self selector:@selector(mediaPlayerPlaybackStateDidFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
}

- (void)mediaPlayerPlaybackStateChange:(NSNotification *)ntf{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"视频已暂停");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"视频停止");
            break;
        default:
            NSLog(@"视频状态 : %ld", self.moviePlayer.playbackState);
            break;
    }
}

- (void)mediaPlayerPlaybackStateDidFinished:(NSNotification *)ntf{
    NSLog(@"视频播放完成");
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
