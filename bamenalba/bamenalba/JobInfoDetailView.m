//
//  JobInfoDetailView.m
//  bamenalba
//
//  Created by GSMAC on 2017. 6. 2..
//  Copyright © 2017년 bamenalba. All rights reserved.
//

#import "JobInfoDetailView.h"

@interface JobInfoDetailView () <UIScrollViewDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UITextView *IntroduceTextView;

@property (strong, nonatomic) NSString *IntroduceText;

@property (strong, nonatomic) NSMutableDictionary *Data;

@end

@implementation JobInfoDetailView

@synthesize IntroduceTextView;

@synthesize IntroduceText;

@synthesize Data;


- (id) initWithCoder:(NSCoder *)aDecoder data:(NSDictionary *)data
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    
    [self.IntroduceTextView setDelegate:self];
    
    [self.IntroduceTextView setText:IntroduceText];
    [self.IntroduceTextView setTextColor:[UIColor lightGrayColor]];
    
    
    [self.ScrollView setDelegate:self];
    
    CGSize size = CGSizeMake(self.view.frame.size.width, self.ScrollView.contentSize.height * 1.3f);
    [self.ScrollView setContentSize:size];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [_ScrollView setContentSize:_ScrollView.frame.size];
    
    [_ScrollView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)Close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)Call:(id)sender {
    
}

- (IBAction)Post:(id)sender {
    
}


#pragma mark - [ SCROLL VIEW DELEGATE ]




#pragma mark - [ TEXT VIEW DELEGATE ]

- (void) textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"");
    [self.ScrollView setContentOffset:CGPointMake(self.IntroduceTextView.frame.origin.x,
                                                  self.IntroduceTextView.frame.origin.y + self.IntroduceTextView.frame.size.height + [UIScreen mainScreen].bounds.size.height/2) ];
}

@end
