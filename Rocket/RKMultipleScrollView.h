//
//  RKMultipleScrollView.h
//  Rocket
//
//

#import <UIKit/UIKit.h>
#import "commons.h"

@interface RKMultipleScrollView : UIView  {
    UIScrollView *localScrollViewTop;
    UIScrollView *localScrollViewMid;
    UIScrollView *localScrollViewBase;
    
    NSMutableArray *hats;
    NSMutableArray *dresses;
    NSMutableArray *shoes;
    
}

@property (nonatomic, retain)UIScrollView *localScrollView;


- (void)addImageViewToScrollViewAtPlaceInView:(UIImageView *)img where:(ScrollViewOrderInView )where;

- (void)createScrollViewAtPosition:(CGPoint)position size:(CGSize)size placeInView:(ScrollViewOrderInView)placeInView;

- (id)initWithImageViewForBorderAndPosition:(UIImageView *)iv position:(CGPoint)position;


@end
