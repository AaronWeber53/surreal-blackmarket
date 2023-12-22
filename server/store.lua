local blackMarketPriceThreshold = {}

RegisterNetEvent('surreal-blackmarket:server:updateDealerItems', function(itemData, amount, dealer)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local CurrentDealer = Config.CurrentDealers[dealer]
    if (CurrentDealer) then
        local dealerItem = nil
        local itemcategory = nil
        local itemIndex = nil
        for k, v in pairs(CurrentDealer.inventory) do
            if (v.slot == itemData.slot) then
                dealerItem = v
                itemIndex = k
                break
            end
        end
        if dealerItem == nil then
            for category, categorydata in pairs(CurrentDealer.randominventory) do
                local itemFound = false
                for k, v in pairs(categorydata) do
                    if (v.slot == itemData.slot) then
                        dealerItem = v
                        itemcategory = category
                        itemIndex = k
                        itemFound = true
                        break
                    end
                end        
                if itemFound then
                    break
                end
            end    
        end
        if dealerItem ~= nil then
            local canGiveItem = false
            if itemcategory ~= nil then
                local itemAmount = Config.CurrentDealers[dealer].randominventory[itemcategory][itemIndex].amount
                if itemAmount - amount >= 0 then
                    Config.CurrentDealers[dealer].randominventory[itemcategory][itemIndex].amount = itemAmount - amount
                    canGiveItem = true
                else
                    NotifyPlayer(src, "Not enough Stock", "error")
                end
            else
                local itemAmount = Config.CurrentDealers[dealer].inventory[itemIndex].amount
                if itemAmount - amount >= 0 then
                    Config.CurrentDealers[dealer].inventory[itemIndex].amount = itemAmount - amount
                    canGiveItem = true
                else
                    NotifyPlayer(src, "Not enough Stock", "error")
                end
            end
            if not canGiveItem then
                Player.Functions.RemoveItem(itemData.name, amount)
                Player.Functions.AddMoney('cash', amount * dealerItem.price)
        
                NotifyPlayer(src, Lang:t("error.item_unavailable"), "error")
            else
                TriggerClientEvent('surreal-blackmarket:client:setDealerItems', -1, amount, dealer, itemcategory, itemIndex)
            end
        end
    end
end)

RegisterNetEvent('surreal-blackmarket:server:buyItem', function(source, itemData, fromAmount, toSlot)
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    local price = tonumber((itemData.price*fromAmount))
    local itemInfo = QBCore.Shared.Items[itemData.name:lower()]
    if QBCore.Shared.SplitStr(itemData.name, "_")[1] == "weapon" then
        price = tonumber(itemData.price)
        if Player.Functions.RemoveMoney("cash", price, "dealer-item-bought") then
            itemData.info.serie = tostring(QBCore.Shared.RandomInt(2) .. QBCore.Shared.RandomStr(3) .. QBCore.Shared.RandomInt(1) .. QBCore.Shared.RandomStr(2) .. QBCore.Shared.RandomInt(3) .. QBCore.Shared.RandomStr(4))
            Player.Functions.AddItem(itemData.name, 1, toSlot, itemData.info)
            TriggerClientEvent('surreal-blackmarket:client:updateDealerItems', src, itemData, 1)
            NotifyPlayer(src, itemInfo["label"] .. " bought!", "success")
            TriggerEvent("qb-log:server:CreateLog", "weapondealers", "Weapon Dealer item bought", "green", "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. " for $"..price)
        else
            NotifyPlayer(src, "You don\'t have enough cash..", "error")
        end
    else
        if Player.Functions.RemoveMoney("cash", price, "dealer-item-bought") then
            Player.Functions.AddItem(itemData.name, fromAmount, toSlot, itemData.info)
            TriggerClientEvent('surreal-blackmarket:client:updateDealerItems', src, itemData, fromAmount)
            NotifyPlayer(src, itemInfo["label"] .. " bought!", "success")
            TriggerEvent("qb-log:server:CreateLog", "weapondealers", "Weapon Dealer item bought", "green", "**"..GetPlayerName(src) .. "** bought a " .. itemInfo["label"] .. "  for $"..price)
        else
            NotifyPlayer(src, "You don't have enough cash..", "error")
        end
    end
end)

RegisterNetEvent("surreal-blackmarket:server:SellItem", function(itemName, itemLabel, itemAmount, dealerName)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amountRemoved = 0
    local xItem = Player.Functions.GetItemByName(itemName)
    if xItem ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil and v.name == itemName then
                local stackAmount = v.amount
                local amountToRemove = itemAmount - amountRemoved
                if amountRemoved >= itemAmount then
                    break
                end

                if stackAmount >= amountToRemove then
                    if Player.Functions.RemoveItem(itemName, amountToRemove, k) then
                        amountRemoved = amountRemoved + amountToRemove                        
                    end
                else
                    if Player.Functions.RemoveItem(itemName, stackAmount, k) then
                        amountRemoved = amountRemoved + stackAmount
                    end
                end
            end
        end
        local itemPrice = Config.CurrentDealers[dealerName].sellPrices[itemName]
        itemPrice = itemPrice + 0.0
        if (not blackMarketPriceThreshold[itemName]) then
            blackMarketPriceThreshold[itemName] = 0
        end
        blackMarketPriceThreshold[itemName] = blackMarketPriceThreshold[itemName] + amountRemoved

        if blackMarketPriceThreshold[itemName] > Config.PriceDropThreshold then
            local numberOfTimes = blackMarketPriceThreshold[itemName] / Config.PriceDropThreshold
            TriggerBlackMarketPriceShift(itemName, numberOfTimes)
        end

        local amountCalculated = 0
        local calculatedPrice = 0
        while amountCalculated < amountRemoved do
            local curCalculation = 10
            if ((amountCalculated + curCalculation) > amountRemoved) then
                curCalculation = amountRemoved - amountCalculated
            end
            calculatedPrice = calculatedPrice + (curCalculation * itemPrice)
            amountCalculated = amountCalculated + curCalculation
            print('totalPrice: '..tostring(amountCalculated)..' calculated price: $'..tostring(calculatedPrice).." added "..tostring(curCalculation).." at "..tostring(itemPrice))
            itemPrice = math.floor(itemPrice * 0.75)
        end 
        NotifyPlayer(src, "You sold "..tostring(amountRemoved).." "..itemLabel.." for $"..tostring(calculatedPrice))
        Player.Functions.AddMoney("cash", calculatedPrice, "sold "..itemLabel)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[itemName], 'remove')
    else
        NotifyPlayer(src, "You have no "..itemLabel.."..")
    end
end)

function TriggerBlackMarketPriceShift(itemName, numberOfTimes) 
    CreateThread(function()
        print('Black Market Price Shift Triggered for Item: '..itemName)
        for key, dealer in pairs(Config.CurrentDealers) do        
            if dealer.sellPrices[itemName] then
                for i = 0, numberOfTimes, 1 do
                    dealer.sellPrices[itemName] = math.floor((dealer.sellPrices[itemName] + 0.0) * 0.75)                    
                end
                if dealer.sellPrices[itemName] < Config.SellPrices[itemName].minPrice then
                    dealer.sellPrices[itemName] = Config.SellPrices[itemName].minPrice
                end
            end
        end
        local remainder = blackMarketPriceThreshold[itemName]
        remainder = remainder - (numberOfTimes * Config.PriceDropThreshold)
        blackMarketPriceThreshold[itemName] = remainder
        TriggerClientEvent('surreal-blackmarket:client:UpdateGunDealers', -1, Config.CurrentDealers)
    end)
end