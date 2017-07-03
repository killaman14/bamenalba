//
//  MemoBoxCell.h
//  bamenalba
//
//  Created by Sejung Park on 2017. 6. 15..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemoBoxCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (weak, nonatomic) IBOutlet UIImageView *TitleIMG;
@property (weak, nonatomic) IBOutlet UILabel *StateLb;
@property (weak, nonatomic) IBOutlet UILabel *ContentLb;
@property (weak, nonatomic) IBOutlet UILabel *TimeLb;


- (IBAction) Photo:(id)sender;

- (void) setCellData:(NSDictionary *) data;

@end
