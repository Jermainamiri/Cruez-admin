local isOpen = false
local warningOpen = false

RegisterCommand('kick', function()
    TriggerServerEvent('cruze-kickmenu:server:getPlayers')
end)

RegisterNetEvent('cruze-kickmenu:client:openMenu', function(players)

    SetNuiFocus(true, true)

    isOpen = true

    SendNUIMessage({
        action = 'open',
        players = players
    })
end)

RegisterNUICallback('close', function(_, cb)

    SetNuiFocus(false, false)

    isOpen = false

    cb({})
end)

RegisterNUICallback('kickPlayer', function(data, cb)

    TriggerServerEvent(
        'cruze-kickmenu:server:kickPlayer',
        data.id,
        data.reason
    )

    cb({})
end)

RegisterNUICallback('warnPlayer', function(data, cb)

    TriggerServerEvent(
        'cruze-kickmenu:server:warnPlayer',
        data.id,
        data.reason
    )

    cb({})
end)

RegisterNUICallback('toggleFreeze', function(data, cb)

    TriggerServerEvent(
        'cruze-kickmenu:server:toggleFreeze',
        data.id
    )

    cb({})
end)

RegisterNUICallback('gotoPlayer', function(data, cb)

    TriggerServerEvent(
        'cruze-kickmenu:server:gotoPlayer',
        data.id
    )

    cb({})
end)

RegisterNUICallback('bringPlayer', function(data, cb)

    TriggerServerEvent(
        'cruze-kickmenu:server:bringPlayer',
        data.id
    )

    cb({})
end)

RegisterNetEvent('cruze-kickmenu:client:showWarning', function(reason)

    warningOpen = true

    SendNUIMessage({
        action = 'showWarning',
        reason = reason
    })

    CreateThread(function()

        local holdTime = 0

        while warningOpen do

            Wait(100)

            if IsControlPressed(0, 38) then

                holdTime = holdTime + 1

                SendNUIMessage({
                    action = 'updateProgress',
                    progress = holdTime
                })

                if holdTime >= 100 then

                    warningOpen = false

                    SendNUIMessage({
                        action = 'hideWarning'
                    })
                end

            else

                if holdTime > 0 then
                    holdTime = holdTime - 2
                end

                if holdTime < 0 then
                    holdTime = 0
                end

                SendNUIMessage({
                    action = 'updateProgress',
                    progress = holdTime
                })
            end
        end
    end)
end)

RegisterNetEvent('cruze-kickmenu:client:setFreeze', function(state)

    FreezeEntityPosition(PlayerPedId(), state)

    if state then

        lib.notify({
            title = 'Admin Menu',
            description = 'Je bent bevroren door een stafflid.',
            type = 'inform'
        })

    else

        lib.notify({
            title = 'Admin Menu',
            description = 'Je bent weer vrijgegeven.',
            type = 'success'
        })
    end
end)