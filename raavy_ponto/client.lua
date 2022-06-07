Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")

func = Tunnel.getInterface(GetCurrentResourceName())

local onNui = false

function ToggleActionMenu()
    onNui = not onNui
    if onNui then
        TransitionFromBlurred(1000)
        SetNuiFocus(true, true)
        SendNUIMessage({mostre = true})
    else
        TransitionFromBlurred(1000)
        SetNuiFocus(false)
        SendNUIMessage({mostre = false})
    end
end

RegisterKeyMapping("nui", "INICIAR PONTO","KEYBOARD","E")
RegisterCommand("nui", function()
    local ped = PlayerPedId()
    for k,v in pairs(Config['locs']) do
        local distance = #(GetEntityCoords(ped) - vector3(v.x,v.y,v.z))   
        if distance < 1.5 then
            ToggleActionMenu()
        end
    end
end)

RegisterNUICallback("changejob", function(data)

    local alterarjob = data.teste
    --print(alterarjob)

    if alterarjob then
        func.entreservico()
    elseif alterarjob == false then
        func.sairservico()
    end

end)

RegisterNUICallback("state", function(data)
    SetNuiFocus(false)
    SendNUIMessage({mostre = false})
    ToggleActionMenu()
    onNui = data.page
end)

CreateThread(function()
    while true do
        
        local nome,sobrenome,testee = func.identidade()
        SendNUIMessage({
            nome = nome,
            sobrenome = sobrenome,
            testee = testee
        })
        Wait(4)
    end

end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        for k,v in pairs(Config['locs']) do
            local distance = #(GetEntityCoords(ped) - vector3(v.x,v.y,v.z))   
            if distance < 2.5 then 
                DrawMarker(v["blip"], v["x"],v["y"],v["z"], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, v["color"][1], v["color"][2], v["color"][3], v["color"][4], v["effect"], v["sync"], 2, v["rotate"])
            end
        end
        Wait(4)
    end
end)