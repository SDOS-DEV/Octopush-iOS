//
//  RichNotificationDetailViewController.m
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "RichNotificationDetailViewController.h"
#import "UIColor+OAIAdditions.h"
#import "Constants.h"
@import WebKit;

@interface RichNotificationDetailViewController () <WKNavigationDelegate>

@property (strong, nonatomic) UIView *viewIndicator;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) WKWebView *wkWebView;
@property (weak, nonatomic) IBOutlet UIView *viewContent;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;

@end

@implementation RichNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.wkWebView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    self.wkWebView.navigationDelegate = self;
    [self.view addSubview:self.wkWebView];
    
    self.wkWebView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //Trailing
    NSLayoutConstraint *trailing =[NSLayoutConstraint
                                   constraintWithItem:self.wkWebView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.viewContent
                                   attribute:NSLayoutAttributeTrailing
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Leading
    
    NSLayoutConstraint *leading = [NSLayoutConstraint
                                   constraintWithItem:self.wkWebView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                   toItem:self.viewContent
                                   attribute:NSLayoutAttributeLeading
                                   multiplier:1.0f
                                   constant:0.f];
    
    //Bottom
    NSLayoutConstraint *bottom =[NSLayoutConstraint
                                 constraintWithItem:self.wkWebView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.viewContent
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1.0f
                                 constant:0.f];
    
    //Top
    NSLayoutConstraint *top =[NSLayoutConstraint
                                 constraintWithItem:self.wkWebView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:self.viewContent
                                 attribute:NSLayoutAttributeTop
                                 multiplier:1.0f
                                 constant:0.f];
    
    [self.view addConstraint:trailing];
    [self.view addConstraint:bottom];
    [self.view addConstraint:leading];
    [self.view addConstraint:top];
    
    [self loadStyle];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.activityIndicatorView stopAnimating];
    self.navigationItem.rightBarButtonItem = nil;
}

- (void) loadStyle {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor oai_redPinkColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                                       NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                       NSFontAttributeName: [UIFont fontWithName:FONT_REGULAR size:14]
                                                                       }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"images.bundle/atras.png"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack:)];
    
    self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.viewIndicator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.activityIndicatorView.frame.size.width, self.activityIndicatorView.frame.size.height)];
    self.viewIndicator.backgroundColor = [UIColor clearColor];
    [self.viewIndicator addSubview:self.activityIndicatorView];
    
    self.lbTitle.textColor = [UIColor blackColor];
    self.lbTitle.font = [UIFont fontWithName:FONT_BOLD size:20];
    
    self.lbDate.textColor = [UIColor oai_redPinkColor];
    self.lbDate.font = [UIFont fontWithName:FONT_REGULAR size:14];
    
    self.wkWebView.scrollView.bounces = NO;
}

- (void) loadData {
    self.title = self.mensajeRich.contenidoMensajeRich.titulo;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"dd.MM.yyyy";
    
    self.lbTitle.text = self.mensajeRich.contenidoMensajeRich.descripcion;
    
    self.lbDate.text = [NSString stringWithFormat:@"%@ - %@", [dateFormat stringFromDate:self.mensajeRich.fechaInicioVigencia], [dateFormat stringFromDate:self.mensajeRich.fechaFinVigencia]];
    
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.mensajeRich.contenidoMensajeRich.urlContenidoHtml]]];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.activityIndicatorView startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.viewIndicator];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.activityIndicatorView stopAnimating];
    self.navigationItem.rightBarButtonItem = nil;
    
    [Octopush setRichPush:self.mensajeRich.idRich markAsRead:YES success:nil failure:nil];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error {
    [self.activityIndicatorView stopAnimating];
    self.navigationItem.rightBarButtonItem = nil;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_error", nil) message:error.description preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Actions

- (void) actionBack:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
