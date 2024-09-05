# Plane Ride

## About

This is a tweetcart demo for the [PICO-8 fantasy console](https://www.lexaloffle.com/pico-8.php)- a demo where all of the source code is 280 characters or less.

I made this on a plane ride over the Great Lakes. I wanted to make something that captured the geometric patterns of the farms on the ground, with the clouds casting shadows:

![Clouds over farms in New York](/media/farms_clouds.png)

Something as complicated as this photo would be a little hard to recreate in PICO-8 in just a couple hours, so I settled for a tweetcart demonstrating some cool effects.

These carts are licensed under [CC BY-NC-SA 4.0 license](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Manifest

- 'carts' : folder containing PICO-8 .p8 cartridges to be run in PICO-8
    - 'plane_ride.p8' : the original tweetcart posted to Twitter.
    - 'plane_ride_commented.p8' : modified version of the tweetcart with comments explaining the implementation.
- 'media' : media used in this markdown file.

[View the original Twitter post!](https://twitter.com/GunTurtle/status/1826435801535672493)

[Edit the tweetcart in PICO-8 Education Edition here!](https://pico-8-edu.com/?c=AHB4YQD8ANACgK4HJq5HRkFH50tHh26lJ0bBjC0NDiXF7E0OJA-gmgvmT7jhkKPvn0jCLLvl6ijtbHN68wgXP0HugUvie7zxCI9w_RtMHJNfM3D8whuUDxEm59fNyE3xTSv5ilVeIttwx8raWDd0V9O0STJTP8DAznlLXbEwN5U15hmTDhjL4mdY6pZquYFyqIgdufgKXba4128Ux6VVdV0y0g_stVU4N5foEpQWKMPFZ1hJ08k0KQw_3zRFuigYOqcZEEiGI2qXHmGoLc56Aw==&g=w-w-w-w1HQHw-w2Xw-w3Xw-w2HQH)

## How it works:

This tweetcart is a scrolling Voronoi pattern, with some modifications.

A Voronoi pattern is a pattern where seed points are randomly placed on a plane. Each seed has a corresponding cell, where every point in the cell is closer to it seed than any other seed. Most Voronoi patterns use euclidean distance sqrt((x1-x2)^2+(y1-y2)^2), but my tweetcart uses Chebyshev distance min(x1-x2,y1-y2), which gives the cells more straight edges:

![A Chebyshev Voronoi diagram](/media/chebyshev_voronoi.png)

This is a Voronoi pattern using Chebyshev distance, each seed point is marked with a black dot.

Rendering a full-screen Voronoi pattern is too slow to do at 30fps, so I had my tweetcart render one column of pixels on the right side of the screen, and then copy the entire screen left one pixel each frame. This creates the scrolling effect seen in the final product. The x-axis is stretched when calculating distance, to give the demo an isometric perspective appearance.

The clouds are rendered last. At the end of each draw step, my tweetcart takes the entire screen and redraws any dark blue pixels as white, slightly above the original image. In other words, my tweetcart renders clouds above where it finds shadows, instead of rendering shadows where there are clouds.

The color palette here is another part of the demo I find interesting. Calling ``rnd(5)`` will make a pixel black, dark purple, dark blue, green, or brown. Blue, brown, and green seem like the most realistic colors for this- brown and green could be farmland, while blue would be shadows- but I decided the purple made an interesting addition. Black pixels don't show up in the final result- this is because they are drawn as transparent when the screen is copied to the left.

### Generating seed points:

A typical implementation for keeping track of seeds for a Voronoi diagram would be to create a table of seed objects, but the code to do that would take up too many characters to use in a tweetcart. The solution is to manipulate PICO-8's random number generation. The ``srand(x)`` function can be used to set the seed for PICO-8’s random number generator (different from seed points in the Voronoi pattern): calling ``srand(1)`` repeatedly will make the results of the following ``rnd()`` calls always return the same result. As a result, I was able to treat PICO-8's ``rnd()`` function as an infinite array of seed positions, where the index was the value I passed to ``srand()``. This probably wouldn't be a practical solution in most situations, because it relies on redundant calculation of where the seeds are.

Each pixel iterates through 16 seed points to determine its color. As the image scrolls, the range of seed 'indices' is changed: at the start, the range of indices is 0-15, after a few frames it becomes 1-16. The x position of a seed is just a multiple of its index, while the y position is randomized.

An interesting byproduct of my approach is that as the range of seed indices shifts, the boundaries of some cells may not be calculated correctly. When the range shifts, the leftmost cell will be removed from calculating a pixel's corresponding cell, so a 'seam' may appear between cells. I decided to keep this visual error in, because it made the 'farmland' in my tweetcart more rectangular, like in real life.
