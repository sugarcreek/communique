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

#import "AppRecord.h"

@implementation AppRecord


@synthesize itemTitle;
@synthesize itemIcon;
@synthesize itemDate;
@synthesize itemSummary;
@synthesize imageURLString;
@synthesize itemURLString;
@synthesize itemAudioURLString;

- (void)dealloc
{
    [itemTitle release];
    [itemIcon release];
    [itemDate release];
	[itemSummary release];
    [imageURLString release];
	[itemURLString release];
	[itemAudioURLString release];
    
    [super dealloc];
}

-(NSString *)itemDateShortStyle
{	
	// Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
	NSDate *date = [dateFormat dateFromString:self.itemDate];  
	
	// Convert date object to desired output format
	[dateFormat setDateStyle:NSDateFormatterShortStyle];
	NSString *dateStr = [dateFormat stringFromDate:date];  
	[dateFormat release];
	return dateStr;
}

-(NSString *)itemDateLongStyle
{	
	// Convert string to date object
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss z"];
	NSDate *date = [dateFormat dateFromString:self.itemDate];  
	
	// Convert date object to desired output format
	[dateFormat setDateStyle:NSDateFormatterLongStyle];
	NSString *dateStr = [dateFormat stringFromDate:date];  
	[dateFormat release];
	return dateStr;
}
@end

