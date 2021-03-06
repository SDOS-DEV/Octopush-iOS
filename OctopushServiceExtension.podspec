@version = "4.2.0"
Pod::Spec.new do |spec|
  spec.platform     = :ios, '8.0'
  spec.name         = 'OctopushServiceExtension'
  spec.authors      = 'SDOS'
  spec.version      = @version
  spec.license      = { :type => 'BSD' }
  spec.homepage     = 'https://github.com/SDOS-DEV/Octopush-iOS'
  spec.summary      = 'Librería de Octopush para el envío de notificaciones push'
  spec.source       = { :git => "https://github.com/SDOS-DEV/Octopush-iOS.git", :tag => "v#{spec.version}" }
  spec.requires_arc = true
  spec.framework    = ['Foundation']
  spec.vendored_frameworks = 'src/Framework/OctopushServiceExtension.framework'

  spec.dependency 'OctopushShared'
end
