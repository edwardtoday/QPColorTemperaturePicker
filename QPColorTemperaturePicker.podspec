Pod::Spec.new do |s|
  s.name         = "QPColorTemperaturePicker"
  s.version      = "0.1.0"
  s.summary      = "iPhone color temperature picker view with brightness control and delegation support."
  s.description  = <<-DESC
                   iPhone color temperature picker view with brightness control and delegation support.
                   DESC
  s.homepage     = "https://github.com/edwardtoday/RSColorPicker"
  s.screenshots  = "https://raw.github.com/edwardtoday/QPColorTemperautrePicker/Example01.png", "https://raw.github.com/edwardtoday/QPColorTemperautrePicker/Example02.png", "https://raw.github.com/edwardtoday/QPColorTemperautrePicker/Example03.png", "https://raw.github.com/edwardtoday/QPColorTemperautrePicker/Example04.png"
  s.license      = { :type => 'BSD', :file => "LICENSE.md" }
  s.author       = { "Pei" => "edwardtoday@gmail.com" }
  s.source       = { :git => "https://github.com/edwardtoday/QPColorTemperaturePicker.git"}
  s.platform     = :ios, '6.0'
  s.source_files = 'QPColorTemperaturePicker/ColorPickerClasses/**/*.{h,m}'
  s.frameworks   = 'QuartzCore', 'CoreGraphics', 'UIKit', 'Accelerate'
  s.requires_arc = true

  s.public_header_files = "QPColorTemperaturePicker/ColorPickerClasses/QPColorTemperaturePickerView.h"
end
