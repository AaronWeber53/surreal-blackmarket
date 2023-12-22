QBCore = exports['qb-core']:GetCoreObject()

local PlayerData = QBCore.Functions.GetPlayerData()


-- Send a notification to the player
NotifyPlayer = function(message, type, timer)
	QBCore.Functions.Notify(message, type, timer)
end

-- Open a menu
OpenMenuFunction = function(menu)
    exports['qb-menu']:openMenu(menu)
end

-- Notify Police 
NotifyPolice = function()
    exports['qb-dispatch']:RadioScanner()        
end

BuildSellItems = function()
    local sellItemsMenu = {
        {
            header = '⬅ Go Back',
            params = {
                event = 'surreal-blackmarket:client:homeMenu'
            }
        }
    }
    local CurrentDealer = Config.CurrentDealers[currentDealer]
    for k,v in pairs(CurrentDealer.sellPrices) do
        local itemName = QBCore.Shared.Items[k].label
        sellItemsMenu[#sellItemsMenu + 1] = {
            header = itemName,
            txt = 'Current Price: '..tostring(v),
            params = {
                event = 'surreal-blackmarket:client:SellItem',
                args = {
                    label = itemName,
                    itemName = k,
                    price = v
                }
            }
        }
    end
    OpenMenuFunction(sellItemsMenu)
    exports['qb-menu']:openMenu(sellItemsMenu)
end

