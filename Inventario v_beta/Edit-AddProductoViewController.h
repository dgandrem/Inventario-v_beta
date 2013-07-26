//
//  Edit-AddProductoViewController.h
//  Inventario v_beta
//
//  Created by Diego Martinez on 25/07/13.
//  Copyright (c) 2013 Diego Martinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Edit_AddProductoViewController : UITableViewController


@property NSString *caller;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UIButton *botonEliminar;



@end
