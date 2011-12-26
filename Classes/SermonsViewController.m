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
 
 Pull to refresh additions noted with "pull to refresh"
 
 //  Created by Devin Doty on 10/16/09October16.
 //  Copyright enormego 2009. All rights reserved.
 //
 //  Permission is hereby granted, free of charge, to any person obtaining a copy
 //  of this software and associated documentation files (the "Software"), to deal
 //  in the Software without restriction, including without limitation the rights
 //  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 //  copies of the Software, and to permit persons to whom the Software is
 //  furnished to do so, subject to the following conditions:
 //
 //  The above copyright notice and this permission notice shall be included in
 //  all copies or substantial portions of the Software.
 //
 //  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 //  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 //  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 //  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 //  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 //  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 //  THE SOFTWARE.
 
 
 */

#import "SermonsViewController.h"
#import "AppRecord.h"

#define kCustomRowHeight    48.0
#define kCustomRowCount     7

#pragma mark -

@interface SermonsViewController ()

- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath;

@end

@implementation SermonsViewController

@synthesize entries;
@synthesize imageDownloadsInProgress;
@synthesize mediaDetailView;
@synthesize connectViewController;
@synthesize headerCell;


#pragma mark 

-(id)init
{
	self = [super init];
	didRelease = NO;
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    self.tableView.rowHeight = kCustomRowHeight;
    
    //pull to refresh
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];
        
    }
    
    [_refreshHeaderView refreshLastUpdatedDate];
    //
}

//pull to refresh
- (void)viewDidUnload
{
	//self.entries = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	if (didRelease) {
		[self.tableView reloadData];
	}
}

/*
 -(void)viewDidAppear:(BOOL)animated
 {
 if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)){
 [UIView beginAnimations:@"View Flip" context:nil];
 [UIView setAnimationDuration:0.5f];
 [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
 self.tabBarController.view.transform = CGAffineTransformIdentity;
 self.tabBarController.view.transform =
 CGAffineTransformMakeRotation(M_PI * (90) / 180.0);
 self.view.bounds = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
 [UIView commitAnimations];
 }
 }
 */

- (void)dealloc
{
    [entries release];
	[imageDownloadsInProgress release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    didRelease = YES;
    // terminate all pending download connections
    //NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    //[allDownloads performSelector:@selector(cancelDownload)];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table view creation (UITableViewDataSource)

// customize the number of rows in the table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	int count = [entries count];
	
	// ff there's no data yet, return enough rows to fill the screen
    if (count == 0)
	{
        return kCustomRowCount;
    }
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	// customize the appearance of table view cells
	//
	static NSString *CellIdentifier = @"MediaTableCell";
    static NSString *PlaceholderCellIdentifier = @"PlaceholderCell";
    
    // add a placeholder cell while waiting on table data
    int nodeCount = [self.entries count];
	
    
	
	if (nodeCount == 0 && indexPath.row == 0)
	{
		
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaceholderCellIdentifier];
        if (cell == nil)
		{
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
										   reuseIdentifier:PlaceholderCellIdentifier] autorelease];   
            cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
		
		cell.detailTextLabel.text = @"Loading…";
		
		return cell;
    }
	
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
									   reuseIdentifier:CellIdentifier] autorelease];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
    // Leave cells empty if there's no data yet
    if (nodeCount > 0)
	{
        // Set up the cell...
        AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
        
		cell.textLabel.text = appRecord.itemTitle;
        cell.detailTextLabel.text = [appRecord itemDateLongStyle];
		
        // Only load cached images; defer new downloads until scrolling ends
        if (!appRecord.itemIcon)
        {
            if (self.tableView.dragging == NO && self.tableView.decelerating == NO)
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
            // if a download is deferred or in progress, return a placeholder image
            cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];                
        }
        else
        {
			cell.imageView.image = appRecord.itemThumbIcon;
        }
		
    }
    
    return cell;
}

//pull to refresh
- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}
//pull to refresh
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}

//pull to refresh
#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}
/*
 - (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
 //added following line to existing section below
 [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
 
 }
 */
//pull to refresh
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

//pull to refresh
- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//pull to refresh
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


//


#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil) 
    {
        iconDownloader = [[IconDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];   
    }
}

// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([self.entries count] > 0)
    {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
            
            if (!appRecord.itemThumbIcon) // avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}

// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // Display the newly loaded image
        cell.imageView.image = iconDownloader.appRecord.itemThumbIcon;
    }
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic
	
	int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
    
	// Do we have any records yet?
	if ([entries count] > 0) {
		
        
		AppRecord * entry = [entries objectAtIndex: storyIndex];
		
		//NSString * storyLink = entry.itemURLString;
		
		// clean up the link - get rid of spaces, returns, and tabs...
		//storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
		//storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		//storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
		
		//NSLog(@"link: %@", storyLink);
		// open in Safari
		//[self playMovieAtURL:[NSURL URLWithString:storyLink]];
		// [[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];}
		mediaDetailView.record = entry;
		[self.navigationController pushViewController:mediaDetailView animated:YES];
	}
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
	{
        [self loadImagesForOnscreenRows];
    }
    //pull to refresh
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

// Implementation of the FromViewDelegate
- (void)reloadView:(NSMutableArray *)records 
{
	self.entries = records;
	[self.tableView reloadData];
}



-(IBAction) leftButtonTapped
{
	
}

-(IBAction) rightButtonTapped
{
	[self.navigationController pushViewController:connectViewController animated:YES];
}



@end
