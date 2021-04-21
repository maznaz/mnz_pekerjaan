ESX     = nil
local PlayersSelling       = {}
local apel = 1
local sayur = 1

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

--Pick Aple
RegisterServerEvent('mnz_PickSayur:getItem')
AddEventHandler('mnz_PickSayur:getItem', function()
    local luck = math.random (1, 3)
    if luck == 1 then
        local item = {
            'sayur'
        }
        local xPlayer = ESX.GetPlayerFromOd(source)
        local randomitem = Item[math.random(#items)]
        local quantity = math.random (items)
        local itemfound = ESX.GetItemLabel(randomitem)
        xPlayer.addInventoryItem()
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'inform', text = 'Anda mendapatkan Sayur', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Sayur sudah di petik.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
    end
end)



-------------------tempat JUALAN Hasil Kerja
local function Jual(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'TempatJual' then
			if xPlayer.getInventoryItem('apel').count <= 0 then
				apel = 0
			else
				apel = 1
			end
			
			if xPlayer.getInventoryItem('sayur').count <= 0 then
				sayur = 0
			else
				sayur = 1
			end
		
			if apel == 0 and sayur == 0 then
				--TriggerClientEvent('esx:showNotification', source, _U('no_product_sale'))
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Tidak ada barang untk di jual.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				return
			elseif xPlayer.getInventoryItem('apel').count <= 0 and sayur == 0 then
				--TriggerClientEvent('esx:showNotification', source, _U('no_vin_sale'))
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Tidak ada Apel untk di jual.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				apel = 0
				return
			elseif xPlayer.getInventoryItem('painpremierprix').count <= 0 and apel == 0then
				--TriggerClientEvent('esx:showNotification', source, _U('no_sayur_sale'))
                TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Tidak ada Sayur untk di jual.', length = 2500, style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
				sayur = 0
				return
			else
				if (sayur == 1) then
					SetTimeout(1100, function()
						local money = math.random(8000,10000)
						xPlayer.removeInventoryItem('sayur', 1000)
						local societyAccount = nil
						xPlayer.addMoney(money)
						TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						Sell(source,zone)
					end)
				elseif (apel == 1) then
					SetTimeout(1100, function()
						local money = math.random(55,75)
						xPlayer.removeInventoryItem('apel', 4)
						xPlayer.addMoney(money)
						TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money)
						Sell(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('mnz_pekerjaan:startSell')
AddEventHandler('mnz_pekerjaan:startSell', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, 'Attendez')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell(_source, zone)
	end

end)
