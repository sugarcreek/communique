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
#import <UIKit/UIKit.h>
#import "AppRecord.h"
#import "ParseOperation.h"
#import "FeedLoader.h"

@class MediaViewController;
@class SermonsViewController;
@class NewsViewController;

@interface openchurchAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	UINavigationController *sermonNavConntroller;	
	UINavigationController *newsNavConntroller;
	UINavigationController *mediaNavConntroller;

    // this view controller hosts our table of top paid apps
    MediaViewController     *mediaViewController;
	SermonsViewController   *sermonsViewController;
	NewsViewController		*newsViewController;
	
	FeedLoader *mediaFeedLoader;
	FeedLoader *newsFeedLoader;
	FeedLoader *sermonsFeedLoader;
	


}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *sermonNavConntroller;
@property (nonatomic, retain) IBOutlet UINavigationController *newsNavConntroller;
@property (nonatomic, retain) IBOutlet UINavigationController *mediaNavConntroller;

@property (nonatomic, retain) IBOutlet MediaViewController *mediaViewController;
@property (nonatomic, retain) IBOutlet SermonsViewController *sermonsViewController;
@property (nonatomic, retain) IBOutlet NewsViewController *newsViewController;

-(Boolean)hasNetworkConnection;

@end
