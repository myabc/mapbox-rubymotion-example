class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    tab_bar_controller = UITabBarController.alloc.init
    view_controllers   = %w(online offline interactive).each_with_object([]) do |type, controllers|
      view_controller_class  = NSClassFromString("#{type.camelize}LayerViewController")
      view_controller = view_controller_class.alloc.initWithNibName(nil, bundle:nil)
      view_controller.tabBarItem = UITabBarItem.alloc.initWithTitle("#{type.capitalize} Layer",
                                  image:nil, tag:0)
      controllers << view_controller
    end
    tab_bar_controller.viewControllers = view_controllers
    @window.rootViewController = tab_bar_controller
    @window.makeKeyAndVisible
    true
  end
end
