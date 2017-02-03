//
//  OctopushSegmentsController.h
//  OctopusStaticLib
//
//  Created by S·dos on 18/6/15.
//  Copyright (c) 2015 iMac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OctopushSegmentsController : UIViewController

/**
 *  Título de la vista.
 */
@property (nonatomic, strong) NSString *titulo;

/**
 *  Color del texto del título de la vista.
 */
@property (nonatomic, strong) UIColor *colorTitulo;

/**
 *  Color de fondo de la barra superior.
 */
@property (nonatomic, strong) UIColor *colorFondoBarraSuperior;

/**
 *  Color de los botones de la barra superior.
 */
@property (nonatomic, strong) UIColor *colorBotonesBarraSuperior;

/**
 *  Botón izquierdo de la barra superior.
 */
@property (nonatomic, strong) UIBarButtonItem *botonIzquierdoBarraSuperior;

/**
 *  Color del texto del indicador de carga.
 */
@property (nonatomic, strong) UIColor *colorTextoIndicadorCarga;

/**
 *  Estilo del indicador de carga.
 */
@property (nonatomic, assign) UIActivityIndicatorViewStyle estiloIndicadorCarga;

/**
 *  Color de fondo de la vista.
 */
@property (nonatomic, strong) UIColor *colorFondo;

/**
 *  Color de fondo de las celdas de los segmentos.
 */
@property (nonatomic, strong) UIColor *colorFondoSegmento;

/**
 *  Color de los cursores de los campos de texto.
 */
@property (nonatomic, strong) UIColor *colorCursorCampoTexto;

/**
 *  Color de los separadores de los segmentos.
 */
@property (nonatomic, strong) UIColor *colorSeparadoresSegmento;

/**
 *  Color del texto del nombre de los segmentos.
 */
@property (nonatomic, strong) UIColor *colorNombreSegmento;

/**
 *  Color del texto de los valores de los segmentos.
 */
@property (nonatomic, strong) UIColor *colorValorSegmento;

/**
 *  Color de fondo del switch para segmentos de tipo booleano.
 */
@property (nonatomic, strong) UIColor *colorFondoSwitch;

/**
 *  Color de fondo del campo de texto para segmentos de tipo texto.
 */
@property (nonatomic, strong) UIColor *colorFondoCampoTexto;

/**
 *  Color del texto del campo de texto para segmentos de tipo texto.
 */
@property (nonatomic, strong) UIColor *colorTextoCampoTexto;

/**
 *  Color del placeholder del campo de texto para segmentos de tipo texto.
 */
@property (nonatomic, strong) UIColor *colorPlaceholderCampoTexto;

/**
 *  Color de fondo de los tags para segmentos de tipo texto.
 */
@property (nonatomic, strong) UIColor *colorFondoTag;

/**
 *  Color del texto de los tags para segmentos de tipo texto.
 */
@property (nonatomic, strong) UIColor *colorTextoTag;

/**
 *  Color del botón que permite borrar el valor de las segmentos de tipo fecha.
 */
@property (nonatomic, strong) UIColor *colorBotonBorrarFecha;

/**
 *  Color de fondo del selector de fecha para segmentos de tipo fecha.
 */
@property (nonatomic, strong) UIColor *colorFondoFecha;

/**
 *  Color de los check de las opciones seleccionadas para segmentos de tipo options.
 */
@property (nonatomic, strong) UIColor *colorCheckDatoTipificado;

@end
