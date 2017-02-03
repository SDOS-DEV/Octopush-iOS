//
//  NotificationService.m
//  OctopushExtension
//
//  Created by Adrian Hidalgo Gonzalez on 22/12/16.
//  Copyright © 2016 SDOS. All rights reserved.
//

#import "NotificationService.h"

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    [super didReceiveNotificationRequest:request withContentHandler:contentHandler];
}

- (void)serviceExtensionTimeWillExpire {
    [super serviceExtensionTimeWillExpire];
}

@end
