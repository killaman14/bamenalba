//
//  HumacResourcesCell.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 5..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HumanResourcesCellDelegate <NSObject>

@optional
- (void) CallDetailView;
- (void) CallPost;

@end


@interface HumanResourcesCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *TitleImage;

@property (weak, nonatomic) IBOutlet UILabel *StateLb;
@property (weak, nonatomic) IBOutlet UILabel *ComentLb;

@property (weak, nonatomic) IBOutlet UIView *DetailButton;
@property (weak, nonatomic) IBOutlet UIView *PostButton;

@property (assign, nonatomic) id<HumanResourcesCellDelegate> delegate;



- (void) SetCellData:(NSDictionary *)data;

- (IBAction)CallPost:(id)sender;

- (IBAction)CallDetail:(id)sender;
@end
