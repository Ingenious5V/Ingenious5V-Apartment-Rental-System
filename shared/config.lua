Config = {}

-- Framework Configuration
Config.Framework = 'ESX' -- Change to 'QBCore' or other frameworks if needed

-- Target Configuration
Config.Target = 'ox_target' -- Options: 'ox_target', 'qtarget', 'none'

Config.Apartments = {
    {name = "Alta Street", price = 500},
    {name = "Integrity Way", price = 750},
    {name = "Tinsel Towers", price = 1000}
}

Config.Interiors = {
    {name = "Modern", id = 1},
    {name = "Classic", id = 2},
    {name = "Vintage", id = 3},
    {name = "K4MB1 Shell 1", id = 4},
    {name = "K4MB1 Shell 2", id = 5},
    {name = "K4MB1 Shell 3", id = 6}
}

-- Function to add more shells
function Config.AddShell(name, id)
    table.insert(Config.Interiors, {name = name, id = id})
end

-- Adding more shells
Config.AddShell("K4MB1 Shell 4", 7)
Config.AddShell("K4MB1 Shell 5", 8)

Config.PedLocation = {
    coords = vector3(-268.0, -957.0, 31.0),
    heading = 200.0,
    rotation = 0.0, -- Rotation in degrees
    model = "a_m_m_business_01" -- Default ped model
}
