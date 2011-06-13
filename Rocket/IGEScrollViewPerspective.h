//
//  IGEScrollViewPerspective.h
//  IGElements
//
// created by ondrej rafaj

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef enum {
	IGEScrollViewPerspectiveScrollDirectionsAll,
	IGEScrollViewPerspectiveScrollDirectionsHorizontal,
	IGEScrollViewPerspectiveScrollDirectionsVertical
} IGEScrollViewPerspectiveScrollDirections;


@class IGEScrollViewPerspective;

@protocol IGEScrollViewPerspectiveDelegate

@required

- (void)perspectiveScrollViewDidScroll:(IGEScrollViewPerspective *)scrollView;

@end


@interface IGEScrollViewPerspective : UIScrollView <UIScrollViewDelegate> {
	
	NSMutableArray *backgroundImageViews;
	
	id <IGEScrollViewPerspectiveDelegate> perspectiveDelegate;
	
	IGEScrollViewPerspectiveScrollDirections allowedScrollDirections;
	
}

@property (nonatomic, retain) NSMutableArray *backgroundImageViews;

@property (nonatomic, assign) id <IGEScrollViewPerspectiveDelegate> perspectiveDelegate;

@property (nonatomic) IGEScrollViewPerspectiveScrollDirections allowedScrollDirections;


- (id)init;

- (void)addBackgroundLayerWithImage:(UIImage *)image;

- (void)addBackgroundLayerWithImageView:(UIImageView *)imageView;

- (void)repositionSubview:(int)tag xPos:(float)xPos yPos:(float)yPos width:(float)width height:(float)height;

- (void)setScrollViewOffset:(float)xPos yPos:(float)yPos;

- (void)rotateImageInScrollViewAnimated:(int)tag time:(CGFloat)time;


@end
