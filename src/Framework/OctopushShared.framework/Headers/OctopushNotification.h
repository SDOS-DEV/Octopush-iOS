//  OctopushNotification
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>

/**
 *  Enumeración usada para indicar el tipo multimedia de la notificación.
 */
typedef NS_ENUM(NSUInteger, MediaType) {
    MediaTypeUnknown,
    MediaTypeImage,
    MediaTypeGif,
    MediaTypeVideo
};

/**
 * Esta clase es una representación del objeto devuelto por una notificación.
 * En ella podemos encontrar los atributos genéricos y especiales de cualquier tipo de notificación
 */
@interface OctopushNotification : NSObject

/**
 * Idenfificador de la notificacion
 */
@property (nonatomic, strong) NSString *idPush;

/**
 * Mensaje devuelto en la notificación.
 */

@property (nonatomic, strong) NSString *alert;

/**
 * Número de "notificaciones pendientes" de la notificación
 */
@property (nonatomic, strong) NSString *badge;

/**
 * Sonido que debe reproducir la aplicación con la llegada de la notificación
 */
@property (nonatomic, strong) NSString *sound;

/**
 * Indica si es una notificación silenciosa
 */
@property (nonatomic, strong) NSNumber *content_available;

/**
 * Parametros especiales que se envián en la notificación.
 */
@property (nonatomic, strong) NSDictionary *octopushParams;

/**
 *  Id del mensaje rich asociado a la notificación.
 */
@property (readonly, nonatomic, strong) NSString *idRich;

/**
 *  Titulo devuelto en la notificación.
 */
@property (nonatomic, strong) NSString *title;

/**
 * Subtitulo devuelto en la notificación.
 */
@property (nonatomic, strong) NSString *subtitle;

/**
 * Indica si es una notificación extendida (0 indica que no lo es , 1 indica que si lo es).
 */
@property (nonatomic, strong) NSNumber *mutable_content;

/**
 * Url de mutimedia devuelto en la notificación (Deberá ser obligatoriamente https://).
 */
@property (nonatomic, strong) NSString *mediaUrl;

/**
 * Tipo de mutimedia devuelto en la notificación (image, video o gif).
 */
@property (nonatomic, assign) MediaType mediaType;

/**
 *  Categoria devuelta en la notificación.
 */
@property (nonatomic, strong) NSString *category;

/**
 *  Acción por defecto de la notificación.
 */
@property (nonatomic, strong) NSString *defaultAction;

/**
 *  Acción la notificación.
 */
@property (nonatomic, strong) NSString *action;

/**
 *  Contiene todos los datos de la notificación
 */
@property (nonatomic, strong) NSDictionary *rawNotification;


@end
