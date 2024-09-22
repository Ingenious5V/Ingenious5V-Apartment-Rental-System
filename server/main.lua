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
-- server.lua

-- Function to deduct rent from player's bank account
function DeductRent(playerId, rentalId)
    -- Fetch rental details
    local rental = GetRentalDetails(rentalId)
    local rentAmount = rental.rental_price

    -- Fetch player's bank balance
    local playerBankBalance = GetPlayerBankBalance(playerId)

    -- Check if player has enough balance
    if playerBankBalance >= rentAmount then
        -- Deduct rent from player's bank account
        UpdatePlayerBankBalance(playerId, playerBankBalance - rentAmount)

        -- Notify player
        TriggerClientEvent('chat:addMessage', playerId, {
            args = {"System", "Rent of $" .. rentAmount .. " has been deducted from your bank account."}
        })
    else
        -- Notify player of insufficient funds
        TriggerClientEvent('chat:addMessage', playerId, {
            args = {"System", "Insufficient funds to pay rent of $" .. rentAmount .. "."}
        })
    end
end

-- Example function to get rental details (you'll need to implement this)
function GetRentalDetails(rentalId)
    -- Fetch rental details from the database
    -- This is a placeholder function, replace with actual database query
    return {
        rental_id = rentalId,
        rental_price = 1500.00 -- Example rent amount
    }
end

-- Example function to get player's bank balance (you'll need to implement this)
function GetPlayerBankBalance(playerId)
    -- Fetch player's bank balance from the database
    -- This is a placeholder function, replace with actual database query
    return 2000.00 -- Example bank balance
end

-- Example function to update player's bank balance (you'll need to implement this)
function UpdatePlayerBankBalance(playerId, newBalance)
    -- Update player's bank balance in the database
    -- This is a placeholder function, replace with actual database query
end

RegisterNetEvent('ingenious5v:rentApartment')
AddEventHandler('ingenious5v:rentApartment', function(apartmentName, selectedShell)
    local apartment = GetApartmentByName(apartmentName)
    if apartment then
        local shellPrice = GetShellPrice(apartment, selectedShell)
        local totalRent = apartment.price + shellPrice
        -- Proceed with the rental process using totalRent
    end
end)

function GetApartmentByName(name)
    for _, apartment in ipairs(Config.Apartments) do
        if apartment.name == name then
            return apartment
        end
    end
    return nil
end

function GetShellPrice(apartment, shell)
    for _, interior in ipairs(apartment.interiors) do
        if interior.shell == shell then
            return interior.price
        end
    end
    return 0
end

-- Existing server script logic...

-- Overextended integration logic
AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('Bridge server script started')
    end
end)
