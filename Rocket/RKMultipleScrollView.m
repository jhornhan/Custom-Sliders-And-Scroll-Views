//
//  RKMultipleScrollView.m
//  
//
//

#import "RKMultipleScrollView.h"




@implementation RKMultipleScrollView

@synthesize localScrollView;

#pragma mark Initialisation Methods

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)doInit {
    
    UIImage *img;
    UIImageView *iv;
    CGSize sz;
    CGRect frame;
    frame = self.frame;
    
    localScrollViewTop = [[UIScrollView alloc] init];
    localScrollViewTop.scrollsToTop = NO;
    localScrollViewTop.showsHorizontalScrollIndicator = NO;
    localScrollViewTop.showsVerticalScrollIndicator = NO;
    [localScrollViewTop setFrame:CGRectMake(70,144,160,160)];
    [localScrollViewTop setContentSize:CGSizeMake(160 * 3, 160)];
    [localScrollViewTop setPagingEnabled:YES];
    [self addSubview:localScrollViewTop];
    [self sendSubviewToBack:localScrollViewTop];
    
    localScrollViewMid = [[UIScrollView alloc] init];
    localScrollViewMid.scrollsToTop = NO;
    localScrollViewMid.showsHorizontalScrollIndicator = NO;
    [localScrollViewMid setFrame:CGRectMake(70,312,160,220)];
    [localScrollViewMid setContentSize:CGSizeMake(160 * 3, 220)];
    [localScrollViewMid setPagingEnabled:YES];
    [self addSubview:localScrollViewMid];
    [self sendSubviewToBack:localScrollViewMid];

    localScrollViewMid.showsVerticalScrollIndicator = NO;
    
    localScrollViewBase = [[UIScrollView alloc] init];
    localScrollViewBase.scrollsToTop = NO;
    localScrollViewBase.showsHorizontalScrollIndicator = NO;
    localScrollViewBase.showsVerticalScrollIndicator = NO;
    [localScrollViewBase setFrame:CGRectMake(70,538,160,75)];
    [localScrollViewBase setContentSize:CGSizeMake(160 * 3, 75)];
    [localScrollViewBase setPagingEnabled:YES];
    [self addSubview:localScrollViewBase];
    [self sendSubviewToBack:localScrollViewBase];

    
    hats = [[NSMutableArray alloc] init];
    shoes = [[NSMutableArray alloc] init];
    dresses = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 3; i++) {
        NSString *name = [NSString stringWithFormat:@"hat%d.jpg",i];
        img = [UIImage imageNamed:name];
        sz = img.size;
        iv = [[UIImageView alloc] initWithImage:img];
        [iv setFrame:CGRectMake(sz.width * i, 0, sz.width, sz.height)];
        [localScrollViewTop addSubview:iv];
        [iv release];
        
        name = [NSString stringWithFormat:@"dress%d.jpg",i];
        img = [UIImage imageNamed:name];
        sz = img.size;
        iv = [[UIImageView alloc] initWithImage:img];
        [iv setFrame:CGRectMake(sz.width * i, 0, sz.width, sz.height)];
        [localScrollViewMid addSubview:iv];
        [iv release];
        
        name = [NSString stringWithFormat:@"shoe%d.jpg",i];
        img = [UIImage imageNamed:name];
        sz = img.size;
        iv = [[UIImageView alloc] initWithImage:img];
        [iv setFrame:CGRectMake(sz.width * i, 0, sz.width, sz.height)];
        [localScrollViewBase addSubview:iv];
        [iv release];
    }

}

- (id)initWithImageViewForBorderAndPosition:(UIImageView *)iv position:(CGPoint)position {
    
    CGRect newFrame = iv.frame;
    newFrame.origin.x = position.x;
    newFrame.origin.y = position.y;
    [iv setFrame:newFrame];
    
    self = [super initWithFrame:newFrame];
    if (self) {
        [self addSubview:iv];
        [self doInit];
    }
    return self;
}

- (void)createScrollViewAtPosition:(CGPoint)position size:(CGSize)size placeInView:(ScrollViewOrderInView)placeInView {
    
    switch (placeInView) {
        case TOP:
            
            break;
        case MIDDLE:
            
            break;
        case BASE:
            
            break;
        default:
            break;
    }
    
}

#pragma mark Setup Methods

- (void)addImageViewToScrollViewAtPlaceInView:(UIImageView *)img where:(ScrollViewOrderInView)where {
    
    switch (where) {
        case TOP:
            [localScrollViewTop addSubview:img];
            break;
        case MIDDLE:
            
            break;
        case BASE:
            
            break;
        default:
            break;
    }
}

- (void)dealloc
{
    [localScrollViewBase release];
    [localScrollViewMid release];
    [localScrollViewTop release];
    [hats release];
    [shoes release];
    [dresses release];
    [super dealloc];
}

@end
