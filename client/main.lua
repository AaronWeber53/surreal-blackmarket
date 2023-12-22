QBCore = exports['qb-core']:GetCoreObject()
currentDealer = nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-gundealer:server:RequestConfig', function(DealerConfig)
        Config.CurrentDealers = DealerConfig
    end)
end)

RegisterNetEvent('qb-gundealer:client:UpdateGunDealers', function(cfg)
    Config.CurrentDealers = cfg
end)

RegisterNetEvent('qb-gundealer:client:GotoGunDealer', function(DealerIndex)
    if Config.CurrentDealers[DealerIndex] ~= nil then
        local DealerData = Config.CurrentDealers[DealerIndex]
        local ped = PlayerPedId()
        SetEntityCoords(ped, DealerData.coords.x, DealerData.coords.y, DealerData.coords.z)
        QBCore.Functions.Notify(Lang:t("success.teleported_to_dealer"), 'success')
    else
        TriggerEvent('QBCore:Notify', Lang:t("error.dealer_not_exists"), 'error')
    end
end)

RegisterNetEvent('qb-gundealer:client:setDealerItems', function(amount, dealer, itemCategory, itemIndex)
    if itemCategory then
        Config.CurrentDealers[dealer].randominventory[itemCategory][itemIndex].amount = Config.CurrentDealers[dealer].randominventory[itemCategory][itemIndex].amount - amount
    else
        Config.CurrentDealers[dealer].inventory[itemIndex].amount = Config.CurrentDealers[dealer].inventory[itemIndex].amount - amount
    end
end)

RegisterNetEvent('qb-gundealer:client:updateDealerItems', function(itemData, amount)
    TriggerServerEvent('qb-gundealer:server:updateDealerItems', itemData, amount, currentDealer)
end)

RegisterNetEvent('qb-gundealer:client:BuyItems', function()
    buyDealerStuff()
    exports['qb-menu']:closeMenu()
end)

function buyDealerStuff()
    local PlayerData = QBCore.Functions.GetPlayerData()
    local dealerRep = PlayerData.metadata["dealerrep"] or 0.0
    if PlayerData.gang.name ~= "none" then
        QBCore.Functions.TriggerCallback('qb-gangmenu:server:GetDealerRep', function(cb)	
            if cb > dealerRep then
                dealerRep = cb
            end
            getDealerStuff(dealerRep, PlayerData.gang.name)
        end, PlayerData.gang.name)
    else
        getDealerStuff(dealerRep, PlayerData.gang.name)
    end
end

function getDealerStuff(dealerRep, gang) 
    local repItems = {}
    repItems.label = "Blackmarket Weapon Dealer"
    repItems.items = {}
    repItems.slots = 30
    local CurrentDealer = Config.CurrentDealers[currentDealer]
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
            for showkey, showvalue in pairs(Config.GunCategories[category].numbertoshow) do
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
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "WeaponDealer_"..Config.CurrentDealers[currentDealer].name..tostring(currentDealer), repItems)    
        interacting = false
    end
end


RegisterNetEvent('qb-gundealer:client:SellItem', function(item)
    local sellingItem = exports['qb-input']:ShowInput({
		header = item.label,
		submitText = "Sell "..item.label,
		inputs = {
			{
				type = 'number',
				isRequired = true,
				name = 'amount',
				text = 'Price Per: '..tostring(item.price)
			}
		}
	})

	if sellingItem then
		if not sellingItem.amount then
			return
		end
        print(sellingItem.amount)
		if sellingItem.amount and tonumber(sellingItem.amount) > 0 then
			TriggerServerEvent('qb-gundealer:server:SellItem', item.itemName, item.label, tonumber(sellingItem.amount), tonumber(item.price))
		else
			QBCore.Functions.Notify("Trying to sell a negative amount?", 'error')
		end
        exports['qb-menu']:closeMenu()
	end
    interacting = false
end)
