//  Octopush
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>
#import <Octopush/Octopush.h>
#import <OctopushShared/OctopushNotification.h>

@interface OctopushConfiguration : NSObject <OctopushNotificationDelegate>

+ (void) loadConfiguration;

@end
