//
//  Functions.swift
//  MarinesMusic
//
//  Created by shusuke imamura on 2023/10/15.
//

import Foundation

enum PrefKeys: String {
    case isModalClickToStop = "isModalClickToStop"
    case isDuckOthers = "isDuckOthers"
    case isArrowBackground = "isArrowBackground"
    case isStopOtherAppSound = "isStopOtherAppSound"

    case favorites = "favorites"
}

func getPref(forKey: PrefKeys) -> Bool {
    return UserDefaults.standard.bool(forKey: forKey.rawValue)
}

func setPref(forKey: PrefKeys, value: Bool) {
    UserDefaults.standard.set(value, forKey: forKey.rawValue)
}

func getFavorites() -> [Int] {
    return UserDefaults.standard.array(forKey: PrefKeys.favorites.rawValue) as? [Int] ?? [Int]()
}

func setFavorite(id: Int) -> [Int] {
    var array = getFavorites()
    if array.contains(id) {
        array.remove(at: array.firstIndex(of: id)!)
    } else {
        array.append(id)
    }
    UserDefaults.standard.set(array, forKey: PrefKeys.favorites.rawValue)

    return array
}

func getData() -> [Player] {
    return load("Eagles.json")
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
