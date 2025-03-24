Pod::Spec.new do |s|
  s.name             = 'offline_captcha'
  s.version          = '0.0.1'
  s.summary          = 'Flutter offline CAPTCHA generator'
  s.description      = <<-DESC
A Flutter package for generating offline number-based CAPTCHAs with scribble effects
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
