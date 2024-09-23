Config = {}

-- Framework Configuration
Config.Framework = 'ESX' -- Change to 'QBCore' or other frameworks if needed

-- Target Configuration
Config.Target = 'qtarget' -- Options: 'ox_target', 'qtarget', 'none'

Config.DefaultApartmentImage = "html/images/defaultapartment.png"
Config.DefaultInteriorImage = "html/images/defaultinterior.png"

-- Define apartments with associated interior IDs and marker locations
Config.Apartments = {
    {id = 1, name = "South Rockford Drive", price = 600, image = Config.DefaultApartmentImage, 
     coords = vector3(-667.372, -1106.034, 14.629), teleportCoords = vector3(-667.601, -1107.354, 15.133), 
     interior_id = 1, markerCoords = vector3(-667.372, -1106.034, 13.629)},
     
    {id = 2, name = "Morningwood Blvd", price = 700, image = Config.DefaultApartmentImage, 
     coords = vector3(-1288.046, -430.126, 35.077), teleportCoords = vector3(-1288.52, -430.51, 35.15), 
     interior_id = 2, markerCoords = vector3(-1288.046, -430.126, 34.077)},
     
    {id = 3, name = "Integrity Way", price = 800, image = Config.DefaultApartmentImage, 
     coords = vector3(269.075, -640.672, 42.02), teleportCoords = vector3(280.66, -652.12, 42.02), 
     interior_id = 3, markerCoords = vector3(269.075, -640.672, 41.02)},
     
    {id = 4, name = "Tinsel Towers", price = 900, image = Config.DefaultApartmentImage, 
     coords = vector3(-621.016, 46.677, 43.591), teleportCoords = vector3(-621.016, 46.677, 43.591), 
     interior_id = 4, markerCoords = vector3(-621.016, 46.677, 42.591)}
}

-- Define interiors associated with apartments
Config.Interiors = {
    {id = 1, name = "Modern", image = Config.DefaultInteriorImage},
    {id = 2, name = "Classic", image = Config.DefaultInteriorImage},
    {id = 3, name = "Vintage", image = Config.DefaultInteriorImage},
    {id = 4, name = "K4MB1 Shell 1", image = Config.DefaultInteriorImage},
    {id = 5, name = "K4MB1 Shell 2", image = Config.DefaultInteriorImage},
    {id = 6, name = "K4MB1 Shell 3", image = Config.DefaultInteriorImage}
}

Config.PedLocation = {
    coords = vector3(-706.5013, 273.1601, 82.1474),
    heading = 200.0,
    model = "a_m_m_business_01", -- Default ped model
    showMarker = true, -- Show marker at ped location
    markerType = 1, -- Marker type (1 = cylinder, 2 = arrow, etc.)
    markerColor = {r = 255, g = 0, b = 0, a = 100}, -- Marker color
    markerScale = {x = 1.0, y = 1.0, z = 1.0} -- Marker scale
}

-- Function to rent an apartment
function RentApartment(playerId, apartmentId)
    -- Check if the apartment exists
    local apartment = MySQL.query('SELECT * FROM Apartments WHERE id = ?', {apartmentId})
    
    if apartment and #apartment > 0 then
        local rentStart = os.date("%Y-%m-%d %H:%M:%S")
        local rentEnd = os.date("%Y-%m-%d %H:%M:%S", os.time() + 30 * 24 * 60 * 60) -- 30 days from now
        local interiorId = apartment[1].interior_id -- Get the associated interior ID

        -- Insert rental record into RentedApartments table
        MySQL.execute('INSERT INTO RentedApartments (player_id, apartment_id, interior_id, rent_start, rent_end) VALUES (?, ?, ?, ?, ?)', {
            playerId,
            apartmentId,
            interiorId,
            rentStart,
            rentEnd
        })

        -- Load the interior for the player
        LoadInteriorForPlayer(playerId, interiorId)
    else
        print("Apartment not found or empty!")
    end
end

-- Function to load an interior for a player
function LoadInteriorForPlayer(playerId, interiorId)
    local interior = MySQL.query('SELECT * FROM Interiors WHERE id = ?', {interiorId})

    if interior and #interior > 0 then
        -- Implement logic to load the interior using qb-interior or your own system
        -- Example:
        QBCore.Functions.LoadInterior(interior[1].name) -- Replace with actual field name if necessary
    else
        print("Interior not found or empty!")
    end
end

-- Function to create the ped
function CreatePedAtLocation()
    RequestModel(Config.PedLocation.model)
    while not HasModelLoaded(Config.PedLocation.model) do
        Wait(500)
    end

    local ped = CreatePed(4, Config.PedLocation.model, Config.PedLocation.coords, Config.PedLocation.heading, false, true)
    SetEntityHeading(ped, Config.PedLocation.heading)

    if Config.PedLocation.showMarker then
        -- Logic to show marker
        Citizen.CreateThread(function()
            while true do
                Wait(0)
                DrawMarker(Config.PedLocation.markerType, Config.PedLocation.coords, 0, 0, 0, 0, 0, 0, 
                Config.PedLocation.markerScale.x, Config.PedLocation.markerScale.y, Config.PedLocation.markerScale.z, 
                Config.PedLocation.markerColor.r, Config.PedLocation.markerColor.g, Config.PedLocation.markerColor.b, 
                Config.PedLocation.markerColor.a, false, true, 2, nil, nil, false, false, false, false, false)
            end
        end)
    end
end

-- Function to create apartment entrance markers
function CreateApartmentMarkers()
    for _, apartment in ipairs(Config.Apartments) do
        Citizen.CreateThread(function()
            while true do
                Wait(0)
                DrawMarker(1, apartment.markerCoords, 0, 0, 0, 0, 0, 0, 
                Config.PedLocation.markerScale.x, Config.PedLocation.markerScale.y, Config.PedLocation.markerScale.z, 
                0, 255, 0, 100, -- Green marker color
                false, true, 2, nil, nil, false, false, false, false, false)
                
                -- Logic to check player proximity and interact
                local playerCoords = GetEntityCoords(PlayerPedId())
                if Vdist(playerCoords, apartment.markerCoords) < 1.5 then
                    -- Trigger apartment access (add your interaction code here)
                    -- Example: DrawText("Press [E] to enter " .. apartment.name)
                    if IsControlJustReleased(0, 38) then -- E key
                        -- Code to enter the apartment (e.g., teleport to teleportCoords)
                        SetEntityCoords(PlayerPedId(), apartment.teleportCoords.x, apartment.teleportCoords.y, apartment.teleportCoords.z, false, false, false, true)
                    end
                end
            end
        end)
    end
end

-- Call the function to create the ped when the script starts
Citizen.CreateThread(function()
    CreatePedAtLocation()
    CreateApartmentMarkers() -- Create markers for all apartments
end)

-- Example usage of renting an apartment
-- RentApartment(playerId, selectedApartmentId)
