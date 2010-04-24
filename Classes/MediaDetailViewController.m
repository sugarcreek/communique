/* 
 The Open Church App - an open source iPhone application for churches
 to share information with their members.
 
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

#import "MediaDetailViewController.h"
#import "AppRecord.h"

@implementation MediaDetailViewController

@synthesize mediaTitle, icon, description, playVideoButton, playAudioButton, record;

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	mediaTitle.text = self.record.itemTitle;
	//icon. = record.imageURLString;
	description.text = self.record.itemSummary;
	
	if(self.record.itemAudioURLString == nil)
	{
		playAudioButton.hidden = YES;
	} else {
		playAudioButton.hidden = NO;
	}
	
	if (self.record.itemURLString == nil) {
		playVideoButton.hidden = YES;
	} else {
		playVideoButton.hidden = NO;
	}

	
	if (self.record.itemIcon != nil) {
		icon.image = self.record.itemIcon;
		icon.hidden = NO;
	} else {
		icon.hidden = YES;
	}

}

-(IBAction) playVideoTapped
{
	NSString * storyLink = self.record.itemURLString;
	
	// clean up the link - get rid of spaces, returns, and tabs...
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	
	NSLog(@"link: %@", storyLink);
	[self playMovieAtURL:[NSURL URLWithString:storyLink]];
}


-(IBAction) playAudioTapped
{
	NSString * storyLink = self.record.itemAudioURLString;
	
	// clean up the link - get rid of spaces, returns, and tabs...
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	
	NSLog(@"audioLink: %@", storyLink);
	[self playMovieAtURL:[NSURL URLWithString:storyLink]];
}



-(void) playMovieAtURL: (NSURL*) theURL {
	
    MPMoviePlayerController* theMovie =
	[[MPMoviePlayerController alloc] initWithContentURL: theURL];
	
    theMovie.scalingMode = MPMovieScalingModeAspectFill;
    // theMovie.movieControlMode = MPMovieControlModeHidden;
	
    // Register for the playback finished notification
    [[NSNotificationCenter defaultCenter]
	 addObserver: self
	 selector: @selector(myMovieFinishedCallback:)
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: theMovie];
	
    // Movie playback is asynchronous, so this method returns immediately.
    [theMovie play];
}

// When the movie is done, release the controller.
-(void) myMovieFinishedCallback: (NSNotification*) aNotification
{
    MPMoviePlayerController* theMovie = [aNotification object];
	
    [[NSNotificationCenter defaultCenter]
	 removeObserver: self
	 name: MPMoviePlayerPlaybackDidFinishNotification
	 object: theMovie];
	
    // Release the movie instance created in playMovieAtURL:
    [theMovie release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end
