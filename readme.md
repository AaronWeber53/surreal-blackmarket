Add following code to qb-inventory 

		elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "BlackMarket" then
			TriggerEvent("surreal-blackmarket:server:buyItem", src, itemData, fromAmount, toSlot)



## commands ##
/resetblackmarket - Resets the random markets/items/locations

/currentmarket - View the current market locations

/bmdealergoto - Teleport to the dealers location