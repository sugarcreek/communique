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

#import "communiqueAppDelegate.h"
#import "MediaViewController.h"
#import "SermonsViewController.h"
#import "NewsViewController.h"
#import "ParseOperation.h"
#import "FeedLoader.h"
// This framework was imported so we could use the kCFURLErrorNotConnectedToInternet error code.
#import <CFNetwork/CFNetwork.h>



static NSString *const CreativeMediaFeed = @"http://www.sugarcreek.tv/ip_creative_feed.xml";
static NSString *const SermonMediaFeed = @"http://www.sugarcreek.tv/ip_video_feed2.xml";
static NSString *const NewsFeed = @"http://www.sugarcreek.net/news/feed.xml";

@implementation communiqueAppDelegate

@synthesize window;
@synthesize tabBarController,sermonNavConntroller,newsNavConntroller, mediaNavConntroller, mediaViewController;
@synthesize newsViewController, sermonsViewController;



- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
	
	// Make the nav bars black in the application
	sermonNavConntroller.navigationBar.barStyle = UIBarStyleBlack;
	newsNavConntroller.navigationBar.barStyle = UIBarStyleBlack;
    mediaNavConntroller.navigationBar.barStyle = UIBarStyleBlack;
	
	if([self hasNetworkConnection])
	{
	
		mediaFeedLoader = [[FeedLoader alloc] init];
		mediaFeedLoader.delegate = mediaViewController;
		
		NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:CreativeMediaFeed]];
		mediaFeedLoader.listFeedConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:mediaFeedLoader] autorelease];

		  
		// Test the validity of the connection object. The most likely reason for the connection object
		// to be nil is a malformed URL, which is a programmatic error easily detected during development
		// If the URL is more dynamic, then you should implement a more flexible validation technique, and
		// be able to both recover from errors and communicate problems to the user in an unobtrusive manner.
		//
		NSAssert(mediaFeedLoader.listFeedConnection != nil, @"Failure to create URL connection.");
		
		sermonsFeedLoader = [[FeedLoader alloc] init];
		sermonsFeedLoader.delegate = sermonsViewController;
		
		urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:SermonMediaFeed]];
		sermonsFeedLoader.listFeedConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:sermonsFeedLoader] autorelease];
		
		// Test the validity of the connection object. The most likely reason for the connection object
		// to be nil is a malformed URL, which is a programmatic error easily detected during development
		// If the URL is more dynamic, then you should implement a more flexible validation technique, and
		// be able to both recover from errors and communicate problems to the user in an unobtrusive manner.
		//
		NSAssert(sermonsFeedLoader.listFeedConnection != nil, @"Failure to create URL connection.");
		
		newsFeedLoader = [[FeedLoader alloc] init];
		newsFeedLoader.delegate = newsViewController;
		
		urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:NewsFeed]];
		newsFeedLoader.listFeedConnection = [[[NSURLConnection alloc] initWithRequest:urlRequest delegate:newsFeedLoader] autorelease];
		
		// Test the validity of the connection object. The most likely reason for the connection object
		// to be nil is a malformed URL, which is a programmatic error easily detected during development
		// If the URL is more dynamic, then you should implement a more flexible validation technique, and
		// be able to both recover from errors and communicate problems to the user in an unobtrusive manner.
		//
		//NSAssert(sermonsViewController.sermonsListFeedConnection != nil, @"Failure to create URL connection.");
		
		// show in the status bar that network activity is starting
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	} else {
		tabBarController.selectedIndex = 3;
		
	}
	

}



-(Boolean)hasNetworkConnection
{
	Boolean retVal = NO;
	
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, [@"www.sugarcreek.net" UTF8String]);

	if(reachability!= NULL)
	{
		SCNetworkReachabilityFlags flags;
		if (SCNetworkReachabilityGetFlags(reachability, &flags))
		{
	
			if ((flags & kSCNetworkReachabilityFlagsReachable)) {
				retVal = YES;
			} else {
				retVal = NO;
			}
		}
		
	 }
	
	
	
	reachability = nil;

	return retVal;
}


- (void)dealloc {
    [tabBarController release];
    
	[newsFeedLoader release];
	[mediaFeedLoader release];
	[sermonsFeedLoader release];
	
	[mediaViewController release];
	
    [window release];
    [super dealloc];
}

@end

