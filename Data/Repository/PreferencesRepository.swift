//
// Created by Phillipp Bertram on 26.04.17.
// Copyright (c) 2017 Phillipp Bertram. All rights reserved.
//

import Domain

final class UserDefaultsPreferences {

    fileprivate let userDefaults: UserDefaults

    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }

}

// MARK: - PreferencesRepositoryType

extension UserDefaultsPreferences: PreferencesRepositoryType {

    var appVersion: AppVersion {
        let version: String = {
            if let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String {
                return version
            }
            return ""
        }()

        let build: Int = {
            if let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
                if let intVersion = Int(build) {
                    return intVersion
                }
            }
            return 0
        }()

        return AppVersion(version: version, build: build)
    }

}
