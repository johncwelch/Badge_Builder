# Badge_Builder
Script I made to automate printing large numbers of ID Badges in InDesign

So this is not really something that I would say is "industrial strength" but it does work. If you have a large number of badges, each trip takes slightly longer depending on how long the inner loop has to search for a file.

However, keep in mind, the badge printer I use takes 45 seconds to print a single badge, and it doesn't have a feeder, so I have to remove and add cards manually one at a time. List Traversal is NOT the delaying factor here. Also, telling InDesign to print is oddly fragile, so if you have a card printer with a feeder, you may want to add a delaying step in.

Really, this is more of a collection of things for InDesign, like changing the name in a text frame and relinking image files. 
