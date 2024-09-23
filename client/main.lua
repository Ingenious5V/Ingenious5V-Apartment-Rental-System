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
                    label = 'Rent An Apartment',
                    action = function(entity)
                        showApartmentChoices()
                    end
                }
            },
            distance = 2.5
        })

    elseif Config.TargetSystem == 'none' then
        -- No target system
        print('No target system selected.')
        -- Add a command to open the UI for testing purposes
        RegisterCommand('openApartmentMenu', function()
            showApartmentChoices()
        end, false)
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
                    label = 'Rent An Apartment',
                    action = function(entity)
                        showApartmentChoices()
                    end
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
        apartments = Config.Apartments
    })
end

-- Call the functions to initialize the target system and create the ped marker
initializeTargetSystem()
createPedMarker()

-- Existing client script logic...
