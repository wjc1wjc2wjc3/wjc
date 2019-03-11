Pod::Spec.new do |s|
  s.name = "wjc"
  s.version = "0.1.0"
  s.summary = "A short description of wjc."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"wjc1wjc2wjc3"=>"wjc1wjc2wjc3@163.com"}
  s.homepage = "https://github.com/wjc1wjc2wjc3/wjc"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["UIKit", "MapKit", "Foundation"]
  s.requires_arc = true
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/wjc.framework'
end
