/* 
 Communique - The open church communications iPhone app.
 
 Copyright (C) 2010  Sugar Creek Baptist Church <info at sugarcreek.net> - 
 Rick Russell <rrussell at sugarcreek.net>
 
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation; either version 2 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License along
 with this program; if not, write to the Free Software Foundation, Inc.,
 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 
 */

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@class AppRecord;

@interface MediaDetailViewController : UIViewController {
	UILabel *mediaTitle;
	UIImageView *icon;
	UITextView  *description;
	UIButton *playVideoButton;
	UIButton *playAudioButton;
	MPMoviePlayerViewController *theMovieController;
	AppRecord *record;
	
}

@property (nonatomic, retain) IBOutlet UILabel *mediaTitle;
@property (nonatomic, retain) IBOutlet UIImageView *icon;
@property (nonatomic, retain) IBOutlet UITextView  *description;
@property (nonatomic, retain) IBOutlet UIButton  *playVideoButton;
@property (nonatomic, retain) IBOutlet UIButton  *playAudioButton;

@property (nonatomic, retain) IBOutlet AppRecord *record;

-(IBAction) playVideoTapped;
-(IBAction) playAudioTapped;

- (void)playMovieAtURL:(NSURL *)theURL;

@end
