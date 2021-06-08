# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'Weather2021' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Firestore'
  pod 'Firebase/Firestore'
  pod 'Alamofire'	
  pod 'AlamofireObjectMapper', '~> 5.2'

  # Pods for Weather2021

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
