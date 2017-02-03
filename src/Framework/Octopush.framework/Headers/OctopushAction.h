//  OctopushAction
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>

@class OctopushAction;

/**
 *  Enumeración usada para indicar el tipo de opción de la acción.
 */
typedef NS_OPTIONS(NSUInteger, OctopushActionOptions) {
    
    /**
     * Requiere un desbloqueo antes de realizar una acción.
     */
	OctopushActionOptionsAuthenticationRequired = (1 << 0),
	
    /**
     * Se indica la acción como destructiva.
     */
	OctopushActionOptionsDestructive = (1 << 1),
	
    /**
     * Se indica la acción en primer plano.
     */
	OctopushActionOptionsForeground = (1 << 2),
};

/**
 *  Bloque de ejecución cuando se completa la ejecución de la acción.
 *
 *  @param object Objeto a devolver cuando se completa la ejeción de la acción.
 *  @param error Objeto del error.
 */
typedef void (^OctopushActionCompletion) (id object, NSError *error);

/**
 *  Bloque de ejecución cuando se ejecuta la acción.
 *
 *  @param action Acción de la notificación
 *  @param completionAction Bloque de ejecución cuando se completa la ejecución de la acción
 */
typedef void (^OctopushActionExecute) (OctopushAction *action, OctopushActionCompletion completionAction);

/**
 *  OctopushAction contiene las propiedades correspondientes para la personalización
 *  de una acción.
 */
@interface OctopushAction : NSObject

/**
 *  Inicialización del botón con su identificador.
 */
+ (instancetype) initializeWithIdentifier:(NSString *) identifier;

/**
 *  Indica el identificador del botón.
 */
@property (nonatomic, readonly) NSString *identifier;

/**
 *  Indica las opciones de la accion del botón
 */
@property (nonatomic, assign) OctopushActionOptions actionOptions;

/**
 *  Bloque usado para ejecutar la acción del botón
 */
@property (nonatomic, copy) OctopushActionExecute actionExecute;

@end
