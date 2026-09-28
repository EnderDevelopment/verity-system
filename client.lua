local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Function to open verity menu
function OpenVerityMenu()
    local elements = {
        {label = 'Set Verity', value = 'set_verity'},
        {label = 'Check Verity', value = 'check_verity'}
    }

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'verity_menu', {
        title    = 'Verity System',
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == 'set_verity' then
            TriggerServerEvent('verity:setVerity')
        elseif data.current.value == 'check_verity' then
            TriggerServerEvent('verity:checkVerity')
        end
    end, function(data, menu)
        menu.close()
    end)
end

-- Register command to open verity menu
RegisterCommand('verity', function()
    OpenVerityMenu()
end, false)

-- Event to notify player about verity status
RegisterNetEvent('verity:notify')
AddEventHandler('verity:notify', function(message)
    ESX.ShowNotification(message)
end)