source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

xcodeproj 'CityList.xcodeproj'

def myPods
pod 'AFNetworking', '= 2.6.0'
pod 'SnapKit', '= 0.22.0'
pod 'SVPullToRefresh'
pod 'MBProgressHUD'
pod 'SDWebImage'
end

target 'CityList' do
    myPods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
