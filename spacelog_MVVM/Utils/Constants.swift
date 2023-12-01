//
//  Constants.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/11/08.
//

import Foundation

struct Constants{
    static let Assetname = Asset_Name.self
    static let Texts = Text.self
}

enum Text{
    static let placeHolder = "이 공간에 대해 더 알려주실 내용이 있나요?\n없다면 작성하지 않아도 괜찮아요."
}

enum Asset_Name{
    static let Fonts = Font.self
    static let Colors = Color.self
    static let Images = Image.self
}

enum Font {
  static let Bold = "GowunBatang-Bold"
  static let Regular = "GowunBatang-Regular"
}

enum Color{
    static let Accent = "accent"
    enum Text{
        static let Primary = "primaryText"
        static let Secondary = "secondaryText"
        static let Inverted = "invertedText"
        static let Tertiary = "tertiaryText"
    }
    enum Content{
        static let Primary = "primaryContent"
        static let Secondary = "secondaryContent"
        static let Tertiary = "tertiaryContent"
    }
    enum FAB{
        static let Primary = "primaryFAB"
        static let Secondary = "secondaryFAB"
    }
}

enum Image{
    enum Symbol{
        static let Menu = "symbols_menu"
        static let Search = "symbols_search"
        static let Camera = "symbols_camera"
        static let GPS = "symbols_GPS"
        static let myLocation = "symbols_mylocation"

    }
    enum Marker{
        static let frame = "img_frame_rect"
        static let frame_camera = "img_frame_circle"
    }

}



