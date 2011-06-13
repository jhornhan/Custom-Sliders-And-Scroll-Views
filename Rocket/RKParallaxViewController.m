//
//  RKParalaxViewController.m
//  
//
//  Created by Tim Storey on 13/05/2011.
//

#import "RKParallaxViewController.h"
#import "commons.h"


@implementation RKParallaxViewController

#pragma mark Memory Management

- (void)dealloc
{
    [multiScrollView release];
    [pView release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Image creation Methods

- (void)makeImageViewForScrollViewWithOrigin:(NSString *)name tag:(PictureTypes)tag scroll:(IGEScrollViewPerspective *)vc originX:(CGFloat)originX originY:(CGFloat)originY{
    UIImage *img = [UIImage imageNamed:name];
    CGSize sz = [img size];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [imgView setTag:tag];
    [imgView setFrame:CGRectMake((CGFloat)originX,(CGFloat)originY, sz.width, sz.height)];    [vc addBackgroundLayerWithImageView:imgView];
    [imgView release];
}

- (void)addImageToImageInPerspectiveView:(IGEScrollViewPerspective *)psv img:(UIImage *)img frame:(CGRect)frame imgTag:(PictureTypes)imgTag {
    
    UIImageView *tmpImgView = [[UIImageView alloc] initWithImage:img];
    [tmpImgView setFrame:frame];
    
    for (UIImageView *view in psv.subviews) {
        if ([view tag]== imgTag){
            [view addSubview:tmpImgView];
        }
    }
    [tmpImgView release];
    
}

- (void)addImageToViewInSubview:(UIView*)containingView img:(UIImage *)img frame:(CGRect)frame tag:(PictureTypes)tag {
    
    UIImageView *tmpView = [[UIImageView alloc] initWithImage:img];
    [tmpView setFrame:frame];
    
    for (UIView *view in containingView.subviews) {
        if ([view tag] == tag) {
            [view addSubview:tmpView];
        }
    }
}

- (void)addRecogniserToViewInSubview:(UIView *)containingView tag:(PictureTypes)tag recogniser:(UIGestureRecognizer *)recogniser {
    for (UIView *iv in containingView.subviews) {
        if ([iv tag] == tag) {
            [iv addGestureRecognizer:recogniser];
        }
    }
}

#pragma mark Setup

- (void)createStaticAssets {
    
    UIImageView *imgView;
    CGSize sz;
    UIImage *img;
    
    img = [UIImage imageNamed:@"earth.png"];
    sz = [img size];
    imgView = [[UIImageView alloc] initWithImage:img];
    [imgView setTag:EARTH];
    [imgView setFrame:CGRectMake(515, 250, sz.width, sz.height)];
    [imgView setUserInteractionEnabled:YES];
    [self.view addSubview:imgView];
    [imgView release];
    
    img = [UIImage imageNamed:@"title_text.png"];
    sz = [img size];
    imgView = [[UIImageView alloc] initWithImage:img];
    [imgView setTag:TITLE_TXT];
    [imgView setFrame:CGRectMake(20, 50, sz.width, sz.height)];
    [self.view addSubview:imgView];    
    [imgView release];
    
    img = [UIImage imageNamed:@"spaceship_arrow.png"];
    imgView = [[UIImageView alloc] initWithImage:img];
    sz = [img size];
    [imgView setTag:ROCKET_ARROW];
    [imgView setFrame:CGRectMake(380, 500, sz.width, sz.height)];
    [self.view addSubview:imgView];
    [imgView release];
    
}


- (void)createTextAssets {
    
    CGSize sz;
    UIImage *img;
    UIImageView *imgView;
    
    img = [UIImage imageNamed:@"spaceship_title"];
    imgView = [[UIImageView alloc] initWithImage:img];
    sz = [img size];
    [imgView setTag:ROCKET_ARROW];
    [imgView setFrame:CGRectMake(300, 600, sz.width, sz.height)];
    [self.view addSubview:imgView];
    [imgView release];
    
    img = [UIImage imageNamed:@"earth_title.png"];    
    imgView = [[UIImageView alloc] initWithImage:img];
    sz = [img size];
    [imgView setTag:EARTH_LBL];
    [imgView setFrame:CGRectMake(900, 380, sz.width, sz.height)];
    [self.view addSubview:imgView];
    [imgView release];
}

- (void)createParallaxAssets {
    
    CGRect frame;
    CGSize sz;
    UIImage *img;
    
    pView = [[IGEScrollViewPerspective alloc] init];
    
    [pView setAllowedScrollDirections:IGEScrollViewPerspectiveScrollDirectionsHorizontal];
    
    [self makeImageViewForScrollViewWithOrigin:@"background.png" tag:BACKGROUND scroll:pView originX:0 originY:0];
    [self makeImageViewForScrollViewWithOrigin:@"sun_rotation.png" tag:SUN scroll:pView originX:0 originY:-350];
    [self makeImageViewForScrollViewWithOrigin:@"stars-small.png" tag:SMALL_STARS scroll:pView originX:0 originY:0];
    [self makeImageViewForScrollViewWithOrigin:@"saturn1.png" tag:SATURN scroll:pView originX:0 originY:40];
    [self makeImageViewForScrollViewWithOrigin:@"stars-big.png" tag:BIG_STARS scroll:pView originX:0 originY:0];
    [self makeImageViewForScrollViewWithOrigin:@"moon.png" tag:MOON scroll:pView originX:0 originY:150];
    
    [pView setPerspectiveDelegate:self];
	[pView setFrame:CGRectMake(0, 0, 1004, 768)];
	[pView setContentSize:CGSizeMake(2400, 768)];
    
    [self.view addSubview:pView];
    [pView setScrollViewOffset:900 yPos:0];
    
//=======================COMMENT LINE BELOW TO STOP ANIMATION===========================//
    [pView rotateImageInScrollViewAnimated:SUN time:90.0];
    
    //to catch the UiPanGestureRecogniser otherwise the UIScrollView takes it
    UIView *overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 1024, 768)];
    [self.view addSubview:overlay];
    [overlay release];
    
    img = [UIImage imageNamed:@"moon_title.png"];
    sz = [img size];
    frame = CGRectMake(150, 30, sz.width, sz.height);
    [self addImageToImageInPerspectiveView:pView img:img frame:frame imgTag:MOON];
}

- (void)createMoveableAssets {
    
    UIImageView *imgView;
    CGSize sz;
    UIImage *img;
    
    img = [UIImage imageNamed:@"spaceship.png"];
    imgView = [[UIImageView alloc] initWithImage:img];
    sz = [img size];
    [imgView setTag:ROCKET];
    [imgView setFrame:CGRectMake(70, 470, sz.width, sz.height)];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]
                                          initWithTarget:self 
                                          action:@selector(panDetected:)];
    [imgView addGestureRecognizer:panGesture];
    [panGesture release];
    [imgView setUserInteractionEnabled:YES];
    [self.view addSubview:imgView];
    
    startPoint = imgView.layer.position;
    NSLog(@"startPostion %f %f",startPoint.x, startPoint.y);
    
    [imgView release];
}

- (void)createHiddenAssets {
    
    UIImageView *imgView =  Nil;
    CGSize sz = CGSizeZero;
    UIImage *img = Nil;
    CGRect frame = CGRectNull;
    
    img = [UIImage imageNamed:@"catalogue-bg.png"];
    imgView = [[UIImageView alloc] initWithImage:img];
    sz = [img size];
    [imgView setFrame:CGRectMake(0, 0, sz.width, sz.height)];
    [imgView setBackgroundColor:[UIColor clearColor]];
    
    multiScrollView = [[RKMultipleScrollView alloc] initWithImageViewForBorderAndPosition:imgView position:CGPointMake(50, 30)];
    [multiScrollView setAlpha:0];
    [multiScrollView setHidden:YES];
    [multiScrollView setTag:TRIPLE_VIEW];
    [self.view addSubview:multiScrollView];
    [imgView release];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTaps:)];   
    img = [UIImage imageNamed:@"catalogue_arrows-red.png"];
    sz = img.size;
    frame = CGRectMake(0, 185, sz.width, sz.height);
    [self addImageToViewInSubview:self.view img:img frame:frame tag:TRIPLE_VIEW];
    
    img = [UIImage imageNamed:@"catalogue_arrows-orange.png"];
    sz = img.size;
    frame = CGRectMake(0, 385, sz.width, sz.height);
    [self addImageToViewInSubview:self.view img:img frame:frame tag:TRIPLE_VIEW];
    
    img = [UIImage imageNamed:@"catalogue_arrows-green.png"];
    sz = img.size;
    frame = CGRectMake(0, 545, sz.width, sz.height);
    [self addImageToViewInSubview:self.view img:img frame:frame tag:TRIPLE_VIEW];
    
    img = [UIImage imageNamed:@"title_text-catalogue.png"];
    sz = img.size;
    frame = CGRectMake(200, -10, sz.width, sz.height);
    [self addImageToViewInSubview:self.view img:img frame:frame tag:TRIPLE_VIEW]; 
    
    [tap release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad 
{ 
    [super viewDidLoad];
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 40)];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self];
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    [self createParallaxAssets];
    [self createStaticAssets];
    [self createMoveableAssets];
    [self createTextAssets];
    [self createHiddenAssets];
}

#pragma mark Delegate Methods

- (void)perspectiveScrollViewDidScroll:(IGEScrollViewPerspective *)scrollView {
    
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration{
    
}

#pragma mark Layer Methods

- (CGPoint)getPositionForLayerInSubview:(UIView *)containingView tag:(PictureTypes)tag {
    CGPoint tmp = CGPointZero;
    for ( UIImageView *iv in containingView.subviews) {
        if ([iv tag] == tag) {
            tmp = iv.layer.position;
        }
    }
    return tmp;
}

#pragma mark Animation Methods

- (void)imageViewFadeOut:(UIView *)iv fadeTime:(CGFloat)fadeTime {
    
    __block RKParallaxViewController *blockSelf = self;
    
    [UIView animateWithDuration:fadeTime 
                          delay:0 
                        options:UIViewAnimationOptionCurveEaseIn 
                     animations:^{
                         [iv setAlpha:0];
                     }
                     completion:^(BOOL finished) {
                         [blockSelf imageViewFadeIn:multiScrollView fadeTime:.5];
                     }];
}

- (void)imageViewFadeIn:(UIView *)iv fadeTime:(CGFloat)fadeTime {
    [UIView animateWithDuration:fadeTime 
                          delay:0 
                        options:UIViewAnimationOptionCurveEaseIn 
                     animations:^{
                         [iv setAlpha:1];
                     }
                     completion:NULL];
}

- (void)handlePanActionForRocket:(UIPanGestureRecognizer *)pan view:(UIView *)view{
    
    arrived = NO;
    
    CGPoint trans; 
    CGFloat deltaY = 70.0 / 500.0 ;
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            startPoint = [self getPositionForLayerInSubview:self.view tag:ROCKET];            
            NSLog(@"startpoint %f %f",startPoint.x, startPoint.y);
            startFrame = pan.view.frame;
            newFrame = pan.view.frame;
            break;
        case UIGestureRecognizerStateChanged:
            trans = [pan translationInView:self.view];
            newFrame.origin.x = startFrame.origin.x + trans.x;
            newFrame.origin.y = startFrame.origin.y - (trans.x * deltaY);
            pan.view.frame = newFrame;
            if (newFrame.origin.x >= 560) {
                newFrame.origin.x = 560;
                newFrame.origin.y = 402;
                pan.view.frame = newFrame;
                arrived = YES;
                break;
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (newFrame.origin.x >= 560) {
                newFrame.origin.x = 560;
                newFrame.origin.y = 402;
                pan.view.frame = newFrame;
                arrived = YES;
                break;
            }
            else {
                //animate the rocket back to 'base' a la sliders
                //NOTE this is clunky and also glitches from certain postions when the
                //pangesturerecogniser state changes to released
//                CABasicAnimation *posAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
//                NSLog(@"pos:%f %f",pan.view.layer.position.x, pan.view.layer.position.y);
//                NSLog(@"pos:%f %f",startPoint.x, startPoint.y);
//                [posAnimation setFromValue:[NSValue valueWithCGPoint:pan.view.layer.position]];
//                
//                [posAnimation setToValue:[NSValue valueWithCGPoint:startPoint]];
//                [posAnimation setDuration:0.1335];
//                
//                [pan.view.layer setPosition:startPoint];
//                [pan.view.layer addAnimation:posAnimation forKey:@"position"];
                
                //NOTE For some reason the below implicit animation is not applied the transform takes place but instantaneously
//                [CATransaction begin];
//                [CATransaction setValue:[NSNumber numberWithDouble:100.0] forKey:kCATransactionAnimationDuration];
//                NSNumber *d = [NSNumber numberWithDouble:[CATransaction animationDuration]];
//                NSLog(@"animationtime: %f",[d doubleValue]);
//                    
//                    pan.view.layer.position = startPoint;
//                [CATransaction commit];
                
//The animation in a block works better but still a bit clunky the block fixes a lot of the issues however.
                [UIView animateWithDuration:0.11 
                                      delay:0 
                                    options:UIViewAnimationOptionCurveEaseInOut 
                                 animations:^{
                                     [pan.view setCenter:startPoint];
                                 }
                                 completion:^(BOOL finished) {
                                     //[blockSelf setLayerInSubviewHidden:mainView tag:tag];
                                     NSLog(@"fadin...");
                                 }];
            }
            break;
        default:
            break;
    }
}


- (void)replaceViewWithFadeOut:(UIView *)firstView secondView:(UIView *)secondView fadeDuration:(CGFloat)fadeDuration {
    
}




#pragma mark Gesture Methods

- (void)panDetected:(UIPanGestureRecognizer *)sender{
    
    NSLog(@"gesture recogniser");
    
    UIView *tmpRocketView = nil;
    UIView *tmpEarthView = nil;
    CGPoint currentPosition;
    
    for (UIView *v in self.view.subviews) {
        if (![v.subviews count]) {
            if ([v tag] == EARTH) {
                tmpEarthView = v;
            }
            if ([v tag] == ROCKET) {
                tmpRocketView = v;
            }
        }
    }
    
    if ( (tmpRocketView != nil) && (tmpEarthView != nil) ) {
        
        currentPosition = [sender locationInView:self.view];
        UIView *hitView = [self.view hitTest:currentPosition 
                                   withEvent:nil];
        
        if ([hitView isEqual:tmpRocketView]) {
            if (!arrived) {
                [self handlePanActionForRocket:sender view:hitView];
            }
            else{//the rocket has landed on earth
                for (UIImageView *img in self.view.subviews) {
                    if ([img tag] == ROCKET){
                        for (UIGestureRecognizer *recogniser in img.gestureRecognizers) {
                            [img removeGestureRecognizer:recogniser];
                        }
                    }
                }
                for (UIImageView *img in self.view.subviews) {
                    if ( [img tag] == ROCKET_ARROW ) {
                        [img setHidden:YES];
                    }
                }
                for (UIImageView *img in self.view.subviews) {
                    if ([img tag] == TITLE_TXT) {
                        [self imageViewFadeOut:img fadeTime:1.0];//note we call fade in from here
                        [multiScrollView setHidden:NO];
                    }
                }
            }
        }
        

    }
}

- (void)handleTaps:(UITapGestureRecognizer *)sender {
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

#pragma mark Accelerometer Methods


- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
    const float violence = 1.5;
    static BOOL beenhere;
    BOOL shake = FALSE;
    
    if (beenhere) return;
    beenhere = TRUE;
    if (acceleration.x > violence * .75 || acceleration.x < (-1.5* violence)) {
       shake = TRUE;
        NSLog(@"X:%f", acceleration.x);
    }
    if (acceleration.y > violence * .75 || acceleration.y < (-2 * violence)) {
        shake = TRUE;
         NSLog(@"Y:%f", acceleration.y);
    }
        
    if (acceleration.z > violence * 3 || acceleration.z < (-3 * violence))
        shake = TRUE;
    if (shake) {
        if (acceleration.x > 0) {
            CGPoint pt = CGPointMake(acceleration.x * 2, 0);
            //[pView setContentOffset:pt animated:YES];
        }
    } 
    beenhere = FALSE;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionBegan");

}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionEnded");

}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionCancelled");
}

#pragma mark Orientation Methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    return YES;
     return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end
