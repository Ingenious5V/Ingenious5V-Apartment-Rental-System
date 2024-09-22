-- config.lua
Config = {}

-- Target system options: 'ox_target', 'qtarget', or 'none'
Config.TargetSystem = 'ox_target' -- Default to 'ox_target'

-- Ped marker location (vector3 coordinates)
Config.PedMarkerLocation = vector3(0.0, 0.0, 0.0) -- Default coordinates

-- Ped type (model name)
Config.PedType = 'a_m_m_business_01' -- Default ped model


Config.Apartments = {
    {
        name = "Downtown Apartment",
        price = 1200,
        interiors = {
            {shell = "shell_v16_low", price = 500},
            {shell = "shell_v16_mid", price = 750},
            {shell = "shell_v16_high", price = 1000}
        }
    },
    {
        name = "Beachside Apartment",
        price = 1800,
        interiors = {
            {shell = "shell_v16_low", price = 500},
            {shell = "shell_v16_mid", price = 750},
            {shell = "shell_v16_high", price = 1000}
        }
    },
    {
        name = "Luxury Penthouse",
        price = 2500,
        interiors = {
            {shell = "shell_v16_low", price = 500},
            {shell = "shell_v16_mid", price = 750},
            {shell = "shell_v16_high", price = 1000}
        }
    }
    -- Add more apartments as needed
}
-- Existing configurations...

-- Overextended integration configuration
Config.SomeFeature = true

