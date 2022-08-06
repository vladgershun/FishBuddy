//
//  ListPlatter.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/6/22.
//

import SwiftUI

//struct PlatterShape: Shape {
//    private let roundedRect = RoundedRectangle(cornerRadius: 10, style: .continuous)
//    func path(in rect: CGRect) -> Path {
//        roundedRect.path(in: rect)
//    }
//}
//struct CutoffPlatterShape: Shape {
//    private let roundedRect = RoundedRectangle(cornerRadius: 10, style: .continuous)
//    func path(in rect: CGRect) -> Path {
////        roundedRect.path(in: CGRect(origin: rect.origin, size: CGSize(width: rect.width, height: rect.height + 10)))
//        Path { path in
//            path.addRoundedRect(in: rect, cornerSize: CGSize(width: 10, height: 10), style: .continuous)
//            path.addRect(CGRect(x: 0, y: rect.height - 10, ))
//        }
//    }
//}

extension RoundedRectangle {
    static let platter = RoundedRectangle(cornerRadius: 10, style: .continuous)
}

struct ListPlatter/*<Content: View>*/: View {
    
    var fish: CaughtFish
    var location: LocationVisit
    
    
    var alignment: Alignment = .leading
    var padding: Double? = nil
    
//    @ViewBuilder
//    var content: Content

    var body: some View {
//        VStack { content }
//            .padding(padding ?? 8)
//            .frame(maxWidth: .infinity, alignment: alignment)
//            .containerShape(RoundedRectangle.platter)
//            .background(Color(.secondarySystemBackground), in: RoundedRectangle.platter)
//            .listRowSeparator(.hidden)
        
        VStack(alignment: .leading) {
            HStack {
                HStack {
                    Image(systemName: "fish.fill")
                    Text(fish.bait)
                        .font(.title3)
                }
                
                Spacer()
                
                HStack {
                    Text(fish.timeCaught, format: .dateTime.hour().minute())
                        .font(.title3)
                    Image(systemName: "clock.fill")
                }
            }
            
            Divider()
            
            HStack {
                HStack {
                    Image(systemName: "scalemass.fill")
                    Text(fish.weight, format: .measurement(width: .abbreviated))
                        .font(.title3)
                }
                
                Spacer()
                
                HStack {
                    Text(location.waterTemperature, format: .measurement(width: .abbreviated))
                        .font(.title3)
                    Image(systemName: "thermometer.medium")
                }
            }
            
            Divider()
            
            HStack {
                HStack {
                    Image(systemName: "ruler.fill")
                    Text(fish.length, format: .measurement(width: .abbreviated))
                        .font(.title3)
                }
                
                Spacer()
                
                HStack {
                    Text(location.waterClarity.rawValue)
                        .font(.title3)
                    Image(systemName: "drop.fill")
                }
                
            }
        }
        .padding(padding ?? 8)
        .frame(maxWidth: .infinity, alignment: alignment)
        .containerShape(RoundedRectangle.platter)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle.platter)
        .listRowSeparator(.hidden)
    }
}

struct ListPlatterPair<Content: View>: View {
    var alignment: Alignment = .leading
    var padding: Double? = nil
    
    @ViewBuilder
    var first: Content
    
    @ViewBuilder
    var second: Content
    
    @Environment(\.dynamicTypeSize) private var typeSize
    
    var stack: AnyLayout {
        typeSize.isAccessibilitySize ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
    }
    
    var body: some View {
        stack {
            first
                .padding(padding ?? 8)
                .frame(maxWidth: .infinity, alignment: alignment)
                .containerShape(RoundedRectangle.platter)
                .background(Color(.secondarySystemBackground), in: RoundedRectangle.platter)
            
            second
                .padding(padding ?? 8)
                .frame(maxWidth: .infinity, alignment: alignment)
                .containerShape(RoundedRectangle.platter)
                .background(Color(.secondarySystemBackground), in: RoundedRectangle.platter)
        }.listRowSeparator(.hidden)
    }
}

//struct ListPlatter_Previews: PreviewProvider {
//    static var previews: some View {
//        List {
//            ListPlatter {
//                Text("Foo")
//            }
//            ListPlatterPair(first: {
//                Text("Foo")
//            }, second: {
//                Text("Bar")
//            })
//        }.listStyle(.plain)
//    }
//}
