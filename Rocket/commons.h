//
//  commons.h
//  
//
//  Created by Tim Storey on 13/05/2011.
//
//  common data structures

#define RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))
#define DEGREES_TO_RADIANS(angle) ((angle * M_PI) / 180.0)


typedef enum {
    BACKGROUND,
    SUN,
    SMALL_STARS,
    BIG_STARS,
    SATURN,
    MOON,
    ROCKET,
    LINE,
    TXT,
    EARTH,
    MOON_LBL,
    EARTH_LBL,
    ROCKET_LBL,
    ROCKET_ARROW,
    TITLE_TXT,
    TRIPLE_VIEW,
    BUTTON_RED,
    BUTTON_ORANGE,
    BUTTON_GREEN
}PictureTypes;

typedef enum {
    TOP,
    MIDDLE,
    BASE
}ScrollViewOrderInView;