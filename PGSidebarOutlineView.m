//
//  PGSidebarOutlineView.m
//  GitX
//
//  Created by Bernard Leach on 16/09/09.
//  Copyright 2009 Bernard Leach. All rights reserved.
//

#import "PGSidebarOutlineView.h"


@implementation PGSidebarOutlineView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    return self;
}

- (void)doStuff:(id)sender {
	NSLog(@"Doing stuff");
}

- (NSMenu *)menuForEvent:(NSEvent *)theEvent
{
	if ([theEvent type] == NSRightMouseDown)
	{
		// get the current selections for the outline view.
		NSIndexSet *selectedRowIndexes = [self selectedRowIndexes];

		// find out which row is selected and if it should be selectable
		NSPoint mousePoint = [self convertPoint:[theEvent locationInWindow] fromView:nil];
		int row = [self rowAtPoint:mousePoint];
		id item = [self itemAtRow:row];
		if (!item || ![self.dataSource outlineView:self shouldSelectItem:item]) {
			return nil;
		}
		
		// figure out if the row that was just clicked on is currently selected
		if ([selectedRowIndexes containsIndex:row] == NO) {
			// select the row that was clicked before showing the menu for the event
			[self selectRow:row byExtendingSelection:NO];
		}
		
		NSMenu *menu = [[NSMenu alloc] init];
		NSMenuItem *historyItem = [[NSMenuItem alloc] initWithTitle:@"Do stuff"
															 action:@selector(doStuff:)
													  keyEquivalent:@""];
		[historyItem setTarget:self];
		[historyItem setRepresentedObject:item];
		[menu addItem:historyItem];
		
		return menu;
	}
	
	return nil;
}

@end
