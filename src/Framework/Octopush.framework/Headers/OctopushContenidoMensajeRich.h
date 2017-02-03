//  OctopushContenidoMensajeRich
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>

/**
 *  ContenidoMensajeRich contiene las propiedades correspondientes al contenido de un mensaje Rich
 */
@interface OctopushContenidoMensajeRich : NSObject

/**
 *  Descripción corta del mensaje rich
 */
@property (nonatomic, strong) NSString *descripcion;

/**
 *  Idioma del mensaje rich
 */
@property (nonatomic, strong) NSString *idioma;

/**
 *  Título del mensaje rich
 */
@property (nonatomic, strong) NSString *titulo;

/**
 *  BOOL que indica si el mensaje esta leído o no
 */
@property (nonatomic, strong) NSNumber *leido;

/**
 *  URL con el contenido del mensaje rich
 */
@property (nonatomic, strong) NSString *urlContenidoHtml;

@end
