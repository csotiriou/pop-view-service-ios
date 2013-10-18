//  Created by Christos Sotiriou on 9/28/11.
//  Copyright 2011 Oramind.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ViewController.h"
#import "CSPopViewService.h"
#import "CMPopTipView.h"

@interface ViewController ()
@property (nonatomic, strong) CSPopViewService *popService;
@end

@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	
	CMPopTipView *pop = [[CMPopTipView alloc] initWithTitle:@"Title" message:@"Message"];
	CMPopTipView *pop2 = [[CMPopTipView alloc] initWithTitle:@"Title" message:@"Message"];
	CMPopTipView *pop3 = [[CMPopTipView alloc] initWithTitle:@"Title" message:@"Message"];

	self.popService = [[CSPopViewService alloc] init];
	
	
	[self.popService presentPopView:pop afterDelay:2 pointingAtBarButtonItem:self.barItem1 dismissOtherManagedPopViews:NO];
	[self.popService presentPopView:pop2 afterDelay:3 pointingAtBarButtonItem:self.barItem2 dismissOtherManagedPopViews:NO];
	[self.popService presentPopView:pop3 afterDelay:5 pointingAtBarButtonItem:self.barItem3 dismissOtherManagedPopViews:YES];
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
