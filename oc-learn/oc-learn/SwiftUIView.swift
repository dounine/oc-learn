//
//  SwiftUIView.swift
//  oc-learn
//
//  Created by lake on 2024/7/29.
//

import SwiftUI

struct SwiftUIView: View {
    @Environment(\.presentationMode) private var mode
    var body: some View {
        NavigationView {
            List {
                ForEach(1 ... 20, id: \.self) { item in
                    Text(String(item))
                }
            }
            .navigationTitle(Text("ipa小程序"))
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.large)
            .navigationBarItems(trailing: Button {
                self.mode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.backward")
            })
        }
    }
}

#Preview {
    SwiftUIView()
}
