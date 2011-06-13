//
//  RKParalaxViewController.h
//  
//
//  Created by Tim Storey on 13/05/2011.
//

#import <UIKit/UIKit.h>
#import "IGEScrollViewPerspective.h"
#import "RKMultipleScrollView.h"


@interface RKParallaxViewController :UIViewController <IGEScrollViewPerspectiveDelegate, UIAccelerometerDelegate> {
    CGPoint startPoint;
    CGRect startFrame;
    CGRect newFrame;
    BOOL arrived;
    RKMultipleScrollView *multiScrollView;
    IGEScrollViewPerspective *pView;

}

- (void)imageViewFadeOut:(UIView *)iv fadeTime:(CGFloat)fadeTime;

- (void)imageViewFadeIn:(UIView *)iv fadeTime:(CGFloat)fadeTime;

- (void)panDetected:(UIPanGestureRecognizer *)sender;

- (void)replaceViewWithFadeOut:(UIView *)firstView secondView:(UIView *)secondView fadeDuration:(CGFloat)fadeDuration;

- (void)handlePanActionForRocket:(UIPanGestureRecognizer *)pan view:(UIView *)view;

- (void)addImageToImageInPerspectiveView:(IGEScrollViewPerspective *)psv img:(UIImage *)img frame:(CGRect)frame imgTag:(PictureTypes)imgTag;

- (void)addImageToViewInSubview:(UIView*)containingView img:(UIImage *)img frame:(CGRect)frame tag:(PictureTypes)tag;

- (void)handleTaps:(UITapGestureRecognizer *)sender;

- (void)addRecogniserToViewInSubview:(UIView *)containingView tag:(PictureTypes)tag recogniser:(UIGestureRecognizer *)recogniser;

- (CGPoint)getPositionForLayerInSubview:(UIView *)containingView tag:(PictureTypes)tag;

- (void)createBlockAnimation;


@end

 