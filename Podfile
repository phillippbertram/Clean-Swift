platform :ios, '9.0'

def rx_swift
  pod 'RxSwift', '~> 3.4.0'
  pod 'RxSwiftExt', '~> 2.4.1'
end

def rx_cocoa
  pod 'RxCocoa', '~> 3.4.0'
end

def logging
  pod 'SwiftyBeaver', '~> 1.2.0'
end

def testing
  pod 'Quick', '~> 1.1.0'
  pod 'Nimble', '~> 6.1.0'
  pod 'RxTest', '~> 3.4.0'
end

target 'Clean-Swift' do
  use_frameworks!

  # Pods for Clean
  rx_swift
  rx_cocoa
  logging
  pod 'Action', '~> 2.2.2'
  pod 'Swinject', '~> 2.0.0'
  pod 'SwinjectStoryboard', '~> 1.0.0'
  pod 'Material', '~> 2.6.3'
  pod 'R.swift', '~> 3.2.0'
  pod 'SwiftLint', '~> 0.18.1'

  target 'Clean-SwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Data' do
  use_frameworks!

  # Pods for Data
  rx_swift
  rx_cocoa
  logging

  pod 'RealmSwift', '~> 2.5.1'
  pod 'RxRealm', '~> 0.6.0'

  target 'DataTests' do
    inherit! :search_paths
    # Pods for testing
    testing
  end

end

target 'Domain' do
  use_frameworks!
  
  # Pods for Domain
  rx_swift
  logging

  target 'DomainTests' do
    inherit! :search_paths
    # Pods for testing
    testing
  end

end

target 'Common' do
  use_frameworks!

  # Pods for Common
  logging

  target 'CommonTests' do
    inherit! :search_paths
    # Pods for testing
    testing
  end

end
