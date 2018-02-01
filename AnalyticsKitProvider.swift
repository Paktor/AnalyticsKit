//
//  AnalyticsKitProvider.swift
//  AnalyticsKit
//
//  Created by Kirill Kunst on 01/02/2018.
//

import Foundation

public protocol AnalyticsKitProvider
{
    func applicationWillEnterForeground()
    func applicationDidEnterBackground()
    func applicationWillTerminate()
    func uncaughtException(_ exception: NSException)
    func logScreen(_ screenName: String)
    func logScreen(_ screenName: String, withProperties properties: [String: Any])
    func logEvent(_ event: String)
    func logEvent(_ event: String, withProperty key: String, andValue value: String)
    func logEvent(_ event: String, withProperties properties: [String: Any])
    func logEvent(_ event: String, timed: Bool)
    func logEvent(_ event: String, withProperties properties: [String: Any], timed: Bool)
    func endTimedEvent(_ event: String, withProperties properties: [String: Any])
    func logError(_ name: String, message: String?, exception: NSException?)
    func logError(_ name: String, message: String?, error: Error?)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions
                        launchOptions: [String : Any]?)
    func filteredProperties(params: [String: Any]) -> [String: Any]
    var ignoredProperties: [String] { get }

    func setConfiguration(configuration: (AnalyticsKitProvider) -> ())
}

extension AnalyticsKitProvider
{
    public func applicationWillEnterForeground() { }
    public func applicationDidEnterBackground() { }

    public func application(_ application: UIApplication,
                           didFinishLaunchingWithOptions launchOptions: [String : Any]?)
    {

    }

    public func filteredProperties(params: [String : Any]) -> [String : Any]
    {
        var parameters: [String:AnyObject] = [:]
        for (label, value) in params
        {
            if !self.ignoredProperties.contains(label)
            {
                parameters[label] = String(describing: value) as NSString
            }
        }
        return parameters
    }

    public var ignoredProperties: [String]
    {
        return []
    }

    public func setConfiguration(configuration: (AnalyticsKitProvider) -> ())
    {
        configuration(self)
    }

}
