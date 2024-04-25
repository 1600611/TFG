//
//  SideMenuView.swift
//  IncomeManager
//
//  Created by Joel Angles Roca on 25/4/24.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var isPickerVisible = false
    var categoriesInformation: [CategoryInformation]
    var homeButtonAction: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: -7.5) {
            Text("Options")
                .font(.title)
                .foregroundColor(0 == 0 ? CustomColor.lightOptionsText : CustomColor.darkOptionsText)
                .padding()
            
            Rectangle()
                .fill(0 == 0 ? Color.gray : Color.white)
                .frame(height: 1)
                .padding(.vertical, 5)
                .padding(.horizontal)
            
            Button(action: {
                homeButtonAction()
            }) {
                HStack {
                    Image(systemName: "house")
                        .foregroundColor(0 == 0 ? CustomColor.lightIcons : CustomColor.darkIcons)
                    Text("Home")
                        .foregroundColor(0 == 0 ? CustomColor.lightOptionsText : CustomColor.darkOptionsText)
                }
            }
            .padding()
            
            Button(action: {
                IncomeDistributionView(categories: categoriesInformation)
            }) {
                HStack {
                    Image(systemName: "chart.pie")
                        .foregroundColor(0 == 0 ? CustomColor.lightIcons : CustomColor.darkIcons)
                    Text("Income distribution")
                        .foregroundColor(0 == 0 ? CustomColor.lightOptionsText : CustomColor.darkOptionsText)
                }
            }
            .padding()
            
            Button(action: {}) {
                HStack {
                    Image(systemName: "dollarsign.square")
                        .foregroundColor(0 == 0 ? CustomColor.lightIcons : CustomColor.darkIcons)
                    Text("Currency")
                        .foregroundColor(0 == 0 ? CustomColor.lightOptionsText : CustomColor.darkOptionsText)
                }
            }
            .padding()
            
            Button(action: {
                isPickerVisible.toggle()
            }) {
                HStack {
                    Image(systemName: "paintbrush")
                        .foregroundColor(0 == 0 ? CustomColor.lightIcons : CustomColor.darkIcons)
                    Text("Theme")
                        .foregroundColor(0 == 0 ? CustomColor.lightOptionsText : CustomColor.darkOptionsText)
                }
            }
            .padding()
            
            if isPickerVisible {
                Picker(selection: $themeManager.selectedIndex, label: Text("")) {
                    Text("Light").tag(0)
                    Text("Dark").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                .onChange(of: themeManager.selectedIndex) { newValue in
                    themeManager.selectedIndex = newValue
                }
            }
                        
            Spacer()
        }
        .background(0 == 0 ? CustomColor.lightBackground : CustomColor.darkBackground)
        .shadow(radius: 5)
    }
}

#Preview {
    SideMenuView(categoriesInformation: [], homeButtonAction: {})
}
