//  OctopushSegmentOption
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

@interface OctopushSegmentOption : NSObject

/**
 *  Código de la opción
 */
@property (nonatomic, strong) NSString *code;

/**
 *  Nombre de la opción
 */
@property (nonatomic, strong) NSString *name;

/**
 *  BOOL que indica si la opción está seleccionada o no
 */
@property (nonatomic, strong) NSNumber *selected;

@end
