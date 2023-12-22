QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('qb-gundealer:server:RequestConfig', function(source, cb)
    cb(Config.CurrentDealers)
end)

RegisterNetEvent('qb-gundealer:server:ResetGunDealers', function (source)
    RandomizeDealers()
    TriggerClientEvent('qb-gundealer:client:UpdateGunDealers', -1, Config.CurrentDealers)
end)

CreateThread(function()
    Wait(500)    
    TriggerEvent('qb-gundealer:server:ResetGunDealers')
end)

-- Logic to generate randomized dealers
function RandomizeDealers()
    Config.CurrentDealers = {}
    local dealerLength = #Config.GunDealerLocations
    local dealersUsed = {}
    local maxDealers = Config.MaxNumberOfDealersActive
    if (dealerLength < maxDealers) then
        maxDealers = dealerLength
    end
    for i = 1, maxDealers do
        local validDealer = false
        while not validDealer do
            local randomDealerNumber = math.random(1, dealerLength)
            validDealer = true
            for key, value in pairs(dealersUsed) do
                if value == randomDealerNumber then
                    validDealer = false
                    break
                end
            end
            if validDealer then
                Config.CurrentDealers[#Config.CurrentDealers+1] = CreateDealer(Config.GunDealerLocations[randomDealerNumber])
                table.insert(dealersUsed, randomDealerNumber)
            end
        end
    end

    for i, dealer in pairs(Config.ConstantLocations) do
        Config.CurrentDealers[#Config.CurrentDealers+1] = CreateDealer(dealer)        
    end
end

function CreateDealer(dealerinfo)
    local newDealer = {
        coords = dealerinfo.locations[math.random(1, #dealerinfo.locations)],
        inventory = {},
        randominventory = {},
        time = dealerinfo.time,
        name = dealerinfo.name,
        sellPrices = {},
        location = dealerinfo.locationInfo,
        gangs = dealerinfo.gangs
    }

    for item, cost in pairs(Config.SellPrices) do
        newDealer.sellPrices[item] = math.random(cost.minPrice, cost.maxPrice)
    end
    local slotCount = 1
    print(dealerinfo.name)
    for i, category in pairs(dealerinfo.categories) do
        for weapon, weapondata in pairs(Config.GunCategories[category].constantitems) do
            newDealer.inventory[#newDealer.inventory+1] = CreateDealerItem(weapon, weapondata, slotCount)
            slotCount = slotCount + 1
            print(weapon)
        end
        local maxtoshow = 1
        for showkey, showvalue in pairs(Config.GunCategories[category].numbertoshow) do
            if showvalue.quantity > maxtoshow then
                maxtoshow = showvalue.quantity
            end
        end
        local itemsUsed = {}
        newDealer.randominventory[category] = {}
        local itemLength = #Config.GunCategories[category].randomitems
        if itemLength < maxtoshow then
            maxtoshow = itemLength
        end
        for wi = 1, maxtoshow do
            local validItem = false
            while not validItem do
                local randomItemNumber = math.random(1, itemLength)
                validItem = true
                for key, value in pairs(itemsUsed) do
                    if value == randomItemNumber then
                        validItem = false
                        break
                    end
                end
                if validItem then
                    newDealer.randominventory[category][#newDealer.randominventory[category]+1] = CreateDealerItem(Config.GunCategories[category].randomitems[randomItemNumber].name, Config.GunCategories[category].randomitems[randomItemNumber], slotCount)
                    slotCount = slotCount + 1
                    table.insert(itemsUsed, randomItemNumber)
                end
            end
        end
    
    end

    return newDealer
end

function CreateDealerItem(weapon, weapondata, slotCount)
    return {
        name = weapon,
        price = math.random(weapondata.pricelow, weapondata.pricehigh),
        amount = math.random(weapondata.quantitylow, weapondata.quantityhigh),
        info = {},
        type = "item",
        minrep = weapondata.minrep,
        slot = slotCount,
        gangs = weapondata.gangs
    }
end

QBCore.Commands.Add("resetgundealers", "Resets Gun Dealers", {}, 
true, function(source, args)
    TriggerEvent('qb-gundealer:server:ResetGunDealers')
end, "admin")


QBCore.Commands.Add("currentmarket", "Get Current Market Locations", {}, 
false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    for key, dealer in pairs(Config.CurrentDealers) do        
        if not dealer.gangs or dealer.gangs[Player.PlayerData.gang.name] then
            TriggerClientEvent("chatMessage", source, dealer.name.." - "..dealer.location)            
        end
    end
end, "user")

QBCore.Commands.Add("gundealergoto", Lang:t("info.dealergoto_command_desc"), {{
    name = "index",
    help = "Index of Dealer to go to"
}}, true, function(source, args)
    local DealerIndex = tonumber(args[1])

    if Config.CurrentDealers[DealerIndex] ~= nil then
        TriggerClientEvent('qb-gundealer:client:GotoGunDealer', source, DealerIndex)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.dealer_not_exists"), 'error')
    end
end, "admin")
