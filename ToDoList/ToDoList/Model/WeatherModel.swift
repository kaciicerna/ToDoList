//
//  WeatherModel.swift
//  ToDoList
//
//  Created by Kateřina Černá on 28.06.2023.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let code: Int
    let day, night: String
    let icon: Int
    let languages: [Language]
}

// MARK: - Language
struct Language: Codable {
    let langName: LangName
    let langISO: LangISO
    let dayText, nightText: String

    enum CodingKeys: String, CodingKey {
        case langName = "lang_name"
        case langISO = "lang_iso"
        case dayText = "day_text"
        case nightText = "night_text"
    }
}

enum LangISO: String, Codable {
    case ar = "ar"
    case bg = "bg"
    case bn = "bn"
    case cs = "cs"
    case de = "de"
    case el = "el"
    case es = "es"
    case fi = "fi"
    case fr = "fr"
    case hi = "hi"
    case hu = "hu"
    case it = "it"
    case ja = "ja"
    case jv = "jv"
    case ko = "ko"
    case mr = "mr"
    case nl = "nl"
    case pa = "pa"
    case pl = "pl"
    case pt = "pt"
    case ro = "ro"
    case ru = "ru"
    case si = "si"
    case sk = "sk"
    case sr = "sr"
    case sv = "sv"
    case ta = "ta"
    case te = "te"
    case tr = "tr"
    case uk = "uk"
    case ur = "ur"
    case vi = "vi"
    case zh = "zh"
    case zhCmn = "zh_cmn"
    case zhHsn = "zh_hsn"
    case zhTw = "zh_tw"
    case zhWuu = "zh_wuu"
    case zhYue = "zh_yue"
    case zu = "zu"
}

enum LangName: String, Codable {
    case arabic = "Arabic"
    case bengali = "Bengali"
    case bulgarian = "Bulgarian"
    case chineseSimplified = "Chinese Simplified"
    case chineseTraditional = "Chinese Traditional"
    case czech = "Czech"
    case dutch = "Dutch"
    case finnish = "Finnish"
    case french = "French"
    case german = "German"
    case greek = "Greek"
    case hindi = "Hindi"
    case hungarian = "Hungarian"
    case italian = "Italian"
    case japanese = "Japanese"
    case javanese = "Javanese"
    case korean = "Korean"
    case mandarin = "Mandarin"
    case marathi = "Marathi"
    case polish = "Polish"
    case portuguese = "Portuguese"
    case punjabi = "Punjabi"
    case romanian = "Romanian"
    case russian = "Russian"
    case serbian = "Serbian"
    case sinhalese = "Sinhalese"
    case slovak = "Slovak"
    case spanish = "Spanish"
    case swedish = "Swedish"
    case tamil = "Tamil"
    case telugu = "Telugu"
    case turkish = "Turkish"
    case ukrainian = "Ukrainian"
    case urdu = "Urdu"
    case vietnamese = "Vietnamese"
    case wuShanghainese = "Wu (Shanghainese)"
    case xiang = "Xiang"
    case yueCantonese = "Yue (Cantonese)"
    case zulu = "Zulu"
}

typealias Welcome = [WelcomeElement]
