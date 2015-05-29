//
//  FDTreatmentCollectionViewController.h
//  Flaredown
//
//  Created by Cole Cunningham on 5/27/15.
//  Copyright (c) 2015 Flaredown. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FDTreatment.h"

@interface FDTreatmentCollectionViewController : UICollectionViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *addDoseTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *addDoseQuantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *addDoseUnitTextField;
@property (weak, nonatomic) IBOutlet UIButton *addDoseCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *addDoseDoneButton;

@property (weak, nonatomic) IBOutlet UILabel *editDoseTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *editDoseQuantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *editDoseUnitTextField;
@property (weak, nonatomic) IBOutlet UIButton *editDoseCancelButton;
@property (weak, nonatomic) IBOutlet UIButton *editDoseDoneButton;

@property FDTreatment *selectedTreatment;
@property FDDose *selectedDose;

@end
