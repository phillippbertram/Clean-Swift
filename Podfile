platform :ios, '9.0'
use_frameworks!

def rx_swift
  pod 'RxSwift'
end

target 'Clean' do
  # Pods for Clean
  rx_swift
  pod 'RxCocoa'

  target 'CleanTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Data' do
  # Pods for Data
  rx_swift

  target 'DataTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

target 'Domain' do
  # Pods for Domain
  rx_swift

  target 'DomainTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
