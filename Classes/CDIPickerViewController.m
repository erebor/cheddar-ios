//
//  CDIPickerViewController.m
//  Cheddar for iOS
//
//  Created by Sam Soffes on 7/29/12.
//  Copyright (c) 2012 Nothing Magical. All rights reserved.
//

#import "CDIPickerViewController.h"
#import "CDISettingsTableViewCell.h"

@implementation CDIPickerViewController

#pragma mark - Accessors

@synthesize selectedKey = _selectedKey;
@synthesize keys = _keys;
@synthesize currentIndexPath = _currentIndexPath;


#pragma mark - UIViewController Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self loadKeys];
	
	if(self.selectedKey != nil) {
		self.currentIndexPath = [NSIndexPath indexPathForRow:[self.keys indexOfObject:self.selectedKey] inSection:0];
		[self.tableView reloadData];
		[self.tableView scrollToRowAtIndexPath:self.currentIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
	}
}


#pragma mark - SSPickerViewController

// This method should be overridden by a subclass
- (void)loadKeys {
	self.keys = nil;
	self.selectedKey = nil;
}


// This method should be overridden by a subclass
- (NSString *)cellTextForKey:(id)key {
	return key;
}

// This method should be overridden by a subclass
- (UIImage *)cellImageForKey:(id)key {
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	self.currentIndexPath = indexPath;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)[self.keys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"cellIdentifier";
	
    CDISettingsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CDISettingsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.accessoryView = nil;
    }
	id key = [self.keys objectAtIndex:indexPath.row];
	cell.textLabel.text = [self cellTextForKey:key];
    cell.imageView.image = [self cellImageForKey:key];
	if([key isEqual:self.selectedKey] == YES) {
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	} else {
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
    return cell;
}

@end
