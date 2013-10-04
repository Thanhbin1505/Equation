//
//  ViewController.m
//  equation
//
//  Created by Apple on 9/29/13.
//  Copyright (c) 2013 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtNumberA;
@property (weak, nonatomic) IBOutlet UITextField *txtNumberB;
@property (weak, nonatomic) IBOutlet UITextField *txtNumberC;
@property (weak, nonatomic) IBOutlet UIButton *btnCalculator;
@property (weak, nonatomic) IBOutlet UILabel *lblOutput;

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.lblOutput.text = @"";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//dismis textview
-(IBAction)editingEnded:(id)sender{
    [sender resignFirstResponder];
}
-(NSString *) checkInputVadidate:(NSString*) numberA : (NSString*) numberB : (NSString*) numberC {
    if(![numberA length] || ![numberB length] || ![numberC length]) {
        return @"Bạn nhập chưa đúng!Yêu cầu nhập lại các tham số";
    }
    return @"";
    
}
-(NSString *) checkCalculator:(NSString*)numberA : (NSString*) numberB : (NSString*) numberC {
    float fNumberA = [numberA floatValue];
    float fNumberB = [numberB floatValue];
    float fNumberC = [numberC floatValue];
    
    float delta = fNumberB * fNumberB - 4 * fNumberA * fNumberC;
    if(delta <0) {
        @throw [[NSException alloc] initWithName:@"Delta <0 " reason:@"Phương trình vô nghiệm!" userInfo:nil];
    }
    else if(delta == 0) {
        self.lblOutput.text = [[NSString alloc] initWithFormat:@"Phương trình có nghiệm x1 = x2 = %0.2f",[self.txtNumberB.text intValue] / [self.txtNumberA.text intValue] * -0.5];
    }
    else {
        float x1 = ([self.txtNumberB.text intValue] * -1 + pow(delta, 0.5)) / 2 * [self.txtNumberA.text intValue];
        float x2 = ([self.txtNumberB.text intValue] * -1 - pow(delta, 0.5)) / 2 * [self.txtNumberA.text intValue];
        self.lblOutput.text = [[NSString alloc] initWithFormat:@"Phương trình có nghiệm \nx1 =%0.2f; x2 = %0.2f",x1,x2];
    }
    
    return @"";
    
}
-(NSString*) calculator:(NSString*) numberA : (NSString *) numberB : (NSString *) numberC {
    NSString * checkInput = [self checkInputVadidate : numberA : numberB : numberC];
    if([checkInput length]) {
        @throw [[NSException alloc] initWithName:checkInput reason:@"Lỗi nhập giá trị tính toán!" userInfo:nil];
    }
    checkInput =[self checkCalculator:numberA : numberB : numberC];
    if([checkInput length]) {
        @throw [[NSException alloc] initWithName:checkInput reason:checkInput userInfo:nil];
    }
    return @"";
}
- (IBAction)clickCalculator:(id)sender {
    NSString* numberA =self.txtNumberA.text;
    NSString* numberB =self.txtNumberB.text;
    NSString* numberC =self.txtNumberC.text;
    @try{
        [self calculator: numberA : numberB : numberC];
    }@catch (NSException *ex) {
        self.lblOutput.text = [[NSString alloc] initWithFormat:@"%@\n%@",ex.name,ex.reason];
    }

}

@end
