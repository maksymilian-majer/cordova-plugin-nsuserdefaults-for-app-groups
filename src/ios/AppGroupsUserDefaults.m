#import "AppGroupsUserDefaults.h"
#import <Cordova/CDV.h>
#import <Cordova/CDVPluginResult.h>

@implementation AppGroupsUserDefaults

- (void) save:(CDVInvokedUrlCommand*)command
{
    // load the options
    NSDictionary* arguments = [command.arguments objectAtIndex:0];
    NSString* key = [arguments objectForKey:@"key"];
    NSString* value = [arguments objectForKey:@"value"];
    NSString* suite = [arguments objectForKey:@"suite"];

    // do the magic
    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:suite];
    [prefs setObject:value forKey:key];
    [prefs synchronize];

    // give the callback
    CDVPluginResult* result = nil;
    if([[prefs stringForKey:key] isEqualToString:value])
    {
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    } else {
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) saveAll:(CDVInvokedUrlCommand*)command
{
    // initialize user default' dictionary for the given app group (suite)
    NSString* suite = [command.arguments firstObject];
    NSUserDefaults* prefs = [[NSUserDefaults alloc] initWithSuiteName:suite];

    // loop through all command arguments
    int i;
    for (i = 1; i < command.arguments.count; i++) {
        // load the options
        NSDictionary *arguments = [command.arguments objectAtIndex:i];
        NSString* key = [arguments objectForKey:@"key"];
        NSString* value = [arguments objectForKey:@"value"];

        // do the magic
        [prefs setObject:value forKey:key];
    }

    // force the sync
    [prefs synchronize];

    // give the callback
    CDVPluginResult* result = nil;
    for (i = 1; i < command.arguments.count; i++) {
        // load the options
        NSDictionary *arguments = [command.arguments objectAtIndex:i];
        NSString* key = [arguments objectForKey:@"key"];
        NSString* value = [arguments objectForKey:@"value"];

        BOOL valuesAreEqual = [[prefs stringForKey:key] isEqualToString:value];
        if(result == nil && valuesAreEqual)
        {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else if (!valuesAreEqual) {
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION];
            break;
        }
    }

    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

- (void) remove:(CDVInvokedUrlCommand*)command
{
    // load the options
    NSDictionary* arguments = [command.arguments objectAtIndex:0];
    NSString* key = [arguments objectForKey:@"key"];
    NSString* suite = [arguments objectForKey:@"suite"];

    // do more magic
    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:suite];
    [prefs removeObjectForKey:key];

    // force the sync
    [prefs synchronize];

    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void) removeAll:(CDVInvokedUrlCommand*)command
{
    // initialize user default' dictionary for the given app group (suite)
    NSString* suite = [command.arguments firstObject];
    NSUserDefaults* prefs = [[NSUserDefaults alloc] initWithSuiteName:suite];

    // loop through all command arguments
    int i;
    for (i = 1; i < command.arguments.count; i++) {
        // load the key
        NSString* key = [command.arguments objectAtIndex:i];

        // do the magic
        [prefs removeObjectForKey:key];
    }

    // force the sync
    [prefs synchronize];

    [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
}

- (void) load:(CDVInvokedUrlCommand*)command
{
    // load the options
    NSDictionary* arguments = [command.arguments objectAtIndex:0];
    NSString* key = [arguments objectForKey:@"key"];
    NSString* suite = [arguments objectForKey:@"suite"];

    // do more magic
    NSUserDefaults *prefs = [[NSUserDefaults alloc] initWithSuiteName:suite];
    NSString* callbackResult = [prefs stringForKey:key];

    // give the callback
    CDVPluginResult* result = nil;
    if(callbackResult != nil)
    {
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:callbackResult];
    } else {
      result = [CDVPluginResult resultWithStatus:CDVCommandStatus_IO_EXCEPTION];
    }
    [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
}

@end
