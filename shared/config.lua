-- shared/config.lua
Config = {}

-- Target system options: 'ox_target', 'qtarget', or 'none'
Config.TargetSystem = 'ox_target' -- Default to 'ox_target'

-- Ped marker location (vector3 coordinates)
Config.PedMarkerLocation = vector3(0.0, 0.0, 0.0) -- Default coordinates

-- Ped type (model name)
Config.PedType = 'a_m_m_business_01' -- Default ped model

-- Ped rotation (heading in degrees)
Config.PedRotation = 0.0 -- Default rotation

-- Tablet UI dimensions
Config.TabletWidth = 400 -- Default width in pixels
Config.TabletHeight = 600 -- Default height in pixels

-- Default images
Config.DefaultApartmentImage = 'images/default_apartment.jpg'
Config.DefaultInteriorImage = 'images/default_interior.jpg'

-- Apartments configuration
Config.Apartments = {
    {
        name = 'Apartment 1',
        price = 1000,
        location = vector3(100.0, 200.0, 300.0),
        image = 'images/apartment1.jpg',
        interiorImage = 'images/interior1.jpg'
    },
    {
        name = 'Apartment 2',
        price = 1500,
        location = vector3(200.0, 300.0, 400.0),
        image = 'images/apartment2.jpg',
        interiorImage = 'images/interior2.jpg'
    },
    -- Add more apartments as needed
}
