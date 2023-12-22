local dealerIsHome = false
interacting = false

local function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)

        nearDealer = false

        for id, dealer in pairs(Config.CurrentDealers) do
            local dealerDist = #(pos - vector3(dealer.coords.x, dealer.coords.y, dealer.coords.z))

            if dealerDist <= 6 then
                nearDealer = true

                if dealerDist <= 1.5 then
                    if not interacting then
                        if not dealerIsHome then
                            DrawText3D(dealer.coords.x, dealer.coords.y, dealer.coords.z, Lang:t("info.knock_button"))

                            if IsControlJustPressed(0, 38) then
                                currentDealer = id
                                knockDealerDoor()
                            end
                        elseif dealerIsHome then
                            DrawText3D(dealer.coords.x, dealer.coords.y, dealer.coords.z, Lang:t("info.other_dealers_button"))
                            if IsControlJustPressed(0, 38) then
                                OpenDealerMenu()
                            end
                        end
                    end
                end
            end
        end

        if not nearDealer then
            dealerIsHome = false
            interacting = false
            Wait(2000)
        end

        Wait(3)
    end
end)

function OpenDealerMenu()
    interacting = true
    local PlayerData = QBCore.Functions.GetPlayerData()
    local dealerRep = PlayerData.metadata["dealerrep"] or 0.0
    if PlayerData.gang.name ~= "none" then
        QBCore.Functions.TriggerCallback('qb-gangmenu:server:GetDealerRep', function(cb)	
            if cb > dealerRep then
                dealerRep = cb
            end
            OpenMenu(dealerRep)
        end, PlayerData.gang.name)
    else
        OpenMenu(dealerRep)
    end

end

function OpenMenu(dealerRep)
    local menu = {
        {
            isMenuHeader = true,
            header = "Black Market Menu",
        },
        {
            header = "Dealer Rep  - " ..tostring(dealerRep),
            isMenuHeader = true,
        },
        {
            header = 'Buy Items',
            txt = 'Buy Items from Dealer',
            params = {
                event = 'qb-gundealer:client:BuyItems',
            }
        },
        {
            header = "Sell Items",
            txt = 'Sell Items to Dealer',
            params = {
                event = 'qb-gundealer:client:SellItems',                
            }
        },
        {
            header = "Close Menu",
            txt = "",
            params = {
                event = "qb-gundealer:client:closeMenu"
            }
    
        }
    }
    exports['qb-menu']:openMenu(menu)
end

RegisterNetEvent('qb-gundealer:client:closeMenu', function()
    interacting = false
    exports['qb-menu']:closeMenu()
end)

RegisterNetEvent('qb-gundealer:client:homeMenu', function()
    OpenDealerMenu()
end)

RegisterNetEvent('qb-gundealer:client:SellItems', function()
    local sellItemsMenu = {
        {
            header = '⬅ Go Back',
            params = {
                event = 'qb-gundealer:client:homeMenu'
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
                event = 'qb-gundealer:client:SellItem',
                args = {
                    label = itemName,
                    itemName = k,
                    price = v
                }
            }
        }
    end

    exports['qb-menu']:openMenu(sellItemsMenu)
end)


function knockDealerDoor()
    local hours = GetClockHours()
    local min = Config.CurrentDealers[currentDealer].time.min
    local max = Config.CurrentDealers[currentDealer].time.max

    local PlayerData = QBCore.Functions.GetPlayerData()
    if Config.CurrentDealers[currentDealer].gangs and not Config.CurrentDealers[currentDealer].gangs[PlayerData.gang.name] then
        knockDoorAnim(false)
    else
        if max < min then
            if hours <= max then
                knockDoorAnim(true)
            elseif hours >= min then
                knockDoorAnim(true)
            else
                knockDoorAnim(false)
            end
        else
            if hours >= min and hours <= max then
                knockDoorAnim(true)
            else
                knockDoorAnim(false)
            end
        end
    end
end

function knockDoorAnim(home)
    local knockAnimLib = "timetable@jimmy@doorknock@"
    local knockAnim = "knockdoor_idle"
    local PlayerPed = PlayerPedId()
    local myData = QBCore.Functions.GetPlayerData()

    if home then
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Wait(100)
        end
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        Wait(1000)
        dealerIsHome = true
        TriggerEvent("chatMessage", Lang:t("info.dealer_name", {dealerName = Config.CurrentDealers[currentDealer].name}), "info", Lang:t("info.fred_knock_message", {firstName = myData.charinfo.firstname}))
        -- knockTimeout()
    else
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "knock_door", 0.2)
        Wait(100)
        while (not HasAnimDictLoaded(knockAnimLib)) do
            RequestAnimDict(knockAnimLib)
            Wait(100)
        end
        TaskPlayAnim(PlayerPed, knockAnimLib, knockAnim, 3.0, 3.0, -1, 1, 0, false, false, false )
        Wait(3500)
        TaskPlayAnim(PlayerPed, knockAnimLib, "exit", 3.0, 3.0, -1, 1, 0, false, false, false)
        Wait(1000)
        QBCore.Functions.Notify(Lang:t("info.no_one_home"), 'primary', 3500)
    end
end


