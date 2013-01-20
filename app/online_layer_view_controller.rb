class OnlineLayerViewController < UIViewController
  NORMAL_MAP_ID = 'examples.map-z2effxa8'
  RETINA_MAP_ID = 'examples.map-zswgei2n'

  def viewDidLoad
    super

    online_source = RMMapBoxSource.alloc.initWithMapID(Device.retina? ? RETINA_MAP_ID : NORMAL_MAP_ID)
    map_view      = RMMapView.alloc.initWithFrame(self.view.bounds, andTilesource:online_source)
    map_view.zoom = 2
    map_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth

    self.view.addSubview(map_view)
  end

end
