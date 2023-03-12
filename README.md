# photofetch

A simple flutter application for viewing photos using restapi.

## Getting Started
please read the complete documentation for full understanding...

This is a simple photo viewing application made with flutter.
Currently android functionalities are only integrated 


flutter version : 3.3.9
app version : 1.0.0+1

## Technical features : 

- RESTAPI integrated with 'http' package
- state management handled using 'provider'
- data optimisation and reloading is controlled using 'cached_network_image' package //same image wont be reloaded twice, instead it will be cached to      storage and is used later
- storage permissions for data caching is obtained by 'permission_handler'

## App detailed work flow

First screen : 
splash screen with app logo and loader

Second screen : 
homescreen with image grid/
two types of grid views are present and user can change the gridview by tapping the grid icon on appbar
low quality thumbnail photos are shown on each grid,
and a high quality detailed view of the image with title can be seen when the image is opened

Third screen : 
Detailed view of pho is shown in this screen 
Two types of view of the image can be seen here and this can be controlled by the expanded icon
at the end of title




