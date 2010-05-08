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

#import "ConnectViewController.h"


@implementation ConnectViewController

//@synthesize browserView;

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


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction) tappedTwitter
{
	NSURL *url = [NSURL URLWithString:@"http://m.twitter.com/sugarcreek"];
	[[UIApplication sharedApplication] openURL:url];
	
	//browserView.urlString = @"http://m.twitter.com/sugarcreek";
	//browserView.hidesBottomBarWhenPushed = YES;
	//[self.navigationController pushViewController:browserView animated:YES];
}

-(IBAction) tappedFacebook
{
	NSURL *url = [NSURL URLWithString:@"http://m.facebook.com/sugarcreekonline"];
	[[UIApplication sharedApplication] openURL:url];
}

-(IBAction) tappedEmail
{
	NSURL *url = [NSURL URLWithString:@"mailto://info@sugarcreek.net"];
	[[UIApplication sharedApplication] openURL:url];
}

-(IBAction) tappedPhone
{
	NSURL *url = [NSURL URLWithString:@"tel://281-242-2858"];
	[[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
