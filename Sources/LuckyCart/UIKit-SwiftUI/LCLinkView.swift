//
//  LCLinkView.swift
//
//  LuckyCartLab - (c)2022 Lucky Cart
//
//  Created by Tristan Leblanc on 18/01/2022.
//

import SwiftUI

/// LCLinkView
///
/// Displays a LCLink ( target and image urls pair)

public struct LCLinkView: View {
    
    @Binding var link: LCLink
    
    /// Controls the state of the HTML view.
    /// If no particular action is set, a click on the link will open the target url in a `LCWebView`
    @State var isOpen: Bool = false
    
    /// The handler that gets called when the user closes the game view.
    ///
    /// The time spent by the user on the view is returned in the callback closure
    var didClose: ((Double)->Void)?
    
    /// The image to display if no image is set in the link
    @State var placeHolder: Image?
    
    /// The currently displayed image
    @State var displayedImage: Image?
    
    /// The action that will be called when the view is clicked/tapped
    var clickAction: ((LCLink)->Bool)?
    
    public init(link: Binding<LCLink>, didClose: ((Double)->Void)? = nil, placeHolder: Image? = nil, clickAction: ((LCLink)->Bool)? = nil) {
        self._link = link
        self.didClose = didClose
        self.clickAction = clickAction
        self.placeHolder = placeHolder
        self.displayedImage = link.wrappedValue.image == nil
        ? placeHolder
        : Image(lcImage: link.wrappedValue.image!)
    }
    
    public var body: some View {
        ZStack(alignment: .center) {
            
            if let image = displayedImage  {
                image.resizable().scaledToFit()
            }
            
            if link.isEnabled {
                Button("") {
                    // If a click action closure is set, we execute it, else default is to open a sheet
                    // to display the link.
                    // We can still open the sheet after executing the action if the click action returns true
                    self.isOpen = clickAction?(link) ?? true
                    
                }.scaledToFill()
                    .sheet(isPresented: $isOpen, content: {
                        let openDate = Date()
                        
                        VStack {
                            LCWebView(request: URLRequest(url: link.url))
                            Button("Close") {
                                isOpen = false
                                didClose?(-openDate.timeIntervalSinceNow)
                            }
                            .modifier(LCButtonModifier(color: .blue))
                        }
                    })
            }
        }
        .grayscale(link.isEnabled ? 0 : 0.9)
        .opacity(computeOpacity())
        .cornerRadius(10)
        .task {
            guard link.image == nil, let imageURL = link.imageUrl else {
                return
            }
            LuckyCart.shared.getImage(url: imageURL) { response in
                switch response {
                case .failure(let error):
                    print("[luckycart.linkView] Error \(error)")
                case .success(let image):
                    link.image = image
                    displayedImage = Image(lcImage: image)
                }
            }
        }
    }
    
    func computeOpacity() -> Double {
        if displayedImage == nil { return 0 }
        if link.isEnabled { return 1.0 }
        return 0.5
    }
}

#if DEBUG

struct LCLinkView_Previews: PreviewProvider {
    static var previews: some View {
        LCLinkView(link: .constant(LuckyCart.testBanner.link), placeHolder: Image("luckyCartBanner"))
    }
}

#endif
