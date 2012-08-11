//
//  SFPopViewService.m
//
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

#import "CSPopViewService.h"
#import "CMPopTipView.h"


@implementation CSPopViewService
@synthesize popViews;
@synthesize currentBackgroundColor;
@synthesize currentTextColor;
@synthesize autoDismiss;
@synthesize autoDismissTime;

- (id)init
{
    self = [super init];
    if (self) {
		self.popViews = [NSMutableArray array];
		self.currentTextColor = [UIColor blackColor];
		self.currentBackgroundColor = [UIColor yellowColor];
		self.autoDismiss = NO;
		self.autoDismissTime = 0;
	}
    
    return self;
}

- (void)presentPopViewWithMessage:(NSString *)message pointingAtView:(UIView *)targetView inView:(UIView *)containerView animated:(BOOL)animated dismissAllOtherViews:(BOOL)soloPresent withDelay:(NSTimeInterval)delay
{
	dispatch_time_t delayQueue = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
	dispatch_after(delayQueue, dispatch_get_main_queue(), ^(void){
		if (soloPresent) {
			[self dismissAllViewsAnimated:animated]; 
		}
		CMPopTipView *popTipVIew = [[CMPopTipView alloc] initWithMessage:message];
		popTipVIew.backgroundColor = self.currentBackgroundColor;
		popTipVIew.textColor = self.currentTextColor;
		[popTipVIew presentPointingAtView:targetView inView:containerView animated:YES];
		[self.popViews addObject:popTipVIew];
		popTipVIew.delegate = self;
		if (self.autoDismiss) {
			dispatch_time_t dismissDelay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * self.autoDismissTime);
			dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, dismissDelay * NSEC_PER_SEC);
			dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
				[self dismissPopView:popTipVIew animated:YES];
			});
		}
	});
}

- (void)presentPopViewWithMessage:(NSString *)message pointingAtBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated dismissAllOtherViews:(BOOL)soloPresent withDelay:(NSTimeInterval)delay
{
	dispatch_time_t delayQueue = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * delay);
	dispatch_after(delayQueue, dispatch_get_main_queue(), ^(void){
		if (soloPresent) {
			[self dismissAllViewsAnimated:animated]; 
		}
		CMPopTipView *popTipView = [[CMPopTipView alloc] initWithMessage:message];
		popTipView.backgroundColor = self.currentBackgroundColor;
		popTipView.textColor = self.currentTextColor;
		[popTipView presentPointingAtBarButtonItem:barButtonItem animated:animated];
		[self.popViews addObject:popTipView];
		popTipView.delegate = self;
		
		if (self.autoDismiss) {
			dispatch_time_t dismissDelay = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * self.autoDismissTime);
			dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, dismissDelay * NSEC_PER_SEC);
			dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
				[self dismissPopView:popTipView animated:YES];
			});
		}
	});
}

- (void)enableAutoDismissAfterTime:(NSTimeInterval)dismissAfterTime
{
	self.autoDismiss = YES;
	self.autoDismissTime = dismissAfterTime;
}

- (void)disableAutoDismiss
{
	self.autoDismiss = NO;
}

- (void)popTipViewWasDismissedByUser:(CMPopTipView *)popTipView
{
	[self.popViews removeObject:popTipView];
}

- (void)dismissPopView:(CMPopTipView *)popTipView animated:(BOOL)animated
{
	[popTipView dismissAnimated:animated];
	if ([self.popViews containsObject:popTipView]) {
		[self.popViews removeObject:popTipView];
	}
}

- (void)dismissAllViewsAnimated:(BOOL)animated
{
	for (CMPopTipView *popView in self.popViews) {
		[popView dismissAnimated:animated];
	}
	[self.popViews removeAllObjects];
}


- (void)dealloc {
	[self dismissAllViewsAnimated:NO];
}
@end
