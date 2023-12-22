currentDealer = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('surreal-blackmarket:server:RequestConfig', function(DealerConfig)
        Config.CurrentDealers = DealerConfig
    end)
end)

RegisterNetEvent('surreal-blackmarket:client:UpdateGunDealers', function(cfg)
    Config.CurrentDealers = cfg
end)

RegisterNetEvent('surreal-blackmarket:client:GotoGunDealer', function(DealerIndex)
    if Config.CurrentDealers[DealerIndex] ~= nil then
        local DealerData = Config.CurrentDealers[DealerIndex]
        local ped = PlayerPedId()
        SetEntityCoords(ped, DealerData.coords.x, DealerData.coords.y, DealerData.coords.z)
        NotifyPlayer(Lang:t("success.teleported_to_dealer"), 'success')
    else
        NotifyPlayer(Lang:t("error.dealer_not_exists"), 'error')
    end
end)

RegisterNetEvent('surreal-blackmarket:client:setDealerItems', function(amount, dealer, itemCategory, itemIndex)
    if itemCategory then
        Config.CurrentDealers[dealer].randominventory[itemCategory][itemIndex].amount = Config.CurrentDealers[dealer].randominventory[itemCategory][itemIndex].amount - amount
    else
        Config.CurrentDealers[dealer].inventory[itemIndex].amount = Config.CurrentDealers[dealer].inventory[itemIndex].amount - amount
    end
end)

RegisterNetEvent('surreal-blackmarket:client:updateDealerItems', function(itemData, amount)
    TriggerServerEvent('surreal-blackmarket:server:updateDealerItems', itemData, amount, currentDealer)
end)

RegisterNetEvent('surreal-blackmarket:client:BuyItems', function()
    buyDealerStuff()
    exports['qb-menu']:closeMenu()
end)

function buyDealerStuff()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local dealerRep = PlayerData.metadata["dealerrep"] or 0.0
    getDealerStuff(dealerRep, PlayerData.gang.name)
end

function getDealerStuff(dealerRep, gang) 
    local repItems = {}
    repItems.items = {}
    repItems.slots = 30
    local CurrentDealer = Config.CurrentDealers[currentDealer]
    repItems.label = "Blackmarket - "..CurrentDealer.name
    if (CurrentDealer) then
        -- Add constant weapons based on rep
        for k, v in pairs(CurrentDealer.inventory) do
            if (not v.gangs or v.gangs[gang]) and v.minrep <= dealerRep then
                repItems.items[v.slot] = v
            end
        end

        -- Add randomized weapons based on rep
        for category, categorydata in pairs(CurrentDealer.randominventory) do
            local maxtoshow = 0
            for showkey, showvalue in pairs(Config.ItemCategories[category].numbertoshow) do
                if showvalue.minrep <= dealerRep and showvalue.quantity > maxtoshow then
                    maxtoshow = showvalue.quantity
                end
            end
            if #categorydata < maxtoshow then
                maxtoshow = #categorydata
            end
            local numberGangItems = 0
            for k, v in pairs(categorydata) do
                print(v.name)
                if v.gangs and not v.gangs[gang] then
                    numberGangItems = numberGangItems + 1
                end
            end   

            if (#categorydata - numberGangItems) < maxtoshow then
                maxtoshow = #categorydata - numberGangItems
            end

            local numberAdded = 0
            for k, v in pairs(categorydata) do
                if maxtoshow <= numberAdded then
                    break
                end
                if (not v.gangs or v.gangs[gang]) and v.minrep <= dealerRep then
                    repItems.items[v.slot] = v
                    numberAdded = numberAdded + 1
                end
            end        
        end    
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "BlackMarket_"..Config.CurrentDealers[currentDealer].name..tostring(currentDealer), repItems)    
        interacting = false
    end
end


RegisterNetEvent('surreal-blackmarket:client:SellItem', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
		header = item.label,
		submitText = "Sell "..item.label,
		inputs = {
			{
				type = 'number',
				isRequired = true,
				name = 'amount',
				text = 'Max Price Per: '..tostring(item.price)
			}
		}
	})

	if sellingItem then
		if not sellingItem.amount then
			return
		end
        print(sellingItem.amount)
		if sellingItem.amount and tonumber(sellingItem.amount) > 0 then
			TriggerServerEvent('surreal-blackmarket:server:SellItem', item.itemName, item.label, tonumber(sellingItem.amount), currentDealer)
		else
			NotifyPlayer("Trying to sell a negative amount?", 'error')
		end
        exports['qb-menu']:closeMenu()
	end
    interacting = false
end)

local cooldownTimer = nil
RegisterNetEvent('surreal-blackmarket:client:UserRadioScanner', function()
    if cooldownTimer then
        NotifyPlayer("Your scanner needs time to reset", "error")
        return 
    end
    local nearbyMarket = nil
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local closestDist = nil
    for key, dealer in pairs(Config.CurrentDealers) do        
        local dealerDist = #(pos - vector3(dealer.coords.x, dealer.coords.y, dealer.coords.z))
        if dealerDist <= 1000 then
            if not closestDist or closestDist > dealerDist then
                closestDist = dealerDist
                nearbyMarket = dealer
            end
        end
    end

    local triggerPoliceChance = false
    if nearbyMarket then
        if closestDist <= 300 then
            NotifyPlayer("Your scanner picked up a strong signal by "..nearbyMarket.name.." close by.", "success")
            triggerPoliceChance = true
        elseif closestDist <= 600 then
            NotifyPlayer("Your scanner picked up a signal by "..nearbyMarket.name..".", "success")
            triggerPoliceChance = true
        else
            NotifyPlayer("Your scanner picked up a weak signal", "success")
        end
    else
        NotifyPlayer("Your scanner did not pick up any signal")
    end

    NotifyPlayer("Your scanner is resetting")
    cooldownTimer = true
    SetTimeout((1000 * Config.ScannerResetTimer), function() -- Clear call after 10 minutes
        NotifyPlayer("Your scanner has finished resetting", "success")
        cooldownTimer = false
    end) 

    if triggerPoliceChance then
        local random = math.random(100)
        if random <= Config.ScannerPoliceNotifyChance then
            NotifyPolice()
        end        
    end
end)
