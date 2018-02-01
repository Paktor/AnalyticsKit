# AnalyticsKit

The goal of `AnalyticsKit` is to provide a consistent API for analytics regardless of the provider. With `AnalyticsKit`, you just call one logging method and `AnalyticsKit` relays that logging message to each registered provider. AnalyticsKit works in both Swift and Objective-C projects.

## Supported Providers

* [AdjustIO](https://www.adjust.io/)
* [Apsalar](http://apsalar.com/)
* [Crashlytics](http://crashlytics.com)
* [Firebase Analytics](https://firebase.google.com/products/analytics/)
* [Flurry](http://www.flurry.com/)
* [Google Analytics](https://www.google.com/analytics)
* [Localytics](http://www.localytics.com/)
* [Mixpanel](https://mixpanel.com/)
* [mParticle](https://www.mparticle.com)
* [Parse](http://parse.com/)
* [Mobile Center](https://docs.microsoft.com/en-us/mobile-center/)
* [Firebase Analytics](https://firebase.google.com/products/analytics/)
* [Debug Provider](https://github.com/twobitlabs/AnalyticsKit/blob/master/AnalyticsKitDebugProvider.swift) - shows an AlertView whenever an error is logged
* [Unit Test Provider](https://github.com/twobitlabs/AnalyticsKit/blob/master/AnalyticsKit/AnalyticsKit/AnalyticsKitUnitTestProvider.swift) - allows you to inspect logged events


## How to Use

## Installation

AnalyticsKit is available through [CocoaPods](http://cocoapods.org).

First, add the repo to your cocoapods repos:

```
pod repo add AnalyticsKit https://github.com/Paktor/AnalyticsKit.git
```

Then, add this repo as a source in your podfile:

```ruby
source 'https://github.com/Paktor/AnalyticsKit'
```

To install it, simply add the following line to your Podfile:

```ruby
pod 'AnalyticsKit', :subspecs => ["Crashlytics", "Firebase"]
```
You can add any of the providers you want to use inside the *subspecs* array.

## Usage
Swift:

Initialize AnalyticsKit in application:didFinishLaunchingWithOptions:

```swift
AnalyticsKit.initializeProviders([AnalyticsKitFlurryProvider(withAPIKey: flurryKey)])
```

Depending on which analytics providers you use you may need to include the following method calls in your app delegate (or just go ahead and include them to be safe):

```swift
AnalyticsKit.applicationWillEnterForeground()
AnalyticsKit.applicationDidEnterBackground()
AnalyticsKit.applicationWillTerminate]()
```


### Channels

`AnalyticsKit` supports grouping analytics providers together into separate channels. If your primary providers is Flurry but you also want to log certain separate events to Google Analytics you can setup `AnalyticsKit` to log events following the instructions above and then setup a separate channel for Google Analytics as follows:

```swift
// In didFinishLaunchingWithOptions you could configure a separate channel of providers
AnalyticsKit.channel("google").initializeProviders([AnalyticsKitGoogleAnalyticsProvider(withTrackingID: trackingId)])

// Then later in your code log an event to that channel only
AnalyticsKit.channel("google").logEvent("some event")
```


## Contributors
 - [Two Bit Labs](http://twobitlabs.com/)
 - [Kirill Kunst](https://github.com/leoru)
