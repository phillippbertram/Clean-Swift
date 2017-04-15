platform :ios, '9.0'

def rx_swift
  pod 'RxSwift'
end

def logging
  pod 'SwiftyBeaver', '~> 1.1.4'
end

def testing
  pod 'Quick', '~> 1.1.0'
  pod 'Nimble', '~> 6.1.0'
  pod 'RxTest', '~> 3.3.1'
end

target 'Clean-Swift' do
  use_frameworks!

  # Pods for Clean
  rx_swift
  logging
  pod 'RxCocoa'
  pod 'Action'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'Material'
  pod 'R.swift', '~> 3.2.0'
  pod 'SwiftLint'

  target 'Clean-SwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Data' do
  use_frameworks!

  # Pods for Data
  rx_swift
  logging
  pod 'RealmSwift'

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
