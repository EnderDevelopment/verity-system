local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Function to set verity for a player
RegisterServerEvent('verity:setVerity')
AddEventHandler('verity:setVerity', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    -- Check if player has enough money
    if xPlayer.getMoney() >= Config.VerityPrice then
        -- Check if player is on cooldown
        MySQL.Async.fetchScalar('SELECT last_verity FROM verity_data WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(lastVerity)
            if lastVerity then
                local currentTime = os.time()
                local cooldownTime = os.time({year=lastVerity.year, month=lastVerity.month, day=lastVerity.day, hour=lastVerity.hour, min=lastVerity.min, sec=lastVerity.sec}) + Config.VerityCooldown

                if currentTime < cooldownTime then
                    TriggerClientEvent('verity:notify', source, 'You are on cooldown. Please wait before setting verity again.')
                    return
                end
            end

            -- Deduct money and set verity
            xPlayer.removeMoney(Config.VerityPrice)
            MySQL.Async.execute('INSERT INTO verity_data (identifier, verity_status, last_verity) VALUES (@identifier, TRUE, NOW()) ON DUPLICATE KEY UPDATE verity_status = TRUE, last_verity = NOW()', {
                ['@identifier'] = identifier
            }, function(rowsChanged)
                TriggerClientEvent('verity:notify', source, 'Verity set successfully!')
            end)
        end)
    else
        TriggerClientEvent('verity:notify', source, 'You do not have enough money to set verity.')
    end
end)

-- Function to check verity status
RegisterServerEvent('verity:checkVerity')
AddEventHandler('verity:checkVerity', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier

    MySQL.Async.fetchScalar('SELECT verity_status FROM verity_data WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(verityStatus)
        if verityStatus then
            TriggerClientEvent('verity:notify', source, 'You have verity status.')
        else
            TriggerClientEvent('verity:notify', source, 'You do not have verity status.')
        end
    end)
end)