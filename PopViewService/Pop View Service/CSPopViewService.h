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

#import <Foundation/Foundation.h>
#import "CMPopTipView.h"

@interface CSPopViewService : NSObject <CMPopTipViewDelegate>
@property (nonatomic) BOOL autoDismiss;
@property (nonatomic) NSTimeInterval autoDismissTime;



/**
 Presents the view after a delay
 @param view the popTipView to display
 @param delay after how many seconds will it be presented?
 @param barButtonItem the bar button item to point the view at
 @param dismissOther dismiss other views while presenting this one?
 */
- (void) presentPopView:(CMPopTipView *)view afterDelay:(NSTimeInterval)delay pointingAtBarButtonItem:(UIBarButtonItem *)barButtonItem dismissOtherManagedPopViews:(BOOL)dismissOther;


/**
 Presents the CMPopTipView after a delay
 @param view view the popTipView to display
 @param delay delay after how many seconds will it be presented
 @param viewThatIsBeingPointerAt the view to point the popTipView at
 @param containerView the view that will contain the CMPopTipView
 @param dismissOther dismiss other views while presenting this one?
 */
- (void) presentPopView:(CMPopTipView *)view afterDelay:(NSTimeInterval)delay pointingAtView:(UIView *)viewThatIsBeingPointerAt containerView:(UIView *)containerView dismissOtherManagedPopViews:(BOOL)dismissOther;



/**
 Stops all background timers, which means that there will be presented no views after a while, if they are set
 to be presented
 */
- (void)stopAllTimers;

- (void)dismissAllViewsAnimated:(BOOL)animated;
- (void)dismissPopView:(CMPopTipView *)popTipView animated:(BOOL)animated;

- (void)enableAutoDismissAfterTime:(NSTimeInterval)dismissAfterTime;
- (void)disableAutoDismiss;
@end
