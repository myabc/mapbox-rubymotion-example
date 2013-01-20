# XXX: This initializer was addded to the SDK in commit e0f2ea4 and is not yet
# available as a released CocoaPod.
# See https://github.com/mapbox/mapbox-ios-sdk/commit/e0f2ea44bf58dca7fb83a977ede71f3fff08eb80
RMMBTilesSource.class_eval do
  def initWithTileSetResource(name, ofType:extension)
    self.initWithTileSetURL(NSURL.fileURLWithPath(NSBundle.mainBundle.pathForResource(name, ofType:extension)))
  end
end

class OfflineLayerViewController < UIViewController

  def viewDidLoad
    super

    offline_source  = RMMBTilesSource.alloc.initWithTileSetResource('control-room-0.2.0', ofType:'mbtiles')
    map_view        = RMMapView.alloc.initWithFrame(self.view.bounds, andTilesource:offline_source)
    map_view.zoom   = 2
    map_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    map_view.adjustTilesForRetinaDisplay = true

    self.view.addSubview(map_view)
  end

end
