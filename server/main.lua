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
