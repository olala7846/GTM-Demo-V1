//
//  ViewController.m
//  GTM-Demo-V1
//
//  Created by chao hsin-cheng on 2015/9/6.
//  Copyright (c) 2015年 chao hsin-cheng. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import <GoogleTagManager/TAGDataLayer.h>


static NSString * const kGTMKeyBtnPressedCnt = @"buttonPressedTime";
static NSString * const kGTMKeyAdDetail = @"adDetail";
static NSString * const kGTMKeyShouldDisplayAd = @"shouldDisplayAd";

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextField;

@property (weak, nonatomic) TAGContainer *container;
@property (weak, nonatomic) TAGManager *tagManager;
@property (weak, nonatomic) AppDelegate *appDelegate;
@property (weak, nonatomic) TAGDataLayer *dataLayer;

@end

@implementation ViewController

# pragma mark custom getter
- (AppDelegate *)appDelegate
{
    return [UIApplication sharedApplication].delegate;
}

- (TAGContainer *)container
{
    return self.appDelegate.container;
}

- (TAGManager *)tagManager
{
    return self.appDelegate.tagManager;
}

- (TAGDataLayer *)dataLayer
{
    return self.tagManager.dataLayer;
}

# pragma mark - UIViewController Live cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.appVersionLabel.text =
    [NSString stringWithFormat:@"Current Version: %@", self.currentAppVersion];
    self.infoTextField.text = @"Ad should show up after 10 button press";
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self checkForAppUpdate];
    });
}

- (NSString *)currentAppVersion
{
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)latestAppVersion
{
    TAGContainer *container = self.container;
    
    NSString *latestVersion = [container stringForKey:@"latestVersion"];
    return latestVersion;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForAppUpdate
{
    NSString *currentVersion = self.currentAppVersion;
    NSString *latestVersion = self.latestAppVersion;
    
    if ([currentVersion compare:latestVersion options:NSNumericSearch] == NSOrderedAscending) {
        [self showUpdateAlert];
    }
}

- (void)showUpdateAlert
{
    UIAlertController *ac =
    [UIAlertController alertControllerWithTitle:@"Big News!"
                                        message:@"App Update Available"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *updateNow =
    [UIAlertAction actionWithTitle:@"Update Now"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction *action)
    {
        NSURL *updateUrl = [NSURL URLWithString:@"http://apple.download.url"];
        [[UIApplication sharedApplication] openURL:updateUrl];
    }];
    
    UIAlertAction *updateLater =
    [UIAlertAction actionWithTitle:@"Later"
                             style:UIAlertActionStyleCancel
                           handler:nil];
    [ac addAction:updateNow];
    [ac addAction:updateLater];
    [self presentViewController:ac animated:YES completion:nil];

}

- (IBAction)buttonPressed:(id)sender {
    [self increaseBtnPresseCntOnDataLayer];
    [self updateInfoText];
    [self checkIfAdShoulBeShown];
}

- (void)updateInfoText
{
    TAGDataLayer *dataLayer = self.dataLayer;
    NSNumber * cnt = (NSNumber *)[dataLayer get:kGTMKeyBtnPressedCnt];
    NSString *info = [NSString stringWithFormat:@"Current datalayer buttonPressedTime %@", cnt];
    [self.infoTextField setText:info];
}

- (void)increaseBtnPresseCntOnDataLayer
{
    TAGDataLayer *dataLayer = self.dataLayer;
    NSNumber * cnt = (NSNumber *)[dataLayer get:kGTMKeyBtnPressedCnt];
    NSNumber * newCnt = @(cnt.intValue+1);
    [dataLayer pushValue:newCnt forKey:kGTMKeyBtnPressedCnt];
}

- (void)checkIfAdShoulBeShown
{
    BOOL shouldDisplayAd = [self.container booleanForKey:kGTMKeyShouldDisplayAd];
    if (shouldDisplayAd) {
        NSString *addDetail = [self.container stringForKey:kGTMKeyAdDetail];
        [self showAlertForInfo:addDetail];
    }
}

- (void)showAlertForInfo:(NSString *)info
{
    UIAlertController *ac =
    [UIAlertController alertControllerWithTitle:@"Ad"
                                        message:info
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *colse =
    [UIAlertAction actionWithTitle:@"Close"
                             style:UIAlertActionStyleCancel
                           handler:nil];
    [ac addAction:colse];
    [self presentViewController:ac animated:YES completion:nil];
    
}


@end
