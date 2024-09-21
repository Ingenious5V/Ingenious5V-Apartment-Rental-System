RegisterServerEvent('rentapartment:payRent')
AddEventHandler('rentapartment:payRent', function(apartment, rent)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getMoney() >= rent then
        xPlayer.removeMoney(rent)
        TriggerClientEvent('esx:showNotification', source, "You have paid $" .. rent .. " for renting " .. apartment.name)
    else
        TriggerClientEvent('esx:showNotification', source, "You don't have enough money to pay the rent!")
    end
end)
