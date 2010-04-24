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

@interface AppRecord : NSObject
{
    NSString *itemTitle;
    UIImage *itemIcon;
    NSString *itemDate;
	NSString *itemSummary;
    NSString *imageURLString;
    NSString *itemURLString;
    NSString *itemAudioURLString;
}

@property (nonatomic, retain) NSString *itemTitle;
@property (nonatomic, retain) UIImage *itemIcon;
@property (nonatomic, retain) NSString *itemDate;
@property (nonatomic, retain) NSString *itemSummary;
@property (nonatomic, retain) NSString *imageURLString;
@property (nonatomic, retain) NSString *itemURLString;
@property (nonatomic, retain) NSString *itemAudioURLString;

-(NSString *)itemDateShortStyle;
-(NSString *)itemDateLongStyle;


@end