#
# Be sure to run `pod lib lint TimeLineView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TimeLineView'
  s.version          = '0.1.0'
  s.summary          = 'TimeLineView lets user expand and collapse items grid inside table view cells, having one main scroll outside.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TimeLineView lets user expand and collapse items grid inside table view cells, having one main scroll outside. If you are will be using it, you just need it pass your titles, sub-titles array, also you need to provide the dictionary values for the items.'

  s.homepage         = 'https://github.com/dev-shanghai/TimeLineView.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'iamasimkhanjadoon@gmail.com' => 'asim2125Khan' }
  s.source           = { :git => 'https://github.com/iamasimkhanjadoon@gmail.com/TimeLineView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'TimeLineView/Classes/**/*'
  s.swift_versions = '5.0'
  
  # s.resource_bundles = {
  #   'TimeLineView' => ['TimeLineView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
