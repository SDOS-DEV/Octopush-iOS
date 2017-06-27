//
//  OctopushRichNotificationsViewController.m
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 26/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "OctopushRichNotificationsViewController.h"
#import <Octopush/Octopush.h>
#import "RichNotificationCell.h"
#import "UIColor+OAIAdditions.h"
#import "Constants.h"
#import "RichNotificationDetailViewController.h"

@interface OctopushRichNotificationsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *arrayRichPush;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OctopushRichNotificationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSLocalizedString(@"dashboard_notificaciones_tich", nil) uppercaseString];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([RichNotificationCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:RichNotificationCellIdentifier];
    
    [self loadStyle];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void) loadStyle {
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor oai_redPinkColor];
    [self.navigationController.navigationBar setTitleTextAttributes: @{
                                                            NSForegroundColorAttributeName: [UIColor whiteColor],
                                                            NSFontAttributeName: [UIFont fontWithName:FONT_REGULAR size:14]
                                                            }];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"images.bundle/atras.png"] style:UIBarButtonItemStylePlain target:self action:@selector(actionBack:)];
}

- (void) loadData {
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView startAnimating];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indicatorView.frame.size.width, indicatorView.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:indicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    __weak typeof(self) weakSelf = self;
    if ([Octopush shared].user != nil && ![[Octopush shared].user isEqualToString:@""]) {
        [Octopush getRichPushUserWithFilter:nil success:^(NSMutableArray *array) {
            weakSelf.arrayRichPush = [array copy];
            [weakSelf.tableView reloadData];
            [indicatorView stopAnimating];
            weakSelf.navigationItem.rightBarButtonItem = nil;
        } failure:^(NSError *error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_error", nil) message:error.description preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
            
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            [indicatorView stopAnimating];
            weakSelf.navigationItem.rightBarButtonItem = nil;
        }];
    } else {
        [Octopush getRichPushDeviceWithFilter:nil success:^(NSMutableArray *array) {
            weakSelf.arrayRichPush = [array copy];
            [weakSelf.tableView reloadData];
            [indicatorView stopAnimating];
            weakSelf.navigationItem.rightBarButtonItem = nil;
        } failure:^(NSError *error) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_error", nil) message:error.description preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
            
            [weakSelf presentViewController:alertController animated:YES completion:nil];
            [indicatorView stopAnimating];
            weakSelf.navigationItem.rightBarButtonItem = nil;
        }];
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayRichPush.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RichNotificationCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:RichNotificationCellIdentifier forIndexPath:indexPath];
    cell.mensajeRich = self.arrayRichPush[indexPath.row];
    [cell loadCell];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"SBToRichNotificationDetail" sender:self.arrayRichPush[indexPath.row]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SBToRichNotificationDetail"]) {
        RichNotificationDetailViewController *viewController = (RichNotificationDetailViewController *)segue.destinationViewController;
        viewController.mensajeRich = sender;
    }
}

#pragma mark - Actions

- (void) actionBack:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
