//
//  FamiliasViewController.m
//  4Tablas
//
//  Created by Alejandro Gomez on 18/12/13.
//  Copyright (c) 2013 Intergrupo. All rights reserved.
//

#import "FamiliasViewController.h"

#import "Fuentes.h"

@interface FamiliasViewController ()

@property (nonatomic, retain) NSArray *familiasArray;

@end

@implementation FamiliasViewController

@synthesize myTableView;
@synthesize familia;

@synthesize familiasArray;


#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title = self.familia;
    self.familiasArray = [Fuentes obtenerFuentesParaLaFamilia:self.familia];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.familiasArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"myCell";
    UITableViewCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [self.familiasArray objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:[self.familiasArray objectAtIndex:indexPath.row] size:16.0];
    return cell;
}


#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
