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
@property (assign, nonatomic) id<HumanResourcesCellDelegate> delegate;
@end
