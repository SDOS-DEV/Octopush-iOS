//  OctopushFiltroRich
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import <Foundation/Foundation.h>

/**
 *  FiltroRich contiene todos los parámetros por los que se pueden filtrar los mensajes rich
 */
@interface OctopushFiltroRich : NSObject

/**
 *  BOOL que indica si se envió una push asociada al mensaje rich
 */
@property (nonatomic, strong) NSNumber *pushAsociada;

/**
 *  Listado de identificadores de mensajes rich
 */
@property (nonatomic, strong) NSArray *listadoIdsRich;

/**
 *  BOOL que indica si el mensaje rich esta caducado
 */
@property (nonatomic, strong) NSNumber *caducada;

/**
 *  BOOL que indica si el mensaje esta leído o no
 */
@property (nonatomic, strong) NSNumber *leido;

/**
 *  BOOL que indica si el mensaje esta actualmente en el periodo de vigencia
 */
@property (nonatomic, strong) NSNumber *vigente;

@end
