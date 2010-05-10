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


#import "FeedLoader.h"
#import "ParseOperation.h"

// This framework was imported so we could use the kCFURLErrorNotConnectedToInternet error code.
#import <CFNetwork/CFNetwork.h>



@implementation FeedLoader

@synthesize records, queue, listFeedConnection, listData;
@synthesize delegate;


- (id)init
{
	self = [super init];
	self.records = [NSMutableArray array];
	return self;
}	

// -------------------------------------------------------------------------------
//	handleLoadedApps:notif
// -------------------------------------------------------------------------------
- (void)handleLoadedMedia:(NSArray *)loadedMedia
{
    [self.records addObjectsFromArray:loadedMedia];
    
    // tell our table view to reload its data, now that parsing has completed
    [self.delegate reloadView:self.records];
}

// -------------------------------------------------------------------------------
//	didFinishParsing:appList
// -------------------------------------------------------------------------------
- (void)didFinishParsing:(NSArray *)mediaList
{
    [self performSelectorOnMainThread:@selector(handleLoadedMedia:) withObject:mediaList waitUntilDone:NO];
    
    self.queue = nil;   // we are finished with the queue and our ParseOperation

}

- (void)parseErrorOccurred:(NSError *)error
{
    [self performSelectorOnMainThread:@selector(handleError:) withObject:error waitUntilDone:NO];
}

#pragma mark -
#pragma mark NSURLConnection delegate methods

// -------------------------------------------------------------------------------
//	handleError:error
// -------------------------------------------------------------------------------
- (void)handleError:(NSError *)error
{
    NSString *errorMessage = [error localizedDescription];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot Load Feed"
														message:errorMessage
													   delegate:nil
											  cancelButtonTitle:@"OK"
											  otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

// The following are delegate methods for NSURLConnection. Similar to callback functions, this is how
// the connection object,  which is working in the background, can asynchronously communicate back to
// its delegate on the thread from which it was started - in this case, the main thread.
//

// -------------------------------------------------------------------------------
//	connection:didReceiveResponse:response
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.listData = [NSMutableData data];    // start off with new data
}

// -------------------------------------------------------------------------------
//	connection:didReceiveData:data
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [listData appendData:data];  // append incoming data
}

// -------------------------------------------------------------------------------
//	connection:didFailWithError:error
// -------------------------------------------------------------------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if ([error code] == kCFURLErrorNotConnectedToInternet)
	{
        // if we can identify the error, we can present a more precise message to the user.
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"No Connection Error"
															 forKey:NSLocalizedDescriptionKey];
        NSError *noConnectionError = [NSError errorWithDomain:NSCocoaErrorDomain
														 code:kCFURLErrorNotConnectedToInternet
													 userInfo:userInfo];
        [self handleError:noConnectionError];
    }
	else
	{
        // otherwise handle the error generically
        [self handleError:error];
    }
    
    self.listFeedConnection = nil;   // release our connection
}

// -------------------------------------------------------------------------------
//	connectionDidFinishLoading:connection
// -------------------------------------------------------------------------------
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.listFeedConnection = nil;   // release our connection
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;   
    
    // create the queue to run our ParseOperation
    self.queue = [[NSOperationQueue alloc] init];
    
    // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
    // "ownership of mediaListData has been transferred to the parse operation and should no longer be
    // referenced in this thread.
    //
    ParseOperation *parser = [[ParseOperation alloc] initWithData:listData delegate:self];
    
    [queue addOperation:parser]; // this will start the "ParseOperation"
    
    [parser release];
    [queue release];
    // ownership of mediaListData has been transferred to the parse operation
    // and should no longer be referenced in this thread
    self.listData = nil;
}

- (void)dealloc {
	[records release];
    [listFeedConnection release];
    [listData release];
	[queue release];
	
    [super dealloc];
}

@end
