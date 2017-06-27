//
//  OctopushSegmentsViewController.m
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 26/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "OctopushSegmentsViewController.h"
#import <Octopush/Octopush.h>
#import "SegmentCell.h"
#import "UIColor+OAIAdditions.h"
#import "Constants.h"
@import IQKeyboardManager;

@interface OctopushSegmentsViewController () <SegmentCellDelegate>

@property (strong, nonatomic) NSArray *arraySegments;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OctopushSegmentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = [NSLocalizedString(@"dashboard_segmentos", nil) uppercaseString];
    
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([SegmentCell class]) bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:SegmentCellIdentifier];
    
    [self loadStyle];
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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"comun_guardar", nil) style:UIBarButtonItemStylePlain target:self action:@selector(actionSaveSegments:)];
}

- (void) loadData {
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView startAnimating];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indicatorView.frame.size.width, indicatorView.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:indicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    __weak typeof(self) weakSelf = self;
    
    [Octopush getSegmentsWithSuccessBlock:^(NSArray *array) {
        weakSelf.arraySegments = [array copy];
        [weakSelf.tableView reloadData];
        [indicatorView stopAnimating];
        weakSelf.navigationItem.rightBarButtonItem = nil;
        [weakSelf loadStyle];
    } failure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_error", nil) message:error.description preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
        [indicatorView stopAnimating];
        weakSelf.navigationItem.rightBarButtonItem = nil;
        [weakSelf loadStyle];
    }];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arraySegments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SegmentCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:SegmentCellIdentifier forIndexPath:indexPath];
    cell.segment = self.arraySegments[indexPath.row];
    cell.delegate = self;
    [cell loadCell];
    
    return cell;
}

#pragma mark - SegmentCellDelegate

- (UIViewController *) presentOptionsFromsegmentCell:(SegmentCell *) segmentCell {
    return self;
}

- (void) segmentCell:(SegmentCell *) segmentCell changeValue:(id) newValue {
    
}

#pragma mark - Actions

- (void) actionBack:(id) sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) actionSaveSegments:(id) sender {
    [[IQKeyboardManager sharedManager] resignFirstResponder];
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [indicatorView startAnimating];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, indicatorView.frame.size.width, indicatorView.frame.size.height)];
    view.backgroundColor = [UIColor clearColor];
    [view addSubview:indicatorView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    __weak typeof(self) weakSelf = self;
    
    [Octopush setSegments:self.arraySegments success:^(NSArray *array) {
        [indicatorView stopAnimating];
        weakSelf.navigationItem.rightBarButtonItem = nil;
        [weakSelf loadStyle];
    } failure:^(NSError *error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"comun_error", nil) message:error.description preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"comun_cerrar", nil) style:UIAlertActionStyleCancel handler:nil]];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
        [indicatorView stopAnimating];
        weakSelf.navigationItem.rightBarButtonItem = nil;
        [weakSelf loadStyle];
    }];
}

@end
