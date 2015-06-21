//
//  CreateTripVC.m
//  travellog
//
//  Created by Cullen on 20/6/15.
//  Copyright (c) 2015 Cullen. All rights reserved.
//

#import "CreateTripVC.h"

@interface CreateTripVC ()

@property (nonatomic, weak) IBOutlet UITextField *destinationTF;
@property (nonatomic, weak) IBOutlet UITextField *startDateTF;
@property (nonatomic, weak) IBOutlet UITextField *endDateTF;
@property (nonatomic, weak) IBOutlet UITextField *titleTF;
@property (nonatomic, weak) IBOutlet UITextView *descriptionTV;

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) NSDateFormatter *df;

@end

@implementation CreateTripVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem.rightBarButtonItem setEnabled:NO];
    
    [self.titleTF addTarget:self
                        action:@selector(textFieldDidChange:)
              forControlEvents:UIControlEventEditingChanged];
    [self.destinationTF addTarget:self
                     action:@selector(textFieldDidChange:)
           forControlEvents:UIControlEventEditingChanged];
    [self.startDateTF addTarget:self
                     action:@selector(textFieldDidChange:)
           forControlEvents:UIControlEventEditingChanged];
    
    self.datePicker = [[UIDatePicker alloc] init];
    [self.datePicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];

    self.df = [[NSDateFormatter alloc] init];
    [self.df setDateFormat:@"yyyy-MM-dd"];
    
    self.startDateTF.inputView = self.datePicker;
    self.endDateTF.inputView = self.datePicker;
    [self.endDateTF addTarget:self
                           action:@selector(textFieldDidChange:)
                 forControlEvents:UIControlEventEditingChanged];
}


- (IBAction)cancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (IBAction)savePressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.tableView endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)checkToEnableSendButton{
    NSString *trimmedTitleString = [self.titleTF.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimmedDestinationString = [self.destinationTF.text stringByTrimmingCharactersInSet:
                                    [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *trimmedStartDateString = [self.startDateTF.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    NSString *trimmedEndDateString = [self.endDateTF.text stringByTrimmingCharactersInSet:
//                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    
    NSString *trimmedDescriptionString = [self.descriptionTV.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
    if (trimmedTitleString.length > 0 &&
        trimmedDestinationString.length > 0 &&
        trimmedStartDateString.length > 0 &&
        trimmedDescriptionString.length > 0) {
        [self.navigationItem.rightBarButtonItem setEnabled:YES];
    } else {
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.startDateTF || textField == self.endDateTF) {
        if ([textField.text length] == 0) {
            textField.text = [self.df stringFromDate:[NSDate date]];
        }
    }
}

- (BOOL)textFieldDidChange:(UITextField *)textField
{
    [self checkToEnableSendButton];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  
    [self checkToEnableSendButton];
}

- (void)textViewDidChange:(UITextView *)textView{
    [self checkToEnableSendButton];
}

- (void)pickerChanged:(id)sender
{
    if ([self.startDateTF isFirstResponder])
    {
        NSDate *date = self.datePicker.date;
        self.startDateTF.text = [self.df stringFromDate:date];
    } else if ([self.endDateTF isFirstResponder])
    {
        NSDate *date = self.datePicker.date;
        self.endDateTF.text = [self.df stringFromDate:date];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([touch.view isKindOfClass:[UIControl class]]) {
        
        // Don't let selections of auto-complete entries fire the
        // gesture recognizer
        return NO;
    }
    
    return YES;
}

@end
