Pod::Spec.new do |s|
  s.name         = "AnalyticsKit"
  s.version      = "3.0.0"

  s.summary      = "Analytics framework for iOS"

  s.description  = <<-DESC
                      The goal of AnalyticsKit is to provide a consistent API for analytics regardless of which analytics provider you're using behind the scenes.
                      The benefit of using AnalyticsKit is that if you decide to start using a new analytics provider, or add an additional one, you need to write/change much less code!
                  DESC

  s.homepage     = "https://github.com/Paktor/AnalyticsKit"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.authors      = { "Paktor Ltd" => "" }



  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/Paktor/AnalyticsKit.git", :tag => s.version.to_s }
  s.requires_arc = false

  s.subspec 'Core' do |core|
    core.source_files  = 'AnalyticsKit.swift', 'AnalyticsKitEvent.swift', 'AnalyticsKitProvider.swift', 'AnalyticsKitDebugProvider.swift', 'AnalyticsKitUnitTestProvider.swift', 'AnalyticsKit/AnalyticsKit/AnalyticsKitTimedEventHelper.swift'
  end

  s.subspec 'Intercom' do |i|
    i.source_files = 'Providers/Intercom/AnalyticsKitIntercomProvider.swift'
    i.frameworks = 'Intercom'
    i.dependency 'Intercom'
    i.dependency 'AnalyticsKit/Core'
    i.pod_target_xcconfig = {
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/Intercom/Intercom'
      # 'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
    }
  end

  s.subspec 'Crashlytics' do |c|
    c.source_files = 'Providers/Crashlytics/AnalyticsKitCrashlyticsProvider.swift'
    c.frameworks = 'Fabric', 'Crashlytics', 'Security', 'SystemConfiguration'
    c.libraries = 'c++', 'z'
    c.dependency 'Crashlytics'
    c.dependency 'AnalyticsKit/Core'
    c.pod_target_xcconfig = {
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/Crashlytics/iOS'
      # 'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
    }
  end

  s.subspec 'Firebase' do |f|
    f.source_files = 'Providers/Firebase/AnalyticsKitFirebaseProvider.swift'
    f.frameworks = 'FirebaseAnalytics', 'FirebaseCore', 'FirebaseInstanceID', 'FirebaseCoreDiagnostics', 'FirebaseNanoPB', 'nanopb'
    f.dependency 'AnalyticsKit/Core'
    f.dependency 'Firebase'
  end

  s.subspec 'AdjustIO' do |a|
    a.source_files = 'Providers/AdjustIO/AnalyticsKitAdjustIOProvider.swift'
    a.dependency 'Adjust', '~> 4.5'
    a.dependency 'AnalyticsKit/Core'
  end

  s.subspec 'Flurry' do |f|
    f.source_files = 'Providers/Flurry/AnalyticsKitFlurryProvider.swift'
    f.dependency 'Flurry-iOS-SDK/FlurrySDK'
    f.dependency 'AnalyticsKit/Core'
  end

  s.subspec 'Localytics' do |l|
    l.source_files = 'Providers/Localytics/AnalyticsKitLocalyticsProvider.swift'
    l.dependency 'Localytics'
    l.dependency 'AnalyticsKit/Core'
  end

  s.subspec 'Mixpanel' do |m|
    m.source_files = 'Providers/Mixpanel/AnalyticsKitMixpanelProvider.swift'
    m.dependency 'Mixpanel', '~> 3.1.4'
    m.dependency 'AnalyticsKit/Core'
  end

  s.subspec 'mParticle' do |n|
    n.source_files = 'Providers/mParticle/AnalyticsKitMParticleProvider.swift'
    n.dependency 'mParticle-Apple-SDK', '~> 6'
    n.dependency 'AnalyticsKit/Core'
  end

  s.subspec 'Parse' do |p|
    p.source_files = 'Providers/Parse/AnalyticsKitParseProvider.swift'
    p.dependency 'Parse'
    p.dependency 'AnalyticsKit/Core'
  end

  s.subspec 'AppsFlyer' do |a|
    a.source_files = 'Providers/AppsFlyer/AnalyticsKitAppsFlyerProvider.swift'
    a.framework = 'AppsFlyerLib'
    a.dependency 'AppsFlyerFramework', '~> 4.8'
    a.dependency 'AnalyticsKit/Core'
    a.pod_target_xcconfig = {
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/AppsFlyerFramework'
      # 'OTHER_LDFLAGS'          => '$(inherited) -undefined dynamic_lookup'
    }
  end

end
