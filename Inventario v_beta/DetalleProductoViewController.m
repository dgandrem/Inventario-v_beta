//
//  DetalleProductoViewController.m
//  Inventario v_beta
//
//  Created by Diego Martinez on 24/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import "DetalleProductoViewController.h"

@interface DetalleProductoViewController ()

@end

@implementation DetalleProductoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)controlStock:(id)sender {
    UISegmentedControl *controlador = (UISegmentedControl *) sender;
    //[controlador setSelectedSegmentIndex:UISegmentedControlNoSegment];
    NSString *titulo;
    if( [controlador selectedSegmentIndex] == 0)
    {
        titulo = @"Unidades a disminuir:\n\n";
        _accionStock = @"-";
    }
    else if([controlador selectedSegmentIndex ] == 1)
    {
        titulo = @"Cambiar valor de Stock a:\n\n";
        _accionStock = @"set";
    }
    else if([controlador selectedSegmentIndex ] == 2)
    {
        titulo = @"Unidades a aumentar:\n\n";
        _accionStock = @"+";
    }
    
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titulo
                                                          message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    UITextField *myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
    //myTextField.delegate = self;
    [myTextField setTag:1000];
    [myTextField setKeyboardType:UIKeyboardTypeNumberPad];
    [myTextField setBackgroundColor:[UIColor whiteColor]];
    [myTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [myAlertView addSubview:myTextField];
    [myAlertView show];
}

-(void) alertView: (UIAlertView*) alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    [self.segmentedControlStock setSelectedSegmentIndex:UISegmentedControlNoSegment];
    
    if(buttonIndex == 1)
    {
        UITextField *cuadroTexto= (UITextField *)[alertView viewWithTag:1000];
        
        NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
        [f setNumberStyle:NSNumberFormatterDecimalStyle];
        UITableViewCell* stock=  [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2]];
        
        
        NSNumber * numberFromAlert = [f numberFromString: cuadroTexto.text];
        NSNumber * numberFromCell  = [f numberFromString: stock.textLabel.text];
        
        if( [_accionStock isEqualToString:@"-"])
        {
            stock.textLabel.text = [f stringFromNumber: [NSNumber numberWithInt:( -[numberFromAlert intValue] + [numberFromCell intValue])]];
        }
        else if([_accionStock isEqualToString:@"+"])
        {
            stock.textLabel.text = [f stringFromNumber: [NSNumber numberWithInt:([numberFromAlert intValue] + [numberFromCell intValue])]];
        }
        else if([_accionStock isEqualToString:@"set"])
        {
            stock.textLabel.text = [f stringFromNumber: numberFromAlert];
        }
        //Player *modified = [players objectAtIndex:currentRow];
        //modified.name = [NSString stringWithString:texto.text];
        //[players insertObject:modified atIndex:currentRow];
        //[players removeObjectAtIndex:currentRow+1];
        //[self.tableView reloadData];
    }
}

@end
