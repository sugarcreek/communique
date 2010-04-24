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


#import <Foundation/Foundation.h>
#import "AppRecord.h"
#import "ParseOperation.h"

@protocol FeedLoaderDelegate;

@interface FeedLoader : NSObject <ParseOperationDelegate> {
	
    NSMutableArray          *records;
	
    
    // the queue to run our "ParseOperation"
    NSOperationQueue		*queue;
    
    // RSS feed network connection to the App Store
    NSURLConnection         *listFeedConnection;
    NSMutableData           *listData;
	
	id <FeedLoaderDelegate> delegate;
	
}

@property (nonatomic, retain) NSMutableArray *records;


@property (nonatomic, retain) NSOperationQueue *queue;

@property (nonatomic, retain) NSURLConnection *listFeedConnection;
@property (nonatomic, retain) NSMutableData *listData;
@property (nonatomic, assign) id <FeedLoaderDelegate> delegate;

@end


@protocol FeedLoaderDelegate 

- (void)reloadView:(NSMutableArray *)records;

@end