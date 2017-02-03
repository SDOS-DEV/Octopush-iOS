//  Octopush
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>
#import "OctopushFiltroRich.h"
#import "OctopushMensajeRich.h"
#import "OctopushContenidoMensajeRich.h"
#import "OctopushSegment.h"
#import "OctopushSegmentOption.h"
#import "OctopushSegmentsController.h"
#import "OctopushDelegate.h"
#import "OctopushAction.h"

@class OctopushNotification;

/**
 *  Bloque de ejecución con una salida correcta
 *
 *  @param array Lista de objetos de tipo OctopushSegment que devuelve la ejecución del método
 */
typedef void (^OctopushSegmentsSuccessBlock)(NSArray *array);

/**
 *  Bloque de ejecución con una salida correcta
 *
 *  @param array Lista de objetos de tipo MensajeRich que devuelve la ejecución del método
 */
typedef void (^OctopushListMessageRichSuccessBlock)(NSMutableArray *array);

/**
 *  Bloque de ejecución con una salida correcta
 *
 *  @param mensajeRich Objeto de tipo MensajeRich que devuelve la ejecución del método
 */
typedef void (^OctopushMessageSuccessBlock)(OctopushMensajeRich *mensajeRich);

/**
 *  Bloque de ejecución con una salida correcta
 *
 *  @param success Objeto de tipo MensajeRich que devuelve la ejecución del método
 */
typedef void (^OctopushSuccessBlock)(BOOL success);

/**
 *  Bloque de ejecución con una salida incorrecta
 *
 *  @param error Error producido durante la ejecución del método
 */
typedef void (^OctopushFailureBlock)(NSError *error);


/**
 * Esta clase es la encargada de manejar todas las acciones que podemos realizar en Octopush.
 * Es la clase central donde personalizaremos las configuraciones y realizaremos los registros en Octopush.
 * Es una clase de instanciación única y en ningún momento deberemos llamar a su método init.
 * Para instanciarla siempre usaremos el método shared.
 */

@interface Octopush : NSObject

#pragma mark - Configuration

/**
 * Texto para el botón cerrar que aparece en las notificaciones con estilo OctopushNotificationPresentAlert. Por defecto "Cerrar"
 */
@property (nonatomic, copy) NSString *notificationCloseText;

/**
 *  Delegado de la clase OctopushNotification.
 */
@property (nonatomic, weak) id<OctopushNotificationDelegate> delegate;

/**
 * Usuario que se registrará junto al dispositivo.
 * Por defecto el usuario estará vacio (usuario anónimo)
 */
@property (nonatomic, copy) NSString *user;

/**
 * Identificador de notificaciones (Formato Texto). Este parametro se carga durante la concesión de permisos para que la aplicación pueda recivir notificaciones. Apple es el encargado de cargarlo.
 */
@property (nonatomic, readonly) NSString *deviceToken;

/**
 * Identificador de notificaciones (Formato binario). Este parametro se carga durante la concesión de permisos para que la aplicación pueda recivir notificaciones. Apple es el encargado de cargarlo.
 */
@property (nonatomic, readonly) NSData *deviceTokenData;

/**
 *  Identificador del dispositivo
 */
@property (nonatomic, readonly) NSString *deviceIdentifier;

/**
 * Parámetro que indica si queremos registrar la localización del dispositivo.
 * Dicha localización la realizará cada vez que el usuario abra la aplicación, en ciclos de tiempo definido en el parámetro timeRegisterLocation.
 * Por defecto su valor es FALSE
 */
@property (nonatomic) BOOL registerLocation;

/**
 * Parámetro que indica cuanto tiempo espera la aplicación hasta el próximo registro de localización.
 * Por defecto su valor es 12 Horas.
 */
@property (nonatomic) NSTimeInterval timeRegisterLocation;

/**
 * Parámetro que indica si durante la recepción de notificaciones en primer plano se debe reproducir el sonido. Octopush se encargará de reproducir el sonido incluido en la notificación.
 * Por defecto su valor es TRUE.
 */
@property (nonatomic) BOOL playSound;

/**
 * Parámetro que indica si durante la recepción de notificaciones limpiaremos el centro de notificaciones.
 * Esta acción se realiza durante la ejecución del método + (OctopushNotification *) getNotificacion:(NSDictionary *) dictionary;
 * Por defecto su valor es FALSE.
 */
@property (nonatomic) BOOL clearNotificationCenterToRead;

/**
 *  Lista de objetos de tipo OctopushPreferencia con las preferencias del usuario.
 */
@property (nonatomic, strong) NSArray *userPreferences;

/**
 *  Lista de objetos de tipo OctopushSegment con los segment del usuario.
 */
@property (nonatomic, strong) NSArray *userSegments;

#pragma mark - Register and utils

/**
 * Devuelve la instancia de la aplicación.
 * Este método es el único constructor válido de la clase.
 */
+ (Octopush*) shared;

/**
 * Método para registrar el dispositivo en Octopush con la configuración actual.
 */
+ (void) registerDevice;

/**
 * Método que da de baja un dispositivo de Octopush.
 * Este método debe ser ejecutado cuando sea necesario borrar complemtamente el dispositivo de Octopush.
 */
+ (void) unregisterDevice;

/**
 * Método para registrar la localización del usuario en Octopush, esperando el intervalo de tiempo almacenado en configuración.
 * Este método sólo debe ser ejecutado en el método donde la aplicación cambia su estado a activa (- (void)applicationDidBecomeActive:(UIApplication *)application).
 */
+ (void) registerLocation;

/**
 * Método para forzar el registro de la localización del usuario en Octopush, reiniciando el tiempo de espera para la próxima actualización de la localización.
 * Este método se ejecutará cuando neesitemos actualizar manualmente la localización del dispositivo.
 */
+ (void) forceRegisterLocation;

/**
 * Método para modificar el número de notificaciones pendientes de la aplicación.
 * @param badge Número a mostrar en el globo del icono.
 */
+ (void) setBadgeNumber:(NSInteger) badge;

/**
 *  Devuelve la versión actual de la librería
 *
 *  @return Valor actual de la versión de la librería
 */
+ (NSString *) getOctopushVersion;

/**
 *  Muestra por la consola información util para el desarrollador referente a los datos de la librería
 */
+ (void) getInfo;

#pragma mark - Handle notifications

/**
 *  Método encargado de manejar la acción del botón de la notificación y su accion por defecto.
 *
 *  @param notification Contiene los datos de la notificación.
 */
+ (void) handleNotification:(OctopushNotification *)notification actionCompletion:(OctopushActionCompletion) actionCompletion;

/**
 *  Método encargado de comprobar si Octopush puede manejar la acción del botón.
 *
 *  @param notification Contiene los datos de la notificación.
 */
+ (BOOL) canHandleNotification:(OctopushNotification *) notification;

#pragma mark - RichPush

/**
 *  Método encargado de devolver un mensaje rich a partir de su identificador. La llamada a este método marcará dicho mensaje como leido.
 *
 *  @param idRich  identificador del mensaje rich
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método.
 */
+ (void) getRichPush:(NSString *) idRich success:(OctopushMessageSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de devolver un mensaje rich a partir de su identificador.
 *
 *  @param idRich  identificador del mensaje rich
 *  @param markAsRead indica si al recuperar el mensaje rich, éste se mercara como leido o no.
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método.
 */
+ (void) getRichPush:(NSString *) idRich markAsRead:(BOOL) markAsRead success:(OctopushMessageSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de devolver un listado de mensajes rich asociados a un dispositivo a partir de un filtro. El filtro no es obligatorio.
 *  Si no se envía ningún filtro, el método devolverá todos los mensajes sin ninguna restricción
 *
 *  @param filtroRich Filtros para acotar los mensajes que se devuelven
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método.
 */
+ (void) getRichPushDeviceWithFilter:(OctopushFiltroRich *) filtroRich success:(OctopushListMessageRichSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de devolver un listado de mensajes rich asociados a un usuario a partir de un filtro. El filtro no es obligatorio.
 *  Si no se envía ningún filtro, el método devolverá todos los mensajes sin ninguna restricción.
 *  Si no existe ningún usuario, el método devolverá un error.
 *
 *  @param filtroRich Filtros para acotar los mensajes que se devuelven
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método.
 */
+ (void) getRichPushUserWithFilter:(OctopushFiltroRich *) filtroRich success:(OctopushListMessageRichSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de devolver un listado de mensajes rich a partir de un filtro. Si se está registrado con un usuario,
 *  el método solicitará los mensajes rich de ese usuario. En caso contrario, solicitará los mensajes rich del dispositivo. El filtro no es obligatorio.
 *  Si no se envía ningún filtro, el método devolverá todos los mensajes sin ninguna restricción
 *
 *  @param filtroRich Filtros para acotar los mensajes que se devuelven
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método.
 */
+ (void) getRichPushWithFilter:(OctopushFiltroRich *) filtroRich success:(OctopushListMessageRichSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de modificar el estado de un mensaje rich.
 *
 *  @param idRich  identificador del mensaje rich
 *  @param markAsRead indica si se marcará como leido o no leido el mensaje push
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método.
 */
+ (void) setRichPush:(NSString *) idRich markAsRead:(BOOL) markAsRead success:(OctopushSuccessBlock) success failure:(OctopushFailureBlock) failure;

#pragma mark - Segments

/**
 *  Método encargado de devolver un listado de segmentos. Si se está registrado con un usuario,
 *  el método solicitará los segmentos de ese usuario. En caso contrario, solicitará los segmentos del dispositivo.
 *
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método
 */
+ (void) getSegmentsWithSuccessBlock:(OctopushSegmentsSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de devolver el segmento solicitado. Si se está registrado con un usuario,
 *  el método solicitará los segmentos de ese usuario. En caso contrario, solicitará los segmentos del dispositivo.
 *
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método
 */
+ (void) getSegment:(NSString *)segmentId success:(OctopushSegmentsSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de modificar los segmentos. Sólo se conservan en el servidor los valores de los segmentos que se envíen con este método, si no se incluye un segment que tenía algún valor se elimina dicho valor en el servidor.
 *
 *  @param segments Lista de objetos de tipo OctopushSegment a modificar.
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método
 */
+ (void) setSegments:(NSArray *)segments success:(OctopushSegmentsSuccessBlock) success failure:(OctopushFailureBlock) failure;

/**
 *  Método encargado de actualizar los segmentos. Sólo se actualizarán en el servidor los valores de los segmentos que se envíen con este método, si no se incluye un segment que tenía algún valor se conserva dicho valor en el servidor.
 *
 *  @param segments Lista de objetos de tipo OctopushSegment a actualizar.
 *  @param success Bloque que se ejecuta para una salida correcta del método. Contiene el array con los Objetos devueltos
 *  @param failure Bloque que se ejecuta para una salida incorrecta del método. Contiene el error devuelto por el método
 */
+ (void) updateSegments:(NSArray *)segments success:(OctopushSegmentsSuccessBlock) success failure:(OctopushFailureBlock) failure;


@end

