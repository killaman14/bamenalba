//
//  MeetingCell.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 14..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ContentLb;
@property (weak, nonatomic) IBOutlet UILabel *StateLb;

@property (weak, nonatomic) IBOutlet UIImageView *TitleIMG;

@property (weak, nonatomic) IBOutlet UIImageView *PostButtonBG;
@property (weak, nonatomic) IBOutlet UIImageView *DeleteButtonBG;


- (void) setCellData:(NSDictionary *) data;

@end
