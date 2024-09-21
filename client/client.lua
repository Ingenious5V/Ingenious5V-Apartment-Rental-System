local selectedApartment = nil
local selectedInterior = nil

Citizen.CreateThread(function()
    local pedModel = GetHashKey("a_m_m_business_01")
    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do
        Wait(1)
    end

    local ped = CreatePed(4, pedModel, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z, Config.PedLocation.heading, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)

    while true do
        Wait(0)
        DrawMarker(1, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, true, 2, nil, nil, false)
        if IsControlJustReleased(0, 38) then -- E key
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = GetDistanceBetweenCoords(playerCoords, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z, true)
            if distance < 2.0 then
                TriggerEvent('rentapartment')
            end
        end
    end
end)

RegisterCommand('rentapartment', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)

    -- Display apartment options
    print("Select an apartment:")
    for i, apt in ipairs(Config.Apartments) do
        print(i .. ". " .. apt.name .. " - $" .. apt.price .. " per week")
    end

    -- Get player input for apartment selection
    local aptChoice = tonumber(GetUserInput("Enter apartment number: ", "", 2))
    selectedApartment = Config.Apartments[aptChoice]

    -- Display interior options
    print("Select an interior:")
    for i, int in ipairs(Config.Interiors) do
        print(i .. ". " .. int.name)
    end

    -- Get player input for interior selection
    local intChoice = tonumber(GetUserInput("Enter interior number: ", "", 2))
    selectedInterior = Config.Interiors[intChoice]

    -- Calculate total rent
    local totalRent = selectedApartment.price
    print("You have selected " .. selectedApartment.name .. " with a " .. selectedInterior.name .. " interior.")
    print("Your total rent is $" .. totalRent .. " per week.")
end, false)

function GetUserInput(text, example, length)
    AddTextEntry('FMMC_KEY_TIP1', text .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", example, "", "", "", length)
    while (UpdateOnscreenKeyboard() == 0) do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (GetOnscreenKeyboardResult()) then
        return GetOnscreenKeyboardResult()
    end
    return nil
end
