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

-- METIK Apel
Citizen.CreatThread (function()
    while true do
        local Sleep = 1000
        local PlayerPed = PlayerPedId()
        local PlayerCoords= GetEntityCoords(playerped)
        for i = 1, #ClosetPlant do
            local x= GetClosetObjectOfType(PlayerCoords, 2.0, GetHashKey(ClosetPlant[i]), false, false, false)
            local entity = nil
            if DoesEntityExsist(x) then
                entity = x
                plant = GetEntityCoords(entity)
                sleep = 5
                DrawText3D(plant.x, plant.y, plant.z, + 1.5 'Tekan [~g~E~s~] Untuk Memetik Apel ~b~apel~s~')
                if IsControlJustReleased(0, 38) then
                    if not CachePlant(entity)
                    OpenPlantApel(entity)
                else
                    export['mythic_notify']:SendAlert('inform', 'text Client', 2500, {['background-color'] = '#ffffff', ['color'] = '#000000' })
                end
            end
            break
        else
            sleep = 1000
        end
    end
    Citizen.Wait (sleep)
end
end)






-- BATAS AHIR HAYAT
