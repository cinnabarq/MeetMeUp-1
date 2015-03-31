//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Mert Akanay on 23.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "WebViewController.h"
#import "Meetup.h"

@interface WebViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Meetup *newMeetup;

    for (int i = 0; i < self.meetups.count; i++)
    {
        newMeetup = self.meetups[i];
    }
    self.navigationItem.title = newMeetup.name;

    NSString *web = newMeetup.eventURL;
    NSURL *website = [NSURL URLWithString:web];
    NSURLRequest *request = [NSURLRequest requestWithURL:website];
    [self.webView loadRequest:request];

    self.activityIndicator.hidesWhenStopped = YES;

}
- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
}

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidesWhenStopped = YES;

    if([self.webView canGoBack] == YES)
    {
        self.backButton.enabled = YES;
    }else{
        self.backButton.enabled = NO;
    }

    if([self.webView canGoForward] == YES)
    {
        self.forwardButton.enabled = YES;
    }else{
        self.forwardButton.enabled = NO;
    }
}


@end
