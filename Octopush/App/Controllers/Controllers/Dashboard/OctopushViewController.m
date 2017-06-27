//  Octopush
//
//  Copyright (c) 2017 SDOS. All rights reserved.
//  Librería de notificaciones push desarrollada por SDOS
//
//  Para cualquier duda o consulta técnica sobre el proceso de integración
//  puedes encontrar toda la información en:
//  http://docs.octopush.me/

#import "OctopushViewController.h"
#import "MALoggingViewController.h"
#import <Octopush/Octopush.h>
#import "UIColor+OAIAdditions.h"
#import "Constants.h"
@import IQKeyboardManager;
#import "UIImage+Base.h"
#import "UIColor+Base.h"

@interface OctopushViewController ()

@property (weak, nonatomic) IBOutlet UIView *viewContentTop;
@property (weak, nonatomic) IBOutlet UIImageView *imgDashboard;
@property (weak, nonatomic) IBOutlet UILabel *lbNotifications;
@property (weak, nonatomic) IBOutlet UILabel *lbUser;
@property (weak, nonatomic) IBOutlet UITextField *tfUser;
@property (weak, nonatomic) IBOutlet UIView *viewSeparatorUser;
@property (weak, nonatomic) IBOutlet UIButton *btnHelp;
@property (weak, nonatomic) IBOutlet UIButton *btnDeactivate;
@property (weak, nonatomic) IBOutlet UIView *viewSeparatorDeactivate;
@property (weak, nonatomic) IBOutlet UIButton *btnActivate;
@property (weak, nonatomic) IBOutlet UIView *viewSeparatorActivate;
@property (weak, nonatomic) IBOutlet UIButton *btnRegisterLocation;
@property (weak, nonatomic) IBOutlet UIButton *btnSegments;
@property (weak, nonatomic) IBOutlet UIButton *btnRichNotifications;
@end

@implementation OctopushViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self loadStyle];
    [self loadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Style

- (void) loadStyle {
    
    self.viewContentTop.layer.shadowColor = [UIColor blackColor].CGColor;
    self.viewContentTop.layer.shadowOffset = CGSizeMake(0, 4);
    self.viewContentTop.layer.masksToBounds = NO;
    self.viewContentTop.layer.shadowRadius = 5;
    self.viewContentTop.layer.shadowOpacity = 0.24;
    
    self.imgDashboard.image = [UIImage imageNamed:@"images.bundle/octopushLogoHorizontal.png"];
    
    self.lbNotifications.text = NSLocalizedString(@"dashboard_notificaciones", nil);
    self.lbNotifications.textColor = [UIColor oai_redPinkColor];
    self.lbNotifications.font = [UIFont fontWithName:FONT_BOLD size:14];
    
    self.lbUser.text = NSLocalizedString(@"dashboard_usuario", nil);
    self.lbUser.textColor = [UIColor oai_darkNavyBlue60Color];
    self.lbUser.font = [UIFont fontWithName:FONT_MEDIUM size:12];
    
    self.tfUser.placeholder = NSLocalizedString(@"dashboard_placeholder_usuario", nil);
    self.tfUser.textColor = [UIColor oai_darkNavyBlue60Color];
    self.tfUser.font = [UIFont fontWithName:FONT_REGULAR size:16];
    self.viewSeparatorUser.backgroundColor = [UIColor oai_darkNavyBlue60Color];
    
    [self.btnHelp setImage:[UIImage imageNamed:@"images.bundle/help.png"] forState:UIControlStateNormal];
    
    [self.btnActivate setTitle:NSLocalizedString(@"dashboard_activar", nil) forState:UIControlStateNormal];
    [self.btnActivate setTitleColor:[UIColor oai_redPinkColor] forState:UIControlStateNormal];
    [self.btnActivate setTitleColor:[[UIColor oai_redPinkColor] darkerColor] forState:UIControlStateHighlighted];
    self.btnActivate.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:16];
    self.viewSeparatorActivate.backgroundColor = [UIColor oai_redPinkColor];
    
    [self.btnDeactivate setTitle:NSLocalizedString(@"dashboard_desactivar", nil) forState:UIControlStateNormal];
    [self.btnDeactivate setTitleColor:[UIColor oai_redPinkColor] forState:UIControlStateNormal];
    [self.btnDeactivate setTitleColor:[[UIColor oai_redPinkColor] darkerColor] forState:UIControlStateHighlighted];
    self.btnDeactivate.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:16];
    self.viewSeparatorDeactivate.backgroundColor = [UIColor oai_redPinkColor];
    
    [self.btnRegisterLocation setTitle:NSLocalizedString(@"dashboard_registro_localizacion", nil) forState:UIControlStateNormal];
    [self.btnRegisterLocation setImage:[UIImage imageNamed:@"images.bundle/localizador.png"] forState:UIControlStateNormal];
    [self.btnRegisterLocation setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnRegisterLocation.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:16];
    [self.btnRegisterLocation setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 20)];
    [self.btnRegisterLocation setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 20)];
    [self.btnRegisterLocation setBackgroundImage:[UIImage imageWithColor:[UIColor oai_lipstickColor]] forState:UIControlStateNormal];
    [self.btnRegisterLocation setBackgroundImage:[UIImage imageWithColor:[[UIColor oai_lipstickColor] darkerColor]] forState:UIControlStateHighlighted];
    
    [self.btnSegments setTitle:NSLocalizedString(@"dashboard_segmentos", nil) forState:UIControlStateNormal];
    [self.btnSegments setImage:[UIImage imageNamed:@"images.bundle/segmentos.png"] forState:UIControlStateNormal];
    [self.btnSegments setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnSegments.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:16];
    [self.btnSegments setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 20)];
    [self.btnSegments setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 20)];
    [self.btnSegments setBackgroundImage:[UIImage imageWithColor:[UIColor oai_redPinkColor]] forState:UIControlStateNormal];
    [self.btnSegments setBackgroundImage:[UIImage imageWithColor:[[UIColor oai_redPinkColor] darkerColor]] forState:UIControlStateHighlighted];
    
    [self.btnRichNotifications setTitle:NSLocalizedString(@"dashboard_notificaciones_tich", nil) forState:UIControlStateNormal];
    [self.btnRichNotifications setImage:[UIImage imageNamed:@"images.bundle/notificaciones.png"] forState:UIControlStateNormal];
    [self.btnRichNotifications setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnRichNotifications.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:16];
    [self.btnRichNotifications setImageEdgeInsets:UIEdgeInsetsMake(0, 30, 0, 20)];
    [self.btnRichNotifications setTitleEdgeInsets:UIEdgeInsetsMake(0, 40, 0, 20)];
    [self.btnRichNotifications setBackgroundImage:[UIImage imageWithColor:[UIColor oai_redPink94Color]] forState:UIControlStateNormal];
    [self.btnRichNotifications setBackgroundImage:[UIImage imageWithColor:[[UIColor oai_redPink94Color] darkerColor]] forState:UIControlStateHighlighted];
}

- (void) loadData {
    self.tfUser.text = [Octopush shared].user;
}

#pragma mark - Actions

- (IBAction)actionHelp:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_informacion", nil) message:NSLocalizedString(@"dashboard_info_usuario", nil) preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)actionDeactivate:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    [Octopush unregisterDevice];
}

- (IBAction)actionActivate:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    NSString *user = nil;
    if (![self.tfUser.text isEqualToString:@""]) {
        user = self.tfUser.text;
    }
    [Octopush shared].user = user;
    [Octopush registerDevice];
}

- (IBAction)actionRegisterLocation:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    [Octopush forceRegisterLocation];
}

- (IBAction)actionSegments:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
}

- (IBAction)actionRichNotifications:(id)sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
}

@end
