//
//  ViewController.m
//  4Tablas
//
//  Created by Alejandro Gomez on 17/12/13.
//  Copyright (c) 2013 Intergrupo. All rights reserved.
//

#import "ViewController.h"

#import "InformationViewController.h"
#import "FamiliasViewController.h"

#import "Fuentes.h"
#import "Constants.h"

@interface ViewController ()
{
    BOOL isEditing;
}

@property (nonatomic, retain) NSMutableArray *fuentesArray;

@end

@implementation ViewController

@synthesize fuentesArray;


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    isEditing = NO;
    [self setNavigationBarButtons];
    self.fuentesArray = [[NSMutableArray alloc] initWithArray:[Fuentes obtenerFuentes]];
}


#pragma mark - UIBarButton

- (void)setNavigationBarButtons
{
    if (isEditing)
    {
        isEditing = NO;
        UIBarButtonItem *doneButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonPressed)];
        self.navigationItem.leftBarButtonItem = doneButtonItem;
    }
    else
    {
        isEditing = YES;
        UIBarButtonItem *editButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleDone target:self action:@selector(editButtonPressed)];
        self.navigationItem.leftBarButtonItem = editButtonItem;
    }
    
    UIBarButtonItem *refreshButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshButtonPressed)];
    self.navigationItem.rightBarButtonItem = refreshButtonItem;
}

- (void)editButtonPressed
{
    [self.tableView setEditing:YES animated:YES];
    [self setNavigationBarButtons];
}

- (void)doneButtonPressed
{
    [self.tableView setEditing:NO animated:YES];
    [self setNavigationBarButtons];
}

- (void)refreshButtonPressed
{
    self.fuentesArray = [[NSMutableArray alloc] initWithArray:[Fuentes obtenerFuentes]];
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.fuentesArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fuentesArray objectAtIndex:section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MyCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.editingAccessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    cell.textLabel.text = [[self.fuentesArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:[[self.fuentesArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row] size:16.0];
    return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return LETTERS;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [LETTERS objectAtIndex:section];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing)
    {
        [[self.fuentesArray objectAtIndex:indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"informationViewController" sender:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"familiasViewController" sender:indexPath];
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing)
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleNone;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Borrar";
}


#pragma mark - UIStoryboardSegue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"informationViewController"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        InformationViewController *controller = (InformationViewController *)segue.destinationViewController;
        controller.labelString = [[self.fuentesArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
    else if ([segue.identifier isEqualToString:@"familiasViewController"])
    {
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        FamiliasViewController *controller = (FamiliasViewController *)segue.destinationViewController;
        controller.familia = [[self.fuentesArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    }
}



#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
