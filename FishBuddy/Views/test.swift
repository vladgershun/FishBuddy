//
//  test.swift
//  FishBuddy
//
//  Created by Vlad Gershun on 8/1/22.
//

import SwiftUI

struct test: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .strokeBorder(.white, lineWidth: 2)
            .background(RoundedRectangle(cornerRadius: 25, style: .continuous).foregroundColor(.yellow.opacity(0.9)))
        //                        .frame(maxHeight: geo.size.height * 0.15)
            .aspectRatio(contentMode: .fit)
            .overlay(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    Text("Species")
                    
                        .foregroundColor(.white)
                        .font(.title)
                    Text("Species")
                        .foregroundColor(.white)
                        .font(.title)
                }
                
            }
    }
}

struct test_Previews: PreviewProvider {
    static var previews: some View {
        test()
    }
}
