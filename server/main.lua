ESX     = nil


TriggerEvent("esx:getSharedObject", function(respone)
    ESX = respone
end)

--Pick Aple
RegisterServerEvent('mnz_PickApel:getItem')
AddEventHandler('mnz_PickApel:getItem', function()
    local luck = math.random (1, 3)
    if luck == 1 then
        local item = {
            'apel'
        }
        local xPlayer = ESX.GetPlayerFromOd(source)
        local randomitem = Item[math.random(#items)]
        local quantity = math.random (items)
        local itemfound = ESX.GetItemLabel(randomitem)
        xPlayer.addInventoryItem()
        TriggerClientEvent('NOTIF')
    else
        TriggerClientEvent('NOTIF NO')
    end
end)

