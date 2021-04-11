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
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Anda mendapatkan apel', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Apel sudah di petik.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    end
end)

