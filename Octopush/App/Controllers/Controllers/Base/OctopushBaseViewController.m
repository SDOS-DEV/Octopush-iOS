//
//  OctopushBaseViewController.m
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "OctopushBaseViewController.h"
#import <FLEX/FLEX.h>

@interface OctopushBaseViewController ()

@end

@implementation OctopushBaseViewController

#pragma mark - Flex

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
        [FLEXManager sharedManager].networkDebuggingEnabled = YES;
        [[FLEXManager sharedManager] showExplorer];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
