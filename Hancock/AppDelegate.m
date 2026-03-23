//
//  AppDelegate.m
//  CertAndSign
//
//  Created by Jeremy Agostino on 6/27/16.
//  Copyright © 2016 GroundControl. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <Security/Security.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// We may need to ask the user for permission to sign
	// SecKeychain and SecKeychainSetUserInteractionAllowed are deprecated on modern macOS.
	// When linking against newer SDKs, avoid calling the deprecated API to silence warnings.
	// If your signing flow requires user interaction, consider using Authorization Services
	// or relying on the system's automatic prompts when accessing keychain items.
	#if !defined(__MAC_OS_X_VERSION_MAX_ALLOWED) || (__MAC_OS_X_VERSION_MAX_ALLOWED < 101000)
		SecKeychainSetUserInteractionAllowed(true);
	#else
		(void)aNotification; // suppress unused parameter warning if nothing to do
	#endif
}

- (void)applicationWillTerminate:(NSNotification *)aNotification
{
	
}

/*
 * Convenience method to get the ViewController object that implements our app functionality
 */

- (ViewController *)mainViewController
{
	for (NSWindow * window in NSApp.orderedWindows) {
		id vc = window.contentViewController;
		if ([vc isKindOfClass:[ViewController class]]) {
			return vc;
		}
	}
	return nil;
}

/*
 * The openFile: and openFiles: methods are invoked when items are dragged onto our dock icon
 */

- (BOOL)application:(NSApplication *)sender openFile:(NSString *)filename
{
	[[self mainViewController] handleDraggedFilename:filename];
	return YES;
}

- (void)application:(NSApplication *)sender openFiles:(NSArray<NSString *> *)filenames
{
	id vc = [self mainViewController];
	for (NSString * filename in filenames) {
		[vc handleDraggedFilename:filename];
	}
}

@end

