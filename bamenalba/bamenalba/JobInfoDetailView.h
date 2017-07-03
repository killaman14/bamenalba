//
//  JobInfoDetailView.h
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JobInfoDetailView : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;

- (id) initWithCoder:(NSCoder *)aDecoder data:(NSDictionary *)data;



- (IBAction) Photo:(id)sender;

- (IBAction)Close:(id)sender;

- (IBAction)Call:(id)sender;

- (IBAction)Post:(id)sender;
@end
 
