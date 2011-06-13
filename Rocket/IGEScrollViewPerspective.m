//
//  IGEScrollViewPerspective.m
//  IGElements
//
// created by ondrej rafaj

#import "IGEScrollViewPerspective.h"
#import "commons.h"


@interface IGEScrollViewPerspective (private)

- (void)createContentBackground;

@end


@implementation IGEScrollViewPerspective

@synthesize backgroundImageViews;
@synthesize perspectiveDelegate;
@synthesize allowedScrollDirections;


#pragma mark Initialization

- (void)doInit {
	[self setDelegate:self];
	[self setBounces:NO];
	allowedScrollDirections = IGEScrollViewPerspectiveScrollDirectionsAll;
	NSMutableArray *arr = [[NSMutableArray alloc] init];
	self.backgroundImageViews = arr;
	[arr release];
}

- (id)init {
	if ((self = [super init])) {
		[self doInit];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		[self doInit];
	}
	return self;
}

#pragma mark Background posioning

- (int)getBackgroundXPositionForLayer:(int)index {
	CGSize bcgImg = ((UIImageView *) [backgroundImageViews objectAtIndex:index]).frame.size;
    CGFloat ret = 0;
	if (allowedScrollDirections != IGEScrollViewPerspectiveScrollDirectionsVertical) {
		CGFloat percent = self.contentOffset.x / (self.contentSize.width - self.frame.size.width);
		ret = (self.contentSize.width - bcgImg.width) * percent;
	}
	return ret;
}

- (int)getBackgroundYPositionForLayer:(int)index {
	CGSize bcgImg = ((UIImageView *) [backgroundImageViews objectAtIndex:index]).frame.size;
	CGFloat ret = 0;
	if (allowedScrollDirections != IGEScrollViewPerspectiveScrollDirectionsHorizontal) {
		CGFloat percent = self.contentOffset.y / (self.contentSize.height - self.frame.size.height);
		ret = (self.contentSize.height - bcgImg.height) * percent;
	}
	return ret;
}

- (void)syncBackgrounds:(BOOL)animated {
	if (backgroundImageViews) {
		int x = [backgroundImageViews count];
		for (int i = 0; i < x; i++) {
			UIImageView *iv = [backgroundImageViews objectAtIndex:i];
			CGRect r = iv.frame;
//            r.origin.y = [self getBackgroundYPositionForLayer:i];
            r.origin.x = [self getBackgroundXPositionForLayer:i];
			if (animated) [UIView beginAnimations:nil context:nil];
			[iv setFrame:r];
			if (animated) [UIView commitAnimations];
		}
	}
}

#pragma mark Settings

- (void)setContentSize:(CGSize)size {
	[super setContentSize:size];
	//[self syncBackgrounds:NO];
}

- (void)addBackgroundLayerWithImage:(UIImage *)image {
	UIImageView *iv = [[UIImageView alloc] initWithImage:image];
	[iv setBackgroundColor:[UIColor clearColor]];
	[backgroundImageViews addObject:iv];
	[self addSubview:iv];
	[iv release];
}

- (void)addBackgroundLayerWithImageView:(UIImageView *)imageView{
    [imageView setBackgroundColor:[UIColor clearColor]];
//    NSLog(@"origin: %f", imageView.frame.origin.x);
    [backgroundImageViews addObject:imageView];
    [self addSubview:imageView];
//    [imageView release];
    
}

- (void)repositionSubview:(int)tag xPos:(float)xPos yPos:(float)yPos width:(float)width height:(float)height{
//    NSLog(@"enum value: %d",tag);
    for (UIImageView *img in backgroundImageViews) {
        if ([img tag] == tag) {
            //CGRect frame = self.frame;
            float xOffset = self.frame.size.width;
            [img setFrame:CGRectMake(xPos + xOffset, yPos, width, height)];
        }
    }
}


- (void)setScrollViewOffset:(float)xPos yPos:(float)yPos {
    [self setContentOffset:CGPointMake(xPos, yPos)];
}

- (void)setContentOffset:(CGPoint)offset animated:(BOOL)animated {
	[self syncBackgrounds:animated];
	[super setContentOffset:offset animated:animated];
}

- (void)setContentOffset:(CGPoint)offset {
	[self syncBackgrounds:NO];
	[super setContentOffset:offset];
}


#pragma mark Animations

- (void)rotateImageInScrollViewAnimated:(int)tag time:(CGFloat)time{
    
    __block IGEScrollViewPerspective *blockSelf = self;
    
    for ( UIImageView *img in self.subviews ) {
        
        if ([img tag] == tag ){
            CABasicAnimation *fullRotation;
            fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            fullRotation.fromValue = [NSNumber numberWithFloat:0];
            fullRotation.toValue = [NSNumber numberWithFloat:(360*M_PI)/180];
            fullRotation.duration = 80.0;
            fullRotation.speed = .25;
            fullRotation.repeatCount = HUGE_VALF;
            [img.layer addAnimation:fullRotation forKey:@"360"];
        }
    }
}

#pragma mark Scroll view delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	[self syncBackgrounds:NO];
	[perspectiveDelegate perspectiveScrollViewDidScroll:self];
}

#pragma mark Memory management

- (void)dealloc {
	[backgroundImageViews release];
	[super dealloc];
}


@end
