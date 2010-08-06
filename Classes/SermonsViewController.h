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

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <MediaPlayer/MediaPlayer.h>
#import "IconDownloader.h"
#import "FeedLoader.h"
#import "MediaDetailViewController.h"
#import "ConnectViewController.h"

@interface SermonsViewController : UITableViewController <UIScrollViewDelegate, IconDownloaderDelegate, FeedLoaderDelegate>
{
	NSArray *entries;   // the main data model for our UITableView
    NSMutableDictionary *imageDownloadsInProgress;  // the set of IconDownloader objects for each app
	MediaDetailViewController *mediaDetailView;
	ConnectViewController *connectViewController;
	UIView *headerCell;
	Boolean didRelease;
}

@property (nonatomic, retain) NSArray *entries;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain) IBOutlet MediaDetailViewController *mediaDetailView;
@property (nonatomic, retain) IBOutlet ConnectViewController *connectViewController;
@property (nonatomic, retain) IBOutlet UIView *headerCell;

- (void)appImageDidLoad:(NSIndexPath *)indexPath;

-(IBAction) leftButtonTapped;
-(IBAction) rightButtonTapped;

@end