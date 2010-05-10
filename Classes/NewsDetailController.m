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

#import "NewsDetailController.h"
#import "AppRecord.h"

@implementation NewsDetailController


@synthesize newsDescription, record, activityIndicator;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/



- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationItem.title = self.record.itemTitle;
	
	NSString * storyLink = self.record.itemURLString;
	
	// clean up the link - get rid of spaces, returns, and tabs...
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	//newsDescription.scalesPageToFit = YES;
	NSLog(@"news: %@", storyLink);
	// open in Safari
	//[self playMovieAtURL:[NSURL URLWithString:storyLink]];
	//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
	[newsDescription loadHTMLString:self.record.itemSummary baseURL:[NSURL URLWithString:storyLink]];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES; // Adjust to taste
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	self.record = nil;
	
}

-(IBAction)refreshTapped {
	[newsDescription reload];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[activityIndicator startAnimating];	
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[activityIndicator stopAnimating];
	lastRequest = nil;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

	/*
	 If the user clicks a link to a page other then the first news page, scale to fit.
	 If it is of type UIWebViewNavigationTypeOther and it is a new request don't scale to fit.
	*/
	if(navigationType == UIWebViewNavigationTypeLinkClicked)
	{
		webView.scalesPageToFit = YES;
		lastRequest = request;
	}
	
	if(navigationType == UIWebViewNavigationTypeOther && lastRequest == nil)
	{
		webView.scalesPageToFit = NO;
	}
	
	return YES;
}
	
- (void)dealloc {
    [super dealloc];
}


@end
