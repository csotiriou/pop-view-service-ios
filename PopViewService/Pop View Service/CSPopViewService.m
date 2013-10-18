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
#import "CSWatchDogPopTip.h"

@interface CSPopViewService () <CSWatchDogPopTipDelegate>
@property (nonatomic, strong) NSMutableArray *watchdogsArray;
@property (nonatomic, strong) NSMutableArray *visiblePopViews;
@property (nonatomic, strong) CSWatchDogPopTip *wd;
@end

@implementation CSPopViewService

- (id)init
{
    self = [super init];
    if (self) {
		self.visiblePopViews = [NSMutableArray array];
		self.autoDismiss = NO;
		self.autoDismissTime = 0;
		self.watchdogsArray = [NSMutableArray array];
	}
    
    return self;
}

- (void) presentPopView:(CMPopTipView *)view afterDelay:(NSTimeInterval)delay pointingAtBarButtonItem:(UIBarButtonItem *)barButtonItem dismissOtherManagedPopViews:(BOOL)dismissOther
{
	__block __weak CSPopViewService *weakSelf = self;
	
	CSWatchDogPopTip *newWatchDog = [[CSWatchDogPopTip alloc] initWithDelegate:self associatedView:view andBlock:^(CMPopTipView *view) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[view presentPointingAtBarButtonItem:barButtonItem animated:YES];
			if (dismissOther) {
				[weakSelf dismissAllViewsAnimated:YES];
			}
			[weakSelf.visiblePopViews addObject:view]; // add it again, since it will be removed because we dismissed all views before

		});
	}];
	newWatchDog.timeInterval = delay;
	
	[self.watchdogsArray addObject:newWatchDog];
	[newWatchDog fire];
}

- (void) presentPopView:(CMPopTipView *)view afterDelay:(NSTimeInterval)delay pointingAtView:(UIView *)viewThatIsBeingPointerAt containerView:(UIView *)containerView dismissOtherManagedPopViews:(BOOL)dismissOther
{
	__block __weak CSPopViewService *weakSelf = self;
	
	CSWatchDogPopTip *newWatchDog = [[CSWatchDogPopTip alloc] initWithDelegate:self associatedView:view andBlock:^(CMPopTipView *view) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[view presentPointingAtView:viewThatIsBeingPointerAt inView:containerView animated:YES];
			if (dismissOther) {
				[weakSelf dismissAllViewsAnimated:YES];
			}
			[weakSelf.visiblePopViews addObject:view]; // add it again, since it will be removed because we dismissed all views before
			
		});
	}];
	newWatchDog.timeInterval = delay;
	
	[self.watchdogsArray addObject:newWatchDog];
	[newWatchDog fire];
}

- (void)watchDogTimeHasPassed:(CSWatchDogPopTip *)dog withView:(CMPopTipView *)view
{
	[self.watchdogsArray removeObject:dog];
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
	[self.visiblePopViews removeObject:popTipView];
}

- (void)dismissPopView:(CMPopTipView *)popTipView animated:(BOOL)animated
{
	[popTipView dismissAnimated:animated];
	if ([self.visiblePopViews containsObject:popTipView]) {
		[self.visiblePopViews removeObject:popTipView];
	}
}

- (void)stopAllTimers
{
	[self.watchdogsArray makeObjectsPerformSelector:@selector(invalidate)];
	[self.watchdogsArray removeAllObjects];
}

- (void)dismissAllViewsAnimated:(BOOL)animated
{
	for (CMPopTipView *popView in self.visiblePopViews) {
		[popView dismissAnimated:animated];
	}
	[self.visiblePopViews removeAllObjects];
}


- (void)dealloc {
	[self dismissAllViewsAnimated:NO];
}
@end
