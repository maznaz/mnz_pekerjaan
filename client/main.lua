ESX         = nil
CachePlant  = {}
ClosetPlant = {
    'prop_apel'
}

Citizen.CreatThread (function()
    while true do
        Citizen.Wait (12000)
        CachePlant = {}
    end
end)

Citizen.CreatThread (function()
    while ESX == nil do
        Citizen.Wait (5)
        TriggerEvent("esx:getSharedObject", function (libary)
            ESX = libary
        end)
    end
    if ESX.IsPlayerLoaded() then
        ESX.playerData = ESX.GetPlayerData()
    end
end)

RigisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(respone)
    ESX.PlayerData = respone
end)

