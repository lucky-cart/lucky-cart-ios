//
//  LCServerModel+Debug.swift
//
//  LuckyCart Framework - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 12/01/2022.
//

import Foundation

/// Static test objects ready to use in SwiftUI previews, UI Tests and Unit Tests

extension Model {
    
    static let testGame = Model.Game(code: "QLWG-SHYR-MGBZ-SLXK",
                                     isGamePlayable: true,
                                     gameResult: .notPlayed,
                                     desktopGameUrl: URL(string: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/desktop/url")!,
                                     desktopGameImage: URL(string: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/desktop/image")!,
                                     mobileGameUrl: URL(string: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/mobile/url")!,
                                     mobileGameImage: URL(string: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/mobile/image")!
    )
    
    static let testBannerSpaces:  [String : [String]] = [
        LCBannerSpaceIdentifier.homePage.rawValue : ["banner"] ,
        "categories": ["banner_100",
                       "banner_200",
                       "search_100",
                       "search_200"
                      ]]
    
    static let testCustomer = Model.Customer(id: "customer1234")
    
    static let testCart = Model.Cart(id: "cart_1234")
    
    static let testBanner = Model.Banner(image_url: URL( string: "\(promoMatchingURLTest)/image?meta=61bb057807879bee01ed5298&test=true&noCache1641942555414")!,
                                         redirect_url: URL(string: "\(promoMatchingURLTest)/jump?meta=61bb057807879bee01ed5298&test=true")!,
                                         name: "QA ITW Assessment",
                                         campaign: "61bb057807879bee01ed5298",
                                         space: "61d6c677baa1676dd46bfee6",
                                         action: Model.BannerAction(type: "boutique", ref: ""))
    
    static let promoMatchingURLTest = "https://promomatching.luckycart.com/61d6c677baa1676dd46bfee6/customer_1234"
                                                                              
    static let testPostCartResponse = PostCartResponse(ticket: "QLWG-SHYR-MGBZ-SLXK",
                                                       mobileUrl: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/mobile/url",
                                                       tabletUrl: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/tablet/url",
                                                       desktopUrl: "https://api.luckycart.com/replacement/QLWG-SHYR-MGBZ-SLXK/desktop/url",
                                                       baseMobileUrl: "https://go.luckycart.com/mobile/QLWG-SHYR-MGBZ-SLXK",
                                                       baseTabletUrl: "https://go.luckycart.com/tablet/QLWG-SHYR-MGBZ-SLXK",
                                                       baseDesktopUrl: "https://go.luckycart.com/lc__team__qa/NX5PDN/play/QLWG-SHYR-MGBZ-SLXK")
}

extension LuckyCart {
    static var testAuthKey = "ugjArgGw"
    static var testSecret = "p#91J#i&00!QkdSPjgGNJq"
}