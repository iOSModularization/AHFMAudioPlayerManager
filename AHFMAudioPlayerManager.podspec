#
# Be sure to run `pod lib lint AHFMAudioPlayerManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AHFMAudioPlayerManager'
  s.version          = '0.2.2'
  s.summary          = 'A short description of AHFMAudioPlayerManager.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/iOSModularization/AHFMAudioPlayerManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ivsall2012' => 'ivsall2012@gmail.com' }
  s.source           = { :git => 'https://github.com/iOSModularization/AHFMAudioPlayerManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AHFMAudioPlayerManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AHFMAudioPlayerManager' => ['AHFMAudioPlayerManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
s.dependency 'AHAudioPlayer'
s.dependency 'AHFMModuleManager'
s.dependency 'AHFMDataCenter'
s.dependency 'AHFMDataTransformers'
s.dependency 'SDWebImage'
end
