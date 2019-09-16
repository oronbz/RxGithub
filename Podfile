# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RxGithub' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  # ignore all warnings from all pods
  inhibit_all_warnings!

  # Pods for RxGithub
  
  # DI
  pod 'Swinject', '2.6.2'
  pod 'SwinjectStoryboard'
  
  # Network
  pod 'Himotoki'
  pod 'Alamofire'
  
  # Rx
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxOptional'
  
  # Firebase
  pod 'Firebase/Core'
  pod 'Firebase/Database'

  # UI
  pod 'Spring', :git => 'https://github.com/MussaCharles/Spring.git'

  target 'RxGithubTests' do
    inherit! :search_paths
    # Pods for testing
    
    pod 'Quick'
    pod 'Nimble'
  end

end
