//
//  ViewController.m
//  MeetMeUp
//
//  Created by Mert Akanay on 23.03.2015.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property NSDictionary *meetupDictionary;
@property NSMutableArray *meetupArray;

@property NSDictionary *meetupAddress;
@property NSDictionary *dictionaryAtRow;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property NSURL *url;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94101&text=mobile&time=,1w&text_format=plain&key=2864313b77404018213118225a0211"];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        self.meetupDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.meetupArray = [self.meetupDictionary objectForKey:@"results"];



        [self.tableView reloadData];
    }];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    self.dictionaryAtRow = [self.meetupArray objectAtIndex:indexPath.row];

    
    self.meetupAddress = [self.dictionaryAtRow objectForKey:@"venue"];

    cell.textLabel.text = [self.dictionaryAtRow objectForKey:@"name"];
    cell.detailTextLabel.text = [self.meetupAddress objectForKey:@"address_1"];
    cell.detailTextLabel.numberOfLines=0;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.meetupArray.count;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar //why do I need to tap search twice ??
{
    NSString *search = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=94101&text=%@&time=,1w&text_format=plain&key=2864313b77404018213118225a0211",searchBar.text];
    self.url = [NSURL URLWithString:search];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        self.meetupDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.meetupArray = [self.meetupDictionary objectForKey:@"results"];

    }];

    [self.tableView reloadData];

    [searchBar resignFirstResponder];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DetailViewController *detailVC = [segue destinationViewController];
    detailVC.rowsDictionary = self.dictionaryAtRow;
}


@end
