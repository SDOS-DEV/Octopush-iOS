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
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"notification_unregister_correct", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didFailToUnregisterWithError:(NSError *)error {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"notification_unregister_incorrect", nil), error.userInfo[NSLocalizedDescriptionKey]] message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didFailToRegisterWithError:(NSError *)error {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"notification_register_incorrect", nil), error.userInfo[NSLocalizedDescriptionKey]] message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void)octopush:(Octopush *)octopush didRegisterWithDeviceIdentifier:(NSString *)deviceIdentifier deviceToken:(NSString *)deviceToken {
	UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"notification_register_correct", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
	[alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
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
//	if([action isEqualToString:@"identifier"]){
//		[octopushAction setActionExecute:^(OctopushAction *octopushAction, OctopushActionCompletion completionAction) {
//			//Custom Action here
//			completionAction(nil, nil);
//			
//		}];
//	}
	
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
		UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_accion_no_tratada", nil) message:octopushNotification.alert preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil];
		[alertController addAction:cancelAction];
		
		UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
		while (controller.presentedViewController) {
			controller = controller.presentedViewController;
		}
		[controller presentViewController:alertController animated:YES completion:nil];
		
		completionHandler();
	}
}

#pragma mark - Register Location

- (void) didRegisterLocationFromOctopush:(Octopush *) octopush {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"notification_location_correct", nil) message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

- (void) octopush:(Octopush *) octopush didFailToRegisterLocationWithError:(NSError *) error {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:NSLocalizedString(@"notification_location_incorrect", nil), error.description] message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
