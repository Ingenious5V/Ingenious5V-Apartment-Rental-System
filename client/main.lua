-- client/main.lua

-- Function to initialize the target system
local function initializeTargetSystem()
    if Config.TargetSystem == 'ox_target' then
        -- Initialize ox_target
        print('Initializing ox_target...')
        -- Add your ox_target initialization code here
        exports.ox_target:addLocalEntity({
            name = 'apartment_ped',
            label = 'Rent An Apartment',
            icon = 'fas fa-home',
            onSelect = function()
                showApartmentChoices()
            end
        })

    elseif Config.TargetSystem == 'qtarget' then
        -- Initialize qtarget
        print('Initializing qtarget...')
        -- Add your qtarget initialization code here
        exports.qtarget:AddTargetEntity(ped, {
            options = {
                {
                    event = 'rentApartment',
                    icon = 'fas fa-home',
                    label = 'Rent An Apartment'
                }
            },
            distance = 2.5
        })

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
    local pedType = Config.PedType
    local pedRotation = Config.PedRotation

    -- Load the ped model
    RequestModel(pedType)
    while not HasModelLoaded(pedType) do
        Wait(1)
    end

    -- Create the ped at the specified location with the specified rotation
    local ped = CreatePed(4, pedType, pedLocation.x, pedLocation.y, pedLocation.z, pedRotation, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    print('Created ped marker at:', pedLocation, 'with ped type:', pedType, 'and rotation:', pedRotation)

    -- Register the ped with the target system
    if Config.TargetSystem == 'ox_target' then
        exports.ox_target:addLocalEntity(ped, {
            name = 'apartment_ped',
            label = 'Rent An Apartment',
            icon = 'fas fa-home',
            onSelect = function()
                showApartmentChoices()
            end
        })
    elseif Config.TargetSystem == 'qtarget' then
        exports.qtarget:AddTargetEntity(ped, {
            options = {
                {
                    event = 'rentApartment',
                    icon = 'fas fa-home',
                    label = 'Rent An Apartment'
                }
            },
            distance = 2.5
        })
    end
end

-- Function to show apartment choices
local function showApartmentChoices()
    -- Add your code to display the apartment choices UI
    print('Showing apartment choices...')
    -- Example: Trigger a NUI callback to open the UI
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openApartmentMenu',
        apartments = {
            {name = 'Apartment 1', price = 1000},
            {name = 'Apartment 2', price = 1500},
            {name = 'Apartment 3', price = 2000}
        }
    })
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

