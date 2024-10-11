local isHudEnabled = true
local isHudStarted = false
local Player <const> = LocalPlayer.state

RegisterCommand("hud", function(source, args, rawCommand)
    isHudEnabled = not isHudEnabled
    SendNUIMessage({
        type = "hud",
        enable = isHudEnabled
    })
end, false)

ESX = exports["es_extended"]:getSharedObject()

RegisterNUICallback("hudStarted", function(data, cb)
    isHudStarted = true
    cb(ok)
end)

CreateThread(function()

    while not isHudStarted do
        Wait(100)
    end

    while (Player.job) == nil do
		Wait(10)
	end

    while (Player.uniqueId) == nil do
        Wait(10)
    end

    local infos = { 
        job = Player.job.label,
        organisation = Player.organisation.label,
        money = ESX.Math.GroupDigits(ESX.GetPlayerData().money),
        health = GetEntityHealth(cache.ped)/2, 
        armor = GetPedArmour(cache.ped),
        uId = Player.uniqueId,
        pId = cache.serverId
    }
            
    SendNUIMessage({
        type = "updateInfo",
        infos = infos
    })
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(playerData)
    local infos = { 
        job = playerData.job.label,
        organisation = playerData.organisation.label,
        money = ESX.Math.GroupDigits(playerData.money),
        health = GetEntityHealth(cache.ped),
        armor = GetPedArmour(cache.ped),
    }

    SendNUIMessage({
        type = "updateInfo",
        infos = infos
    })
end)

RegisterNetEvent("esx:setAccountMoney")
AddEventHandler("esx:setAccountMoney", function(account)
    if account.name == "money" then
        SendNUIMessage({
            type = "updateInfo",
            infos = {
                money = ESX.Math.GroupDigits(account.money)
            }
        })
    end
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    SendNUIMessage({
        type = "updateInfo",
        infos = {
            job = job.label
        }
    })
end)

RegisterNetEvent("esx:setOrganisation")
AddEventHandler("esx:setOrganisation", function(organisation)
    SendNUIMessage({
        type = "updateInfo",
        infos = { organisation = organisation.label }
    })
end)

RegisterNetEvent("esx_status:onTick")
AddEventHandler("esx_status:onTick", function(data)
    local hunger, thirst
    for i = 1, #data do
        if data[i].name == "thirst" then
            thirst = math.floor(data[i].percent)
        end
        if data[i].name == "hunger" then
            hunger = math.floor(data[i].percent)
        end
    end

    SendNUIMessage({
        type = "updateInfo",
        infos = {
            hunger = hunger,
            thirst = thirst
        }
    })
end)

RegisterNetEvent("blackdream::hud:showHud")
AddEventHandler("blackdream::hud:showHud", function()
    isHudEnabled = true
    SendNUIMessage({
        type = "hud",
        enable = isHudEnabled
    })
    DisplayRadar(true)
end)

RegisterNetEvent("blackdream::hud:hideHud")
AddEventHandler("blackdream::hud:hideHud", function()
    isHudEnabled = false
    SendNUIMessage({
        type = "hud",
        enable = isHudEnabled
    })

    -- hide minimap
    DisplayRadar(false)
end)

RegisterCommand("hud", function(source, args, rawCommand)
    isHudEnabled = not isHudEnabled
    SendNUIMessage({
        type = "hud",
        enable = isHudEnabled
    })
end, false)

CreateThread(function()
    while true do
        Wait(1000)

        local infos = { 
            health = GetEntityHealth(cache.ped)/2, 
            armor = GetPedArmour(cache.ped),
        } 
            
        SendNUIMessage({
            type = "updateInfo",
            infos = infos
        })
    end
end)

RegisterNetEvent("UI:PlayerTalking")
AddEventHandler("UI:PlayerTalking", function(talking)
    local infos = { talking = talking }

    SendNUIMessage({
        type = "updateInfo",
        infos = infos
    })
end)