//
//  OctopushSegment.h
//  OctopusStaticLib
//
//  Creado por S·dos día 17/8/15.
//  Copyright 2015 iMac2. Todos los derechos reservados.
//  Archivo creado usando la Plantilla WSClass por S·dos (http://www.s-dos.es/\)
//  Se otorga permiso para hacer cualquier uso, comercial / no comercial con este archivo, aparte de la eliminación de la línea / URL anterior
//  Librerías necesarias: JSON, Reachability
//  Framework necesarios: SystemConfiguration.framework

/**
 *  Enumeración usada para indicar el tipo del segmento
 */
typedef NS_ENUM(NSUInteger, OctopushSegmentType) {
    /**
     *  Segmento de tipo texto
     */
    OctopushSegmentTypeText,
    
    /**
     *  Segmento de tipo numérico
     */
    OctopushSegmentTypeNum,
    
    /**
     *  Segmento de tipo opción
     */
    OctopushSegmentTypeOption,
    
    /**
     *  Segmento de tipo fecha
     */
    OctopushSegmentTypeDate,
    
    /**
     *  Segmento de tipo booleano
     
     */
    OctopushSegmentTypeBool
};

@interface OctopushSegment : NSObject

/**
 *  Id del segmento
 */
@property (nonatomic, strong) NSString *segmentId;

/**
 *  Nombre del segmento
 */
@property (nonatomic, strong) NSString *name;

/**
 *  Tipo del segmento
 */
@property (nonatomic, assign) OctopushSegmentType segmentType;

/**
 *  Valor para los segmentos de tipo texto
 */
@property (nonatomic, strong) NSString *textValue;

/**
 *  Valor para los segmentos de tipo fecha
 */
@property (nonatomic, strong) NSDate *dateValue;

/**
 *  Valor para los segmentos de tipo numérico
 */
@property (nonatomic, strong) NSNumber *numericValue;

/**
 *  Valor para los segmentos de tipo lógico
 */
@property (nonatomic, strong) NSNumber *booleanValue;

/**
 *  Valores para los segmentos de tipo opción
 */
@property (nonatomic, strong) NSArray *options;

@end
