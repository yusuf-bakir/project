//
//  MenuButton.swift
//  MyProject
//
//  Created by yusuf bakır on 17.07.2023.
//

import Foundation
import SwiftUI

struct SelectidMenuButton: View {
    var menuItem:MenuItem
    @ObservedObject var cartManager = CartManager()
    @Binding var isActivated :Bool
    var body: some View {
        Circle()
            .fill(menuItem.color).frame(width: isActivated ? 50 : 64,height: isActivated ? 50:60)
            .overlay(Image(systemName: menuItem.icon)).foregroundColor(.white)
            .offset(x: 0,y:-10)
            .onTapGesture {
                self.isActivated.toggle()
            }
    }
}

struct MenuButton: View {
    @Binding var isActivated: Bool
    @ObservedObject var menuVM: MenuViewModel
    var currentItemIndex: Int
    var body: some View {
        let menuItem = menuVM.menus[currentItemIndex]
            
        return Circle()
            .fill(menuItem.color)
            .frame(width: isActivated ? 50 : 20, height: isActivated ? 50 : 20)
            .shadow(radius: 5)
            .overlay(Image(systemName: menuItem.icon))
            .foregroundColor(.white)
            .offset(x: isActivated ? calcOffset().x : 0, y: isActivated ? calcOffset().y : -10) // Update offset when activated
            
            .onTapGesture {
                self.isActivated.toggle()
                self.updateSelected()
                    
            }
    }
    
    func updateSelected() {
        let menuItem = menuVM.menus[currentItemIndex]
        for i in 0..<menuVM.menus.count {
            menuVM.menus[i].selected = menuItem.id == menuVM.menus[i].id
            
                
                
        }
}
    func calcOffset() -> (x: CGFloat, y: CGFloat) {
           switch menuVM.menus.count {
           case 2:
               switch currentItemIndex {
               case 0:
                   return (-70, -70)
               default:
                   return (70, -70)
               }
           case 3:
               switch currentItemIndex {
               case 0:
                   return (-70, -70)
               case 1:
                   return (0, -110)
               default:
                   return (70, -70)
               }
           case 4:
               switch currentItemIndex {
               case 0:
                   return (-90, -40)
               case 1:
                   return (-45, -110)
               case 2:
                   return (45, -110)
               default:
                   return (90, -40)
               }
           default: // case 5
               switch currentItemIndex {
               case 0:
                   return (-100, -20)
               case 1:
                   return (-70, -80)
               case 2:
                   return (0, -110)
               case 3:
                   return (70, -80)
               default:
                   return (100, -20)
               }
           }
       }
   }
