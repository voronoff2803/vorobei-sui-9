//
//  ContentView.swift
//  vorobei-sui-9
//
//  Created by Alexey Voronov on 23.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var dragOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.blue
            Canvas { context, size in
                context.addFilter(.alphaThreshold(min: 0.5, color: .white))
                context.addFilter(.blur(radius: 30))
                context.drawLayer { ctx in
                    for index in [1,2] {
                        if let resolved = context.resolveSymbol(id: index) {
                            ctx.draw(resolved, at: CGPoint(x: size.width / 2, y: size.height / 2))
                        }
                    }
                }
            } symbols: {
                Circle()
                    .fill(.white)
                    .frame(width: 200, height: 200)
                    .tag(1)
                    
                Circle()
                    .fill(.white)
                    .frame(width: 200, height: 200)
                    .tag(2)
                    .offset(dragOffset)
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        dragOffset = value.translation
                    }) .onEnded({ _ in
                        withAnimation {
                            dragOffset = .zero
                        }
                    })
            )
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
