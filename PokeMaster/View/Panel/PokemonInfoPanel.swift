//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by yl on 2019/10/18.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    
    @State var darkBlur = false
    
    let model: PokemonViewModel
    
    var abilities: [AbilityViewModel]{
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    var pokemonDescription: some View{
        Text(model.descriptionText)
            .font(.callout)
            .foregroundColor(Color(hex: 0x666666))
            .fixedSize(horizontal: false, vertical: true)
    }
    
    var topIndicator: some View{
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var body: some View{
        VStack(spacing: 20) {
            
            
//            Button(action:{  //练习
//                self.darkBlur.toggle()
//            }){
//                Text("切换模糊效果")
//            }
            
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            Abilitylist(model: model, abilityModels: abilities)    
        }
        
            
            
    .padding(EdgeInsets(top: 12, leading: 30, bottom: 30, trailing: 30))
//        .background(Color.white)
//            .blurBackground(style: darkBlur ? .systemMaterialDark : .systemMaterial)
            .blurBackground(style: .systemMaterial)
        .cornerRadius(20)
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: .sample(id: 1))
    }
}
