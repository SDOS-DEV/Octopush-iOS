//  Octopush
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import "OctopushConfiguration.h"

@implementation OctopushConfiguration

#pragma mark Singleton Methods

+ (instancetype) sharedInstance {
	
	static OctopushConfiguration *_shared;
	if(!_shared) {
		static dispatch_once_t oncePredicate;
		dispatch_once(&oncePredicate, ^{
			_shared = [[super allocWithZone:nil] init];
		});
	}
	
	return _shared;
}

+ (instancetype)allocWithZone:(NSZone *)zone {
	
	return [self sharedInstance];
}

- (instancetype)copyWithZone:(NSZone *)zone {
	return self;
}

#if (!__has_feature(objc_arc))

- (id)retain {
	
	return self;
}

- (unsigned)retainCount {
	return UINT_MAX;  //denotes an object that cannot be released
}

- (void)release {
	//do nothing
}

- (id)autorelease {
	
	return self;
}

#endif

+ (void)loadConfiguration {
	[Octopush shared].delegate = [self sharedInstance];
	[Octopush shared].registerLocation = YES;
	[Octopush registerLocation];
	[Octopush registerDevice];
}

#pragma mark - Octopush Push Notifications Methods

- (void)didUnregisterFromOctopush:(Octopush *)octopush {
	//Método que se llama al desregistrar el dispositivo de Octopush.
	
}

- (void)octopush:(Octopush *)octopush didFailToUnregisterWithError:(NSError *)error {
	//Método que se llama al fallar al desregistrar el dispositivo de Octopush.
	
}

- (void)octopush:(Octopush *)octopush didFailToRegisterWithError:(NSError *)error {
	//Método que se llama al fallar el registro del dispositivo.
	
}

- (void)octopush:(Octopush *)octopush didRegisterWithDeviceIdentifier:(NSString *)deviceIdentifier deviceToken:(NSString *)deviceToken {
	//Método que se llama al registrar el dispositivo en Octopush.
	
}

- (void)octopush:(Octopush *)octopush didPresentNotification:(OctopushNotification *)octopushNotification withCompletionHandler:(void (^)(OctopushNotificationPresentOptions))completionHandler {
	//Método que se llama para presentar una notificación estando la aplicacion en primer plano. En este método se debe controlar el modo de visualización de la notificación
	
	completionHandler(OctopushNotificationPresentNative | OctopushNotificationPresentBadge | OctopushNotificationPresentSound);
}

- (void)octopush:(Octopush *)octopush didReceiveSilentNotification:(OctopushNotification *)octopushNotification withCompletionHandler:(void (^)(OctopushSilentResultType))completionHandler{
	//Método que se llama el recibir una notificación silenciosa. Es obligatorio llamar al bloque "completionHandler" el tratamiento
	
	if ([Octopush canHandleNotification:octopushNotification]) {
		[Octopush handleNotification:octopushNotification actionCompletion:^(id object, NSError *error) {
			if (!error) {
				completionHandler(OctopushSilentResultNewData);
			} else {
				completionHandler(OctopushSilentResultNoData);
			}
			NSLog(@"Acción implementada");
		}];
	} else {
		NSLog(@"Acción no implementada");
		completionHandler(OctopushSilentResultNoData);
	}
}

- (OctopushAction *)octopush:(Octopush *)octopush willRegisterAction:(NSString *)action {
	//Metodo para registrar la acción de la notificación.
	OctopushAction *octopushAction = [OctopushAction initializeWithIdentifier:action];
	
	return octopushAction;
}

- (void)octopush:(Octopush *)octopush handleActionFromNotification:(OctopushNotification *)octopushNotification withCompletionHandler:(void (^)())completionHandler {
	//Método que se llama al pulsar una acción de la notificación (Botones o la propia notificación). Es obligatorio llamar al bloque "completionHandler" el tratamiento
	
	if ([Octopush canHandleNotification:octopushNotification]) {
		[Octopush handleNotification:octopushNotification actionCompletion:^(id object, NSError *error) {
			NSLog(@"Acción implementada");
			completionHandler();
		}];
	} else {
		NSLog(@"Acción no implementada");
		completionHandler();
	}
}

@end
