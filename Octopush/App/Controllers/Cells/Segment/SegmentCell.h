//
//  SegmentCell.h
//  Octopush
//
//  Created by Rafael Fernandez Alvarez on 27/06/2017.
//  Copyright © 2017 SDOS. All rights reserved.
//

#define SegmentCellIdentifier @"SegmentCellIdentifier"

#import <UIKit/UIKit.h>
#import <Octopush/Octopush.h>

@protocol SegmentCellDelegate;

@interface SegmentCell : UITableViewCell

@property (strong, nonatomic) OctopushSegment *segment;

@property (weak, nonatomic) id<SegmentCellDelegate> delegate;

/**
 *  Método donde se realiza la carga de los componentes de la celda.
 */
- (void) loadCell;

@end


@protocol SegmentCellDelegate <NSObject>

- (UIViewController *) presentOptionsFromsegmentCell:(SegmentCell *) segmentCell;

- (void) segmentCell:(SegmentCell *) segmentCell changeValue:(id) newValue;

@end
