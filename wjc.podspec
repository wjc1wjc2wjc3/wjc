#
# Be sure to run `pod lib lint wjc.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'wjc'
  s.version          = '0.2.0'
  s.summary          = 'generate tags and improve'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Add long description of the pod here.'
  s.homepage         = 'https://github.com/wjc1wjc2wjc3/wjc'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wjc1wjc2wjc3' => 'wjc1wjc2wjc3@163.com' }
  s.source           = { :git => 'https://github.com/wjc1wjc2wjc3/wjc.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'wjc/Classes/**/*'
  s.requires_arc = true
  # s.resource_bundles = {
  #   'wjc' => ['wjc/Assets/*.png']
  # }

  s.public_header_files = 'wjc/Classes/*.h'
  #s.public_header_files = 'Pod/Classes/**/*.h','Pod/Classes/*.h'
  s.frameworks = 'UIKit', 'MapKit','Foundation'
  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'MJExtension'
end
