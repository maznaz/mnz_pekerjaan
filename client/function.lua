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
