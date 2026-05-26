local frozenPlayers = {}

RegisterNetEvent('cruze-kickmenu:server:getPlayers', function()

    local src = source
    local players = {}

    for _, id in pairs(GetPlayers()) do

        players[#players + 1] = {
            id = tonumber(id),
            name = GetPlayerName(id)
        }
    end

    TriggerClientEvent('cruze-kickmenu:client:openMenu', src, players)
end)

RegisterNetEvent('cruze-kickmenu:server:kickPlayer', function(target, reason)

    local src = source

    if not target then
        return
    end

    local kickReason = reason and reason ~= '' and reason or 'Geen reden opgegeven'

    TriggerClientEvent('ox_lib:notify', target, {
        title = 'Kick',
        description = ('Je wordt verwijderd van de server.\nReden: %s'):format(kickReason),
        type = 'error'
    })

    Wait(2000)

    DropPlayer(
        target,
        ('Je bent gekickt van Cruez Scripts.\nReden: %s'):format(kickReason)
    )

    print(('[Kick Menu] %s kicked %s | Reason: %s')
        :format(GetPlayerName(src), GetPlayerName(target), kickReason))
end)

RegisterNetEvent('cruze-kickmenu:server:warnPlayer', function(target, reason)

    local src = source

    if not target then
        return
    end

    local warnReason = reason and reason ~= '' and reason or 'Geen reden opgegeven'

    TriggerClientEvent('ox_lib:notify', target, {
        title = 'Waarschuwing',
        description = ('Je hebt een waarschuwing ontvangen.\nReden: %s'):format(warnReason),
        type = 'inform'
    })

    TriggerClientEvent(
        'cruze-kickmenu:client:showWarning',
        target,
        warnReason
    )

    print(('[Warning Menu] %s warned %s | Reason: %s')
        :format(GetPlayerName(src), GetPlayerName(target), warnReason))
end)

RegisterNetEvent('cruze-kickmenu:server:toggleFreeze', function(target)

    local src = source

    if not target then
        return
    end

    frozenPlayers[target] = not frozenPlayers[target]

    TriggerClientEvent(
        'cruze-kickmenu:client:setFreeze',
        target,
        frozenPlayers[target]
    )

    print(('[Cruez Menu] %s toggled freeze on %s')
        :format(GetPlayerName(src), GetPlayerName(target)))
end)

RegisterNetEvent('cruze-kickmenu:server:bringPlayer', function(target)

    local src = source

    if not target then
        return
    end

    local targetPed = GetPlayerPed(target)
    local adminPed = GetPlayerPed(src)

    local coords = GetEntityCoords(adminPed)

    SetEntityCoords(
        targetPed,
        coords.x,
        coords.y,
        coords.z
    )
end)

RegisterNetEvent('cruze-kickmenu:server:gotoPlayer', function(target)

    local src = source

    if not target then
        return
    end

    local targetPed = GetPlayerPed(target)
    local adminPed = GetPlayerPed(src)

    local coords = GetEntityCoords(targetPed)

    SetEntityCoords(
        adminPed,
        coords.x,
        coords.y,
        coords.z
    )
end)