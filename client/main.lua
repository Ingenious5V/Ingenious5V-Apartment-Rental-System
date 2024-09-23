local selectedApartment = nil
local selectedInterior = nil

Citizen.CreateThread(function()
    local pedModel = GetHashKey(Config.PedLocation.model)
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end

    local ped = CreatePed(4, pedModel, Config.PedLocation.coords.x, Config.PedLocation.coords.y, Config.PedLocation.coords.z, Config.PedLocation.heading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityHeading(ped, Config.PedLocation.rotation)

    if Config.Target == 'ox-target' then
        exports['ox_target']:AddEntityZone('rent_ped', ped, {
            name = 'rent_ped',
            debugPoly = false,
            useZ = true
        }, {
            options = {
                {
                    event = 'rentapartment',
                    icon = 'fas fa-home',
                    label = 'Rent An Apartment',
                }
            },
            distance = 2.5
        })
    elseif Config.Target == 'qtarget' then
        exports['qtarget']:AddTargetEntity(ped, {
            options = {
                {
                    event = 'rentapartment',
                    icon = 'fas fa-home',
                    label = 'Rent An Apartment',
                }
            },
            distance = 2.5
        })
    else
        while true do
            Wait(0)
            DrawMarker(1, Config.PedLocation.coords.x, Config.PedLocation.coords.y, Config.PedLocation.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
            if IsControlJustReleased(0, 38) then -- E key
                local playerCoords = GetEntityCoords(PlayerPedId())
                local distance = GetDistanceBetweenCoords(playerCoords, Config.PedLocation.coords, true)
                if distance < 2.0 then
                    TriggerEvent('rentapartment')
                end
            end
        end
    end
end)

RegisterNetEvent('rentapartment')
AddEventHandler('rentapartment', function()
    local apartmentOptions = {}
    for i, apt in ipairs(Config.Apartments) do
        table.insert(apartmentOptions, {
            title = apt.name,
            description = "$" .. apt.price .. " per week",
            image = apt.image,
            event = 'selectinterior',
            args = {apartment = apt}
        })
    end

    lib.registerContext({
        id = 'apartment_menu',
        title = 'Select an Apartment',
        options = apartmentOptions,
        style = {
            width = 600,
            height = 400,
            backgroundColor = '#1e1e1e',
            textColor = '#ffffff',
            headerColor = '#ff0000',
            borderColor = '#ff0000',
            borderWidth = 2,
            borderRadius = 10,
            padding = 10,
            margin = 10,
            font = 'Arial',
            fontSize = 16,
            tablet = true
        }
    })

    lib.showContext('apartment_menu')
end)

RegisterNetEvent('selectinterior')
AddEventHandler('selectinterior', function(data)
    selectedApartment = data.apartment

    local interiorOptions = {}
    for i, int in ipairs(Config.Interiors) do
        table.insert(interiorOptions, {
            title = int.name,
            image = int.image,
            event = 'confirmrental',
            args = {interior = int}
        })
    end

    lib.registerContext({
        id = 'interior_menu',
        title = 'Select an Interior',
        options = interiorOptions,
        style = {
            width = 600,
            height = 400,
            backgroundColor = '#1e1e1e',
            textColor = '#ffffff',
            headerColor = '#ff0000',
            borderColor = '#ff0000',
            borderWidth = 2,
            borderRadius = 10,
            padding = 10,
            margin = 10,
            font = 'Arial',
            fontSize = 16,
            tablet = true
        }
    })

    lib.showContext('interior_menu')
end)

RegisterNetEvent('confirmrental')
AddEventHandler('confirmrental', function(data)
    selectedInterior = data.interior
    local totalRent = selectedApartment.price
    print("You have selected " .. selectedApartment.name .. " with a " .. selectedInterior.name .. " interior.")
    print("Your total rent is $" .. totalRent .. " per week.")

    -- Save rental information to the database
    TriggerServerEvent('rentapartment:saveRental', selectedApartment, selectedInterior)

    -- Show teleport option
    lib.registerContext({
        id = 'teleport_menu',
        title = 'Apartment Rental',
        options = {
            {
                title = 'Teleport Now',
                event = 'teleportToApartment'
            },
            {
                title = 'Close',
                event = 'closeMenu'
            }
        },
        style = {
            width = 600,
            height = 200,
            backgroundColor = '#1e1e1e',
            textColor = '#ffffff',
            headerColor = '#ff0000',
            borderColor = '#ff0000',
            borderWidth = 2,
            borderRadius = 10,
            padding = 10,
            margin = 10,
            font = 'Arial',
            fontSize = 16,
            tablet = true
        }
    })

    lib.showContext('teleport_menu')
end)

RegisterNetEvent('teleportToApartment')
AddEventHandler('teleportToApartment', function()
    -- Check if the player exists before teleporting
    if DoesEntityExist(PlayerPedId()) and not IsEntityDead(PlayerPedId()) then
        -- Teleport the player to the selected apartment's location
        SetEntityCoords(PlayerPedId(), selectedApartment.coords.x, selectedApartment.coords.y, selectedApartment.coords.z)
    end
end)

RegisterNetEvent('closeMenu')
AddEventHandler('closeMenu', function()
    -- Close the menu
    lib.hideContext()
end)

function GetUserInput(text, example, length)
    AddTextEntry('FMMC_KEY_TIP1', text .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", example, "", "", "", length)
    while (UpdateOnscreenKeyboard() == 0) do
        Wait(0)
    end
    return GetOnscreenKeyboardResult() -- Return the input result
end
