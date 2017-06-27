//
//  RichNotificationDetailViewController.h
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Octopush/Octopush.h>
#import "OctopushBaseViewController.h"

@interface RichNotificationDetailViewController : OctopushBaseViewController

@property (strong, nonatomic) OctopushMensajeRich *mensajeRich;

@end
