//
//  ViewController.m
//  MeetUP
//
//  Created by Alberto on 25/1/16.
//  Copyright © 2016 Geographica. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    WhirlyGlobeViewController *globeViewC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    globeViewC = [[WhirlyGlobeViewController alloc] init];
    [self.view addSubview:globeViewC.view];
    globeViewC.view.frame = self.view.bounds;
    [self addChildViewController:globeViewC];
    
    
    // we want a black background for a globe.
    globeViewC.clearColor = [UIColor blackColor];
    
    // and thirty fps if we can get it ­ change this to 3 if you find your app is struggling
    globeViewC.frameInterval = 2;
    
    // set up the data source
    MaplyMBTileSource *tileSource =
    [[MaplyMBTileSource alloc] initWithMBTiles:@"dec_map"];
    
    // set up the layer
    MaplyQuadImageTilesLayer *layer =
    [[MaplyQuadImageTilesLayer alloc] initWithCoordSystem:tileSource.coordSys
                                               tileSource:tileSource];
    layer.handleEdges = true;
    layer.coverPoles = true;
    layer.requireElev = false;
    layer.waitLoad = false;
    layer.drawPriority = 0;
    layer.singleLevelLoading = false;
    [globeViewC addLayer:layer];
    
    globeViewC.height = 0.8;
    
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
