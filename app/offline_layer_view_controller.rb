class OfflineLayerViewController < UIViewController

  def viewDidLoad
    super

    # Convenience method available from mapbox-ios-sdk commit e0f2ea4
    #offline_source  = RMMBTilesSource.alloc.initWithTileSetResource('control-room-0.2.0', ofType:'mbtiles')
    offline_source  = init_tiles_source_with_tile_set_resource('control-room-0.2.0', ofType:'mbtiles')
    map_view        = RMMapView.alloc.initWithFrame(self.view.bounds, andTilesource:offline_source)
    map_view.zoom   = 2
    #map_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    map_view.adjustTilesForRetinaDisplay = true

    self.view.addSubview(map_view)
  end

  private

  def init_tiles_source_with_tile_set_resource(name, ofType:extension)
    RMMBTilesSource.alloc.initWithTileSetURL(NSURL.fileURLWithPath(NSBundle.mainBundle.pathForResource(name, ofType:extension)))
  end

end
