//
//  ViewController.m
//  GTM-Demo-V1
//
//  Created by chao hsin-cheng on 2015/9/6.
//  Copyright (c) 2015年 chao hsin-cheng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *appVersionLabel;
@property (weak, nonatomic) IBOutlet UITextView *infoTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    self.appVersionLabel.text =
    [NSString stringWithFormat:@"Current Version: %@", self.currentAppVersion];
    self.infoTextField.text = @"Try press the button";
    
    dispatch_after(1.0, dispatch_get_main_queue(), ^{
        [self checkForAppUpdate];
    });
}

- (NSString *)currentAppVersion
{
   return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

- (NSString *)latestAppVersion
{
    return @"1.3.5";
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
    [self updateTextInInfoField];
}

- (void)updateTextInInfoField
{
    [self.infoTextField setText:self.getLatestText];
}

- (NSString *)getLatestText
{
    static int cnt = 0;
    cnt++;
    return [NSString stringWithFormat:@"The button has been pressed %d times", cnt];
}


@end
