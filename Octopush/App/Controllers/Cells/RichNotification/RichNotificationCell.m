//
//  RichNotificationCell.m
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "RichNotificationCell.h"
#import "UIColor+OAIAdditions.h"
#import "Constants.h"

@interface RichNotificationCell ()

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgState;
@property (weak, nonatomic) IBOutlet UIView *viewSeparator;

@end

@implementation RichNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self loadStyle];
}

- (void) loadStyle{
    self.lbTitle.textColor = [UIColor blackColor];
    self.lbTitle.font = [UIFont fontWithName:FONT_BOLD size:16];
    
    self.lbSubtitle.textColor = [UIColor oai_darkNavyBlue60Color];
    self.lbSubtitle.font = [UIFont fontWithName:FONT_REGULAR size:14];
    
    self.imgState.image = [UIImage imageNamed:@"images.bundle/notificacionNoLeida.png"];
    
    self.viewSeparator.backgroundColor = [UIColor oai_darkNavyBlue40Color];
}

- (void) loadCell{
    self.lbTitle.text = self.mensajeRich.contenidoMensajeRich.titulo;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"dd.MM.yyyy";
    
    self.lbSubtitle.text = [NSString stringWithFormat:@"%@ - %@", [dateFormat stringFromDate:self.mensajeRich.fechaInicioVigencia], [dateFormat stringFromDate:self.mensajeRich.fechaFinVigencia]];
    
    if ([self.mensajeRich.contenidoMensajeRich.leido boolValue]) {
        self.imgState.alpha = 0;
        self.lbTitle.textColor = [UIColor oai_darkNavyBlue60Color];
    } else {
        self.imgState.alpha = 1;
        self.lbTitle.textColor = [UIColor blackColor];
    }
}

- (void)prepareForReuse {
    self.imgState.alpha = 1;
}

@end
