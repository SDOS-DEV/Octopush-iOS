//
//  MensajeRichVO.h
//  OctopusStaticLib
//  OctopushMensajeRich
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>
#import "OctopushContenidoMensajeRich.h"

/**
 *  MensajeRich contiene la información correspondientes a un mensaje Rich
 */

@interface OctopushMensajeRich : NSObject

/**
 *  BOOL que indica si se envió una push asociada al mensaje rich
 */
@property (nonatomic, strong) NSNumber *pushAsociada;

/**
 *  Id del mensaje rich
 */
@property (nonatomic, strong) NSString *idRich;

/**
 *  Contenido del mensaje rich
 */
@property (nonatomic, strong) OctopushContenidoMensajeRich *contenidoMensajeRich;

/**
 *  Indica la fecha de inicio de vigencia del mensaje rich
 */
@property (nonatomic, strong) NSDate *fechaInicioVigencia;

/**
 *  Indica la fecha de fin de vigencia del mensaje rich
 */
@property (nonatomic, strong) NSDate *fechaFinVigencia;

/**
 * Parametros especiales que se envián en el mensaje rich.
 */
@property (nonatomic, strong) NSDictionary *richParams;

@end
