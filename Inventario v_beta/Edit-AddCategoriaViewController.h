//
//  Edit-AddCategoriaViewController.h
//  Inventario v_beta
//
//  Created by Diego Martinez on 25/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Edit_AddCategoriaViewController : UITableViewController
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)done:(UIBarButtonItem *)sender;
@property NSString *llamada;
@property (weak, nonatomic) IBOutlet UIButton *botonEliminar;

@end
