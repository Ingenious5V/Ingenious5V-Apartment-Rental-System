-- client/main.lua

-- Function to initialize the target system
local function initializeTargetSystem()
    if Config.TargetSystem == 'ox_target' then
        -- Initialize ox_target
        print('Initializing ox_target...')
        -- Add your ox_target initialization code here

    elseif Config.TargetSystem == 'qtarget' then
        -- Initialize qtarget
        print('Initializing qtarget...')
        -- Add your qtarget initialization code here

    elseif Config.TargetSystem == 'none' then
        -- No target system
        print('No target system selected.')
    else
        print('Invalid target system selected.')
    end
end

-- Function to create the ped marker
local function createPedMarker()
    local pedLocation = Config.PedMarkerLocation
    -- Add your code to create the ped marker at pedLocation
    print('Creating ped marker at:', pedLocation)
end

-- Call the functions to initialize the target system and create the ped marker
initializeTargetSystem()
createPedMarker()

-- Existing client script logic...


local selectedApartment = nil
local selectedInterior = nil

Citizen.CreateThread(function()
    local pedMarker = Config.PedMarkerLocation
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        if GetDistanceBetweenCoords(playerCoords, pedMarker.x, pedMarker.y, pedMarker.z, true) < 1.5 then
            -- Display prompt to rent apartment
            -- Handle player input to select apartment and shell
            -- TriggerServerEvent('ingenious5v:rentApartment', selectedApartment, selectedShell)
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

-- Existing client script logic...

-- Overextended integration logic
AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        print('Bridge client script started')
    end
end)

