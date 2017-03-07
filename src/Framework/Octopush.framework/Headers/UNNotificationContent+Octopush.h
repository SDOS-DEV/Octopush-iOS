//
//  UNNotification+Octopush.h
//  OctopushSource
//
//  Created by Rafael Fernandez Alvarez on 05/03/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>

@interface UNNotificationContent (Octopush)

@property (nonatomic, readonly) BOOL isRemoteNotificationStructure;

@end
