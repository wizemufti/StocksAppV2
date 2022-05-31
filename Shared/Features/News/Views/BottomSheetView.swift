//
//  BottomSheetView.swift
//  StocksApp (iOS)
//
//  Created by Mufti, Shayan on 5/26/22.
//

import SwiftUI

// enum used to store some constants needed inside of the bottom sheet view
fileprivate enum Constants {
    static let radius: CGFloat = 16
    static let indicatorHeight: CGFloat = 6
    static let inidicatorWidth: CGFloat = 60
    static let snapRatio: CGFloat = 0.25
    static let minHeightRatio: CGFloat = 0.2
}


// Content passed in to the structure
struct BottomSheetView<Content: View>: View {
    
    @Binding var isOpen: Bool
    
    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content
    
    // for drag functionality
    @GestureState private var translation: CGFloat = 0
    
    // offset for determining height
    private var offset: CGFloat {
        
        isOpen ? 0 : maxHeight - minHeight          // if open then offset is zero, otherwise determined by maxHeight - minHeight
    }
    
    // indicator view (line to display that user can drag and drop)
    private var indicator: some View {
        
        // Create rounded rectangle with white fill and  custom frame (for measurements)
        RoundedRectangle(cornerRadius: Constants.radius)
            .fill(Color.white.opacity(0.2))
            .frame(width: Constants.inidicatorWidth, height: Constants.indicatorHeight)
            .onTapGesture {
                isOpen.toggle()
            }
    }
    
    init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.maxHeight = maxHeight
        self.minHeight = maxHeight * Constants.minHeightRatio
        self.content = content()
        self._isOpen = isOpen
    }
    
    // define view in this
    var body: some View {
        
        // read width and height of the space
        GeometryReader { geo in
            
            VStack(spacing: 0) {
                self.indicator.padding()
                self.content
            }
            .frame(width: geo.size.width, height: self.maxHeight, alignment: .top)
            .background(ZStack {
                Color.white
                Color.black.opacity(0.8)
            })
            
            // stack placement adjustments (keeps news article outputs organized)
            .cornerRadius(Constants.radius)
            .frame(height: geo.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.interactiveSpring())
            .gesture(DragGesture().updating(self.$translation, body: { (value, state, _) in
                state = value.translation.height
            }).onEnded({ (value) in
                let snapDistance = self.maxHeight * Constants.snapRatio
                guard abs(value.translation.height) > snapDistance else {
                    
                    return
                }
                self.isOpen = value.translation.height < 0
            }))
            
        }
    }
}
