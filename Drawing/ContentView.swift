//
//  ContentView.swift
//  Drawing
//
//  Created by Dathan Wong on 6/8/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var width: CGFloat = 10
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack{
            Arrow().stroke(style: StrokeStyle(lineWidth: width, lineCap: .round)).frame(width: 200, height: 200).animation(.default)
            Slider(value: $width, in: 0...30, step: 1.0)
            ColorCyclingRectangle(amount: colorCycle).animation(.default).drawingGroup()
            Slider(value: $colorCycle, in: 0...1, step: 0.1)
        }
        
    }
}

struct Triangle: Shape{
    func path(in rect: CGRect) -> Path{
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct Arrow: Shape{
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX/4, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX/4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX*3/4, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX*3/4, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/2))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
    
    
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
