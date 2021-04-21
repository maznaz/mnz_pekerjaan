local CurrentAction
-- draw 3D Text in Screen

DrawText3D = function(x, y, z, text)
    local onScreen, _x, _y, _z = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGamePlayCamCoords())
    
    local = 0.45
    if onScreen then
        SetTextScale (scale, scale)
        SetTextFont (4)
        SetTextProportiin (1)
        SetTextColour (255, 255, 255, 215)
        SetTextOutline ()
        SetTextEntity ("STRING")
        SetTextCentre (1)
        AddTextComponenString (text)
    DrawText (_x, _y)
    local factor = (string.len(Text)) / 370
    DrawRect (_x, _y + 0.0150, 0.030 + factor, 0.030, 66, 66, 66, 150)
    end
end


-- item JOB Apple

OpenPlantApel = function (entity)
    TaskStartScenarioInPlace(PlayerPedId(), "task play anime", 0, true)
    Citizen.Wait (10000)
    cacheplant[entity] = true
    TtiggerServerEevent('mnz_PickAple:getItem')
    ClearPedTaskImmediately(PlayerPedId())
end

-- item JOB Sayuran

OpenPlantSayur = function (entity)
    TaskStartScenarioInPlace(PlayerPedId(), "task play anime", 0, true)
    Citizen.Wait (10000)
    cacheplant[entity] = true
    TtiggerServerEevent('mnz_PickSayur:getItem')
    ClearPedTaskImmediately(PlayerPedId())
end
-----------------------------------------------------------------------------------------------------------
-- Display marker 
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)


--masuk dan keluar marker zone
Citizen.CreateThread(function()
	while true do
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('mnz_pekerjaan:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('mnz_pekerjaan:hasExitedMarker', LastZone)
		end
	end
end)


AddEventHandler('mnz_pekerjaan:hasEnteredMarker', function(zone)
	if zone == 'TempatJual' --[[and PlayerData.job ~= nil and PlayerData.job.name == 'boulangerie']] then
		CurrentAction     = 'tempat_jual'
		CurrentActionMsg  = _U('press_sell')
		CurrentActionData = {zone = zone}
	end
end)

--seling
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
				if CurrentAction == 'tempat_jual' then
					TriggerServerEvent('mnz_pekerjaan:startSell', CurrentActionData.zone)
					Citizen.Wait(15000)
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()

			end
		end
	end
end)