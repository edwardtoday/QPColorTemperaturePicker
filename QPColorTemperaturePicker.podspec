Pod::Spec.new do |s|
  s.name         = "QPColorTemperaturePicker"
  s.version      = "0.1.2"
  s.summary      = "iPhone color temperature picker view with brightness control and delegation support."
  s.description  = <<-DESC
                   iPhone color temperature picker view with brightness control and delegation support.
                   DESC
  s.homepage     = "https://github.com/edwardtoday/QPColorTemperautrePicker"
  s.screenshots  = "https://raw.githubusercontent.com/edwardtoday/QPColorTemperaturePicker/v0.1.2/Example01.png", "https://raw.githubusercontent.com/edwardtoday/QPColorTemperaturePicker/v0.1.2/Example02.png", "https://raw.githubusercontent.com/edwardtoday/QPColorTemperaturePicker/v0.1.2/Example03.png", "https://raw.githubusercontent.com/edwardtoday/QPColorTemperaturePicker/v0.1.2/Example04.png"
  s.license      = { :type => 'BSD', :file => "LICENSE.md" }
  s.author       = { "Pei" => "edwardtoday@gmail.com" }
  s.source       = { :git => "https://github.com/edwardtoday/QPColorTemperaturePicker.git", :tag => "v0.1.2" }
  s.platform     = :ios, '6.0'
  s.source_files = 'QPColorTemperaturePicker/ColorPickerClasses/**/*.{h,m}'
  s.frameworks   = 'QuartzCore', 'CoreGraphics', 'UIKit', 'Accelerate'
  s.requires_arc = true

  s.public_header_files = "QPColorTemperaturePicker/ColorPickerClasses/QPColorTemperaturePickerView.h"
end
