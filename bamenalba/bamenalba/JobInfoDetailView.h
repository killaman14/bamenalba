//
//  JobInfoDetailView.h
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JobInfoDetailView : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UIView *ContentView;

@property (weak, nonatomic) IBOutlet UIImageView *TitleImg;
@property (weak, nonatomic) IBOutlet UIImageView *TitleBGImg;
@property (weak, nonatomic) IBOutlet UILabel *TitleLb;

@property (weak, nonatomic) IBOutlet UILabel *CompanyNameLb;
@property (weak, nonatomic) IBOutlet UILabel *SectorLb;
@property (weak, nonatomic) IBOutlet UILabel *Area_ProvinceLb;
@property (weak, nonatomic) IBOutlet UILabel *Pay_PaytypeLb;
@property (weak, nonatomic) IBOutlet UILabel *Sex_AgeLb;
@property (weak, nonatomic) IBOutlet UILabel *IntroduceLb;


@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;

- (id) initWithCoder:(NSCoder *)aDecoder data:(NSDictionary *)data;


- (void) InitLoadData:(NSDictionary *)data;

- (IBAction) Photo:(id)sender;

- (IBAction)Close:(id)sender;

- (IBAction)Call:(id)sender;

- (IBAction)Post:(id)sender;

@end
 
