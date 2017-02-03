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
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Dispositivo desregistrado correctamente" message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didFailToUnregisterWithError:(NSError *)error {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Fallo al desregistrar: %@", error.userInfo[NSLocalizedDescriptionKey]] message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didFailToRegisterWithError:(NSError *)error {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"Fallo en el registro: %@", error.userInfo[NSLocalizedDescriptionKey]] message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didRegisterWithDeviceIdentifier:(NSString *)deviceIdentifier deviceToken:(NSString *)deviceToken {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Registro realizado correctamente" message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didPresentNotification:(OctopushNotification *)octopushNotification withCompletionHandler:(void (^)(OctopushNotificationPresentOptions))completionHandler {
	completionHandler(OctopushNotificationPresentNative | OctopushNotificationPresentBadge | OctopushNotificationPresentSound);
}

- (void)octopush:(Octopush *)octopush didReceiveSilentNotification:(OctopushNotification *)octopushNotification withCompletionHandler:(void (^)(OctopushSilentResultType))completionHandler{
	if ([Octopush canHandleNotification:octopushNotification]) {
		[Octopush handleNotification:octopushNotification actionCompletion:^(id object, NSError *error) {
			if (!error) {
				completionHandler(OctopushSilentResultNewData);
			} else {
				completionHandler(OctopushSilentResultNoData);
			}
		}];
	} else {
		NSLog(@"Acción no implementada");
		completionHandler(OctopushSilentResultNoData);
	}
}

- (OctopushAction *)octopush:(Octopush *)octopush willRegisterAction:(NSString *)action {
	
	OctopushAction *octopushAction = [OctopushAction initializeWithIdentifier:action];
	if([action isEqualToString:@"Ir a Sección Cupones"]){
		//Asignamos las opciones de la notificación
		octopushAction.actionOptions =  OctopushActionOptionsAuthenticationRequired | OctopushActionOptionsForeground;
		[octopushAction setActionExecute:^(OctopushAction *octopushAction, OctopushActionCompletion completionAction) {
			//Asignamos la acción del botón
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Titulo"
															message:@"Accion Tratada"
														   delegate:nil
												  cancelButtonTitle:NSLocalizedStringFromTable(@"Aceptar", @"LocalizableOctopush", nil)
												  otherButtonTitles:nil];
			[alert show];
			completionAction(nil, nil);
			
		}];
	}
	
	if([action isEqualToString:@"Apuntate al concurso"]){
		[octopushAction setActionExecute:^(OctopushAction *octopushAction, OctopushActionCompletion completionAction) {
			
			UIAlertController *alertController = [UIAlertController alertControllerWithTitle:action message:@"" preferredStyle:UIAlertControllerStyleAlert];
			UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil];
			[alertController addAction:cancelAction];
			
			completionAction(alertController, nil);
			
		}];
	}
	
	return octopushAction;
}

- (void)octopush:(Octopush *)octopush handleActionFromNotification:(OctopushNotification *)octopushNotification withCompletionHandler:(void (^)())completionHandler {
	
	if ([Octopush canHandleNotification:octopushNotification]) {
		[Octopush handleNotification:octopushNotification actionCompletion:^(id object, NSError *error) {
			if(object){
				UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
				while (controller.presentedViewController) {
					controller = controller.presentedViewController;
				}
				[controller presentViewController:(UIAlertController*)object animated:YES completion:nil];
			}
			completionHandler();
		}];
	} else {
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] message:octopushNotification.alert preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cerrar" style:UIAlertActionStyleCancel handler:nil];
		[alertController addAction:cancelAction];
		
		UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
		while (controller.presentedViewController) {
			controller = controller.presentedViewController;
		}
		[controller presentViewController:alertController animated:YES completion:nil];
		
		completionHandler();
	}
}

@end
