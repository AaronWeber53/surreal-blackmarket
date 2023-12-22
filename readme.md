Add following code to qb-inventory server main.luaon line 2091 right before the itemshop check

		elseif QBCore.Shared.SplitStr(shopType, "_")[1] == "BlackMarket" then
			TriggerEvent("surreal-blackmarket:server:buyItem", src, itemData, fromAmount, toSlot)



## commands ##
/resetblackmarket - Resets the random markets/items/locations

/currentmarket - View the current market locations

/bmdealergoto - Teleport to the dealers location


## Check out my Tebex ##
Check out my tebex for my missions script to allow you to create robust missions with ease
https://surreal-scripts.tebex.io/
