local rentedApartments = {}

RegisterServerEvent('rentapartment:saveRental')
AddEventHandler('rentapartment:saveRental', function(apartment, interior)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src) -- Change this to QBCore if you're using QBCore
    local identifier = xPlayer.identifier

    if not rentedApartments[identifier] then
        rentedApartments[identifier] = {}
    end

    -- Create rental entry
    local rentDue = os.time() + (7 * 24 * 60 * 60) -- Rent due in one week
    table.insert(rentedApartments[identifier], {
        apartment = apartment,
        interior = interior,
        rentDue = rentDue
    })

    -- Save to database
    MySQL.Async.execute('INSERT INTO rented_apartments (identifier, apartment, interior, rent_due) VALUES (@identifier, @apartment, @interior, @rent_due)', {
        ['@identifier'] = identifier,
        ['@apartment'] = json.encode(apartment),
        ['@interior'] = json.encode(interior),
        ['@rent_due'] = rentDue
    })

    TriggerClientEvent('esx:showNotification', src, "You have successfully rented " .. apartment.name .. " with a " .. interior.name .. " interior.")
end)

RegisterServerEvent('rentapartment:payRent')
AddEventHandler('rentapartment:payRent', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src) -- Change this to QBCore if you're using QBCore
    local identifier = xPlayer.identifier

    if rentedApartments[identifier] then
        for i, rental in ipairs(rentedApartments[identifier]) do
            if os.time() > rental.rentDue then
                if xPlayer.getMoney() >= rental.apartment.price then
                    xPlayer.removeMoney(rental.apartment.price)
                    rental.rentDue = os.time() + (7 * 24 * 60 * 60) -- Extend rent due by one week

                    -- Update database
                    MySQL.Async.execute('UPDATE rented_apartments SET rent_due = @rent_due WHERE identifier = @identifier AND apartment = @apartment AND interior = @interior', {
                        ['@rent_due'] = rental.rentDue,
                        ['@identifier'] = identifier,
                        ['@apartment'] = json.encode(rental.apartment),
                        ['@interior'] = json.encode(rental.interior)
                    })

                    TriggerClientEvent('esx:showNotification', src, "You have paid the rent for " .. rental.apartment.name .. ".")
                else
                    TriggerClientEvent('esx:showNotification', src, "You do not have enough money to pay the rent for " .. rental.apartment.name .. ".")
                end
            end
        end
    end
end)

ESX.RegisterServerCallback('rentapartment:getRentedApartments', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source) -- Change this to QBCore if you're using QBCore
    local identifier = xPlayer.identifier

    if rentedApartments[identifier] then
        cb(rentedApartments[identifier])
    else
        cb({})
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        MySQL.Async.fetchAll('SELECT * FROM rented_apartments', {}, function(result)
            for i = 1, #result do
                local identifier = result[i].identifier
                local apartment = json.decode(result[i].apartment)
                local interior = json.decode(result[i].interior)
                local rentDue = result[i].rent_due

                if not rentedApartments[identifier] then
                    rentedApartments[identifier] = {}
                end

                table.insert(rentedApartments[identifier], {
                    apartment = apartment,
                    interior = interior,
                    rentDue = rentDue
                })
            end
        end)
    end
end)
