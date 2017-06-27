//
//  RichNotificationCell.h
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#define RichNotificationCellIdentifier @"RichNotificationCellIdentifier"

#import <UIKit/UIKit.h>
#import <Octopush/Octopush.h>

@interface RichNotificationCell : UITableViewCell

@property (strong, nonatomic) OctopushMensajeRich *mensajeRich;

/**
 *  Método donde se realiza la carga de los componentes de la celda.
 */
- (void) loadCell;

@end
