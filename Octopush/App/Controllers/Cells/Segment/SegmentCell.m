//
//  SegmentCell.m
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#import "SegmentCell.h"
#import "UIColor+OAIAdditions.h"
#import "Constants.h"
@import IQKeyboardManager;
@import IQActionSheetPickerView;

@interface SegmentCell () <UITextFieldDelegate, IQActionSheetPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfValue;
@property (weak, nonatomic) IBOutlet UIView *viewSeparator;

@end

@implementation SegmentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self loadStyle];
}

- (void) loadStyle{
    self.lbTitle.textColor = [UIColor oai_darkNavyBlue70Color];
    self.lbTitle.font = [UIFont fontWithName:FONT_BOLD size:14];
    
    self.tfValue.placeholder = NSLocalizedString(@"combo_selecciona_valor", nil);
    self.tfValue.textColor = [UIColor oai_darkNavyBlue60Color];
    self.tfValue.font = [UIFont fontWithName:FONT_REGULAR size:16];
    
    self.viewSeparator.backgroundColor = [UIColor oai_darkNavyBlue40Color];
}

- (void) loadCell{
    self.lbTitle.text = self.segment.name;
    switch (self.segment.segmentType) {
        case OctopushSegmentTypeNum:
            self.tfValue.text = [self.segment.numericValue stringValue];
            self.tfValue.keyboardType = UIKeyboardTypeDecimalPad;
            self.tfValue.rightView = nil;
            break;
        case OctopushSegmentTypeText:
            self.tfValue.text = self.segment.textValue;
            self.tfValue.keyboardType = UIKeyboardTypeDefault;
            self.tfValue.rightView = nil;
            break;
        case OctopushSegmentTypeOption:
        {
            NSMutableArray *array = [NSMutableArray array];
            for (OctopushSegmentOption *segmentOption in self.segment.options) {
                if ([segmentOption.selected boolValue]) {
                    [array addObject:segmentOption.name];
                }
            }
            if (array.count != 0) {
                self.tfValue.text = [array componentsJoinedByString:@", "];
            } else {
                self.tfValue.text = nil;
            }
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images.bundle/opciones.png"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.bounds = CGRectMake(0, 0, 15, 15);
            self.tfValue.rightView = imageView;
            self.tfValue.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case OctopushSegmentTypeBool:
        {
            if (!self.segment.booleanValue) {
                self.tfValue.text = nil;
            } else if ([self.segment.booleanValue boolValue]) {
                self.tfValue.text = NSLocalizedString(@"combo_si", nil);
            } else {
                self.tfValue.text = NSLocalizedString(@"combo_no", nil);
            }
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images.bundle/opciones.png"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.bounds = CGRectMake(0, 0, 15, 15);
            self.tfValue.rightView = imageView;
            self.tfValue.rightViewMode = UITextFieldViewModeAlways;
        }
            break;
        case OctopushSegmentTypeDate:
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"images.bundle/opciones.png"]];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.bounds = CGRectMake(0, 0, 15, 15);
            self.tfValue.rightView = imageView;
            self.tfValue.rightViewMode = UITextFieldViewModeAlways;
            if (!self.segment.dateValue) {
                self.tfValue.text = nil;
            } else {
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                dateFormat.dateFormat = @"dd.MM.yyyy";
                self.tfValue.text = [dateFormat stringFromDate:self.segment.dateValue];
            }
        }
            break;
        default:
            break;
    }
}

- (void)prepareForReuse {
    self.tfValue.text = nil;
    self.tfValue.rightView = nil;
    self.tfValue.rightViewMode = UITextFieldViewModeNever;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[IQKeyboardManager sharedManager]resignFirstResponder];
    BOOL canEdit = YES;
    switch (self.segment.segmentType) {
        case OctopushSegmentTypeBool:
        {
            [self showBoolOptions];
            canEdit = NO;
        }
            break;
        case OctopushSegmentTypeDate:
        {
            [self showDateOptions];
            canEdit = NO;
        }
            break;
        case OctopushSegmentTypeOption:
        {
            [self showVariableOptions];
            canEdit = NO;
        }
            break;
        default:
            break;
    }
    return canEdit;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    switch (self.segment.segmentType) {
        case OctopushSegmentTypeNum:
        {
            if (textField.text == nil || [textField.text isEqualToString:@""]) {
                self.segment.numericValue = nil;
            } else {
                self.segment.numericValue = @([textField.text floatValue]);
            }
        }
            break;
        case OctopushSegmentTypeText:
        {
            self.segment.textValue = textField.text;
        }
            break;
        default:
            break;
    }
}

- (void) showBoolOptions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"combo_selecciona_opcion", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_si", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.segment.booleanValue = @(true);
        [self loadCell];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_no", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.segment.booleanValue = @(false);
        [self loadCell];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_borrar", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.segment.booleanValue = nil;
        [self loadCell];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_cancelar", nil) style:UIAlertActionStyleCancel handler:nil]];
    if ([self.delegate respondsToSelector:@selector(presentOptionsFromsegmentCell:)]) {
        [[self.delegate presentOptionsFromsegmentCell:self] presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) showDateOptions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"combo_selecciona_opcion", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_seleccionar_fecha", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showDateOptionsDate];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_borrar", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        self.segment.dateValue = nil;
        [self loadCell];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_cancelar", nil) style:UIAlertActionStyleCancel handler:nil]];
    if ([self.delegate respondsToSelector:@selector(presentOptionsFromsegmentCell:)]) {
        [[self.delegate presentOptionsFromsegmentCell:self] presentViewController:alertController animated:YES completion:nil];
    }
}

- (void) showDateOptionsDate {
    IQActionSheetPickerView *picker = [[IQActionSheetPickerView alloc] initWithTitle:NSLocalizedString(@"combo_seleccionar_fecha", nil) delegate:self];
    [picker setActionSheetPickerStyle:IQActionSheetPickerStyleDatePicker];
    [picker show];
}

- (void) showVariableOptions {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"combo_selecciona_opcion", nil) message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (OctopushSegmentOption *segmentOption in self.segment.options) {
        [alertController addAction:[UIAlertAction actionWithTitle:segmentOption.name style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            segmentOption.selected = @(!segmentOption.selected.boolValue);
            [self loadCell];
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_borrar", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        for (OctopushSegmentOption *segmentOption in self.segment.options) {
            segmentOption.selected = @(false);
        }
        [self loadCell];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"combo_cancelar", nil) style:UIAlertActionStyleCancel handler:nil]];
    if ([self.delegate respondsToSelector:@selector(presentOptionsFromsegmentCell:)]) {
        [[self.delegate presentOptionsFromsegmentCell:self] presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - IQActionSheetPickerViewDelegate

- (void)actionSheetPickerView:(IQActionSheetPickerView *)pickerView didSelectDate:(NSDate*) date {
    self.segment.dateValue = date;
    [self loadCell];
}

@end
