Pod::Spec.new do |spec|

  spec.name         = "SocialSignInKit"

  spec.version      = "1.0.0"

  spec.summary      = "SocialSignInKit is multiple social sign-in kit. Support to Apple, Google and Facebook."

  spec.description  = <<-DESC
   SocialSignInKit is multiple social sign-in kit. Support to Apple, Google and Facebook sign-in integration in our app.
                   DESC

  spec.homepage     = "https://github.com/NikhilKothawale/SocialSignInKit"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Nikhil Kothawale" => "kothavale.nikhil95@gmail.com" }

  spec.source       = { :git => "https://github.com/NikhilKothawale/SocialSignInKit.git", :tag => "#{spec.version}" }

  spec.platform     = :ios
  spec.ios.deployment_target = "13.0" 

  spec.swift_version = "4.2" 

  spec.source_files  = "SocialSignInKit/**/*.{h,m,swift}"

end
