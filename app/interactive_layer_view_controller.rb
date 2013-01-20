class InteractiveLayerViewController < UIViewController

  def viewDidLoad
    super

    interactice_source  = RMMapBoxSource.alloc.initWithMapID('examples.map-zmy97flj')
    map_view            = RMMapView.alloc.initWithFrame(self.view.bounds, andTilesource:interactice_source)
    map_view.delegate   = self
    map_view.zoom       = 2
    map_view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth
    map_view.adjustTilesForRetinaDisplay = true

    self.view.addSubview(map_view)
  end

  def singleTapOnMap(map_view, at:point)
    NSLog 'Single Tap'

    map_view.removeAllAnnotations
    source = map_view.tileSource

    # FIXME: How should this be implemented? source.conformsToProtocol(RMInteractiveSource)
    if source.supportsInteractivity
      formatted_output = source.formattedOutputOfType(RMInteractiveSourceOutputTypeTeaser,
        forPoint:point, inMapView:map_view)

      if formatted_output && !formatted_output.empty?
        # parse the country name out of the content
        country_name_start = formatted_output.index('<strong>') + '<string>'.length
        country_name_end   = formatted_output.index('</strong>')
        country_name       = formatted_output.slice(country_name_start, country_name_end - country_name_start)

        # parse the flag image out of the content
        flag_image_start = formatted_output.index('base64,') + 'base64,'.length
        flag_image_end   = formatted_output.index("\" style")
        flag_image       = UIImage.imageWithData(
                             NSData.dataFromBase64String(formatted_output.slice(flag_image_start, flag_image_end))
                           )

        annotation = RMAnnotation.annotationWithMapView(map_view, coordinate:map_view.pixelToCoordinate(point), andTitle:country_name)
        annotation.userInfo = flag_image

        map_view.addAnnotation(annotation)
        map_view.selectAnnotation(annotation, animated:true)
      end
    end
  end

  def mapView(map_view, layerForAnnotation:annotation)
    marker     = RMMarker.alloc.initWithMapBoxMarkerImage('embassy')
    image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 50, 32))
    image_view.contentMode  = UIViewContentModeScaleAspectFit
    image_view.image        = annotation.userInfo
    marker.leftCalloutAccessoryView = image_view
    marker
  end

end
