//
//  LuckyCart+Requests.swift
//
//  LuckyCart Framework - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 18/01/2022.
//

import Foundation


internal extension LuckyCart {

    /// postCart
    
    func postCart(ticketComposer: LCTicketComposer, completion: @escaping (Result<LCPostCartResponse, Error>)->Void) {
        
        let header = LCRequestParameters.PostCart(cartId: "\(Model.testCart.id)",
                                                  shopperId: "\(Model.testCustomer.id)",
                                                  totalAti: "123.45",
                                                  ticketComposer: ticketComposer)
        do {
            let request: LCRequest<LCRequestResponse.PostCart> = try network.buildRequest(name: .postCart,
                                                                                          parameters: nil,
                                                                                          body: header)
            try network.run(request) { response in
                switch response {
                case .success(let result):
                    completion(.success(LCPostCartResponse(result)))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
    }
    
    /// getGames
    ///
    /// Will return cached version if available
    
    func getGames(completion: @escaping (Result<[LCGame], Error>)->Void) {
        if let cachedGames = games {
            print("[luckycart.cache] Return cached games")
            completion(Result.success(cachedGames))
            return
        }
        
        do {
            let request: LCRequest<Model.Games> = try network.buildRequest(name: .getGames,
                                                                           parameters: LCRequestParameters.Games(customerId: customer.id, cartId: cart.id),
                                                                           body: nil)
            
            try network.run(request) { response in
                switch response {
                case .success(let result):
                    let games = result.games.map { LCGame($0) }
                    // Cache available games
                    self.games = games
                    completion(.success(games))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
    }
    
    /// getBannerSpaces
    ///
    /// Will return cached version if available

    func getBannerSpaces(completion: @escaping (Result<LCBannerSpaces, Error>)->Void) {
        
        if let cachedBannerSpaces = bannerSpaces {
            print("[luckycart.cache] Return cached banner spaces")
            completion(Result.success(cachedBannerSpaces))
            return
        }
        
        do {
            let parameters = LCRequestParameters.BannerSpaces(customerId: customer.id)
            let request: LCRequest<Model.BannerSpaces> = try network.buildRequest(name: .getBannerSpaces,
                                                                                  parameters: parameters,
                                                                                  body: nil)
            
            try network.run(request) { response in
                switch response {
                case .success(let result):
                    let bannerSpaces = LCBannerSpaces(result)
                    self.bannerSpaces = bannerSpaces
                    completion(.success(bannerSpaces))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
        
    }
    
    /// getBanner
    ///
    /// Will return cached version if available

    func getBanner(bannerIdentifier: LCBannerIdentifier, completion: @escaping (Result<LCBanner, Error>)->Void) {
        
        if let cachedBanner = bannerSpaces?.banners[bannerIdentifier] {
            print("[luckycart.cache] Return cached banner `\(bannerIdentifier)`")
            completion(Result.success(cachedBanner))
            return
        }
        
        do {
            let parameters = LCRequestParameters.Banner(customerId: customer.id, banner: bannerIdentifier)
            
            let request: LCRequest<Model.Banner> = try network.buildRequest(name: .getBanner,
                                                                            parameters: parameters,
                                                                            body: nil)
            
            try network.run(request) { response in
                switch response {
                case .success(let result):
                    var banner = LCBanner(result)
                    // Identifier is not returned by server, so we set the identifier here
                    banner.identifier = bannerIdentifier
                    // Cache the result
                    self.bannerSpaces?.banners[bannerIdentifier] = banner
                    completion(.success(banner))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        catch {
            completion(.failure(error))
        }
        
    }
    
}
