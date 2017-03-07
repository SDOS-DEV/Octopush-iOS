//  OctopushDelegate
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>

@class Octopush, OctopushNotification, OctopushAction;

/**
 *  Enumeración usada para indicar el tipo de presentación de la notificación.
 *  Según el orden indicado en la enumeración tendra prioridad al presentarse, sólo
 *  presentando una a la vez.
 */
typedef NS_OPTIONS(NSUInteger, OctopushNotificationPresentOptions) {
    /*
     * Tipo de notificación nativa.
     */
    OctopushNotificationPresentNative = (1 << 0),
    
    /**
     * Tipo de notificación de tipo UIAlertController.
     */
    OctopushNotificationPresentAlert = (1 << 1),
    
    /**
     * Tipo de notificación personalizada.
     */
    OctopushNotificationPresentCustom = (1 << 2),
    
    /**
     * Tipo de notificación con sonido.
     */
    OctopushNotificationPresentSound = (1 << 3),
    
    /**
     * Tipo de notificación que mostrara el número de distintivos.
     */
    OctopushNotificationPresentBadge = (1 << 4)
};

/**
 *  Enumeración usada para indicar el tipo del notifiación silenciosa.
 */
typedef NS_ENUM(NSUInteger, OctopushSilentResultType) {
    /**
     * Tipo de notificación sileciosa con datos.
     */
    OctopushSilentResultNewData,
    
    /**
     * Tipo de notificación sileciosa con sin datos.
     */
    OctopushSilentResultNoData,
    
    /**
     * Tipo de notificación sileciosa fallida.
     */
    OctopushSilentResultFailed
};

/**
 *  OctopushDelegate contiene las propiedades correspondientes al contenido del
 *  delegado de Octopush.
 */
@interface OctopushDelegate : NSObject

@end

@protocol OctopushNotificationDelegate <NSObject>

@optional

#pragma mark - Register notifications

/**
 *  Método que se llama al registrar el dispositivo en Octopush.
 *
 *  @param octopush         Clase Octopush.
 *  @param deviceIdentifier identificador único del dispositivo.
 *  @param deviceToken      Id de la notificación.
 */
- (void) octopush:(Octopush *) octopush didRegisterWithDeviceIdentifier:(NSString *) deviceIdentifier deviceToken:(NSString *) deviceToken;

/**
 *  Método que se llama al fallar el registro del dispositivo.
 *
 *  @param octopush Clase Octopush.
 *  @param error    Descripción del error.
 */
- (void) octopush:(Octopush *) octopush didFailToRegisterWithError:(NSError *) error;

/**
 *  Método que se llama al desregistrar el dispositivo de Octopush.
 *
 *  @param octopush Clase Octopush.
 */
- (void) didUnregisterFromOctopush:(Octopush *) octopush;

/**
 *  Método que se llama al fallar al desregistrar el dispositivo de Octopush.
 *
 *  @param octopush Clase Octopush.
 *  @param error    Descripción del error.
 */
- (void) octopush:(Octopush *) octopush didFailToUnregisterWithError:(NSError *) error;

#pragma mark - Register actions

/**
 *  Metodo para registrar la acción de la notificación.
 *
 *  @param octopush       Clase Octopush.
 *  @param action Objeto OctopushAction.
 *
 *  @return Objeto OctopushAction
 */
- (OctopushAction *)octopush:(Octopush *)octopush willRegisterAction:(NSString *) action;

#pragma mark - Handle notifications

/**
 *
 *  Método que se llama para presentar una notificación estando la aplicacion en primer plano. En este método se debe controlar el modo de visualización de la notificación
 *
 *  @param octopush             Clase Octopush.
 *  @param octopushNotification Contiene los datos de la notificacíon ya normalizada.
 *
 */
- (void) octopush:(Octopush *) octopush didPresentNotification:(OctopushNotification *) octopushNotification withCompletionHandler:(void (^) (OctopushNotificationPresentOptions presentOptions))completionHandler;

/**
 *  Método que se llama el recibir una notificación silenciosa. Es obligatorio llamar al bloque "completionHandler" el tratamiento
 *
 *  @param octopush             Clase Octopush.
 *  @param octopushNotification Contiene los datos de la notificacíon ya normalizada.
 *
 */
- (void) octopush:(Octopush *) octopush didReceiveSilentNotification:(OctopushNotification *) octopushNotification withCompletionHandler:(void (^) (OctopushSilentResultType resultType))completionHandler;

/**
 *  Método que se llama al pulsar una acción de la notificación (Botones o la propia notificación). Es obligatorio llamar al bloque "completionHandler" el tratamiento
 *
 *  @param octopush             Clase Octopush.
 *  @param octopushNotification Contiene los datos de la notificacíon ya normalizada.
 */
- (void) octopush:(Octopush *) octopush handleActionFromNotification:(OctopushNotification *) octopushNotification withCompletionHandler:(void (^)())completionHandler;

@end
