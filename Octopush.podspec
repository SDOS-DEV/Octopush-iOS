@version = "4.0.3"
Pod::Spec.new do |spec|
  spec.platform     = :ios, '8.0'
  spec.name         = 'Octopush'
  spec.authors      = 'SDOS'
  spec.version      = @version
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/SDOS-DEV/Octopush-iOS'
  spec.summary      = 'Librería de Octopush para el envío de notificaciones push'
  spec.source       = { :git => "https://github.com/SDOS-DEV/Octopush-iOS.git", :tag => "v#{spec.version}" }
  spec.requires_arc = true
  spec.framework    = ['Security', 'UIKit', 'AudioToolbox', 'SystemConfiguration', 'Foundation', 'CoreGraphics']
  spec.resources    = 'src/Framework/Octopush.framework/OctopushBundle.bundle'
  spec.weak_frameworks = ['CoreLocation']
  spec.vendored_frameworks = 'src/Framework/Octopush.framework'

  spec.dependency 'OctopushShared'
end
