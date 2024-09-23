Config = {}

-- Framework Configuration
Config.Framework = 'ESX' -- Change to 'QBCore' or other frameworks if needed

-- Target Configuration
Config.Target = 'ox-target' -- Options: 'ox-target', 'qtarget', 'none'

Config.Apartments = {
    {name = "Alta Street", price = 500, image = "https://example.com/alta_street.jpg", coords = vector3(-268.0, -957.0, 31.0)},
    {name = "Integrity Way", price = 750, image = "https://example.com/integrity_way.jpg", coords = vector3(-268.0, -957.0, 31.0)},
    {name = "Tinsel Towers", price = 1000, image = "https://example.com/tinsel_towers.jpg", coords = vector3(-268.0, -957.0, 31.0)}
}

Config.Interiors = {
    {name = "Modern", id = 1, image = "https://example.com/modern.jpg"},
    {name = "Classic", id = 2, image = "https://example.com/classic.jpg"},
    {name = "Vintage", id = 3, image = "https://example.com/vintage.jpg"},
    {name = "K4MB1 Shell 1", id = 4, image = "https://example.com/k4mb1_shell1.jpg"},
    {name = "K4MB1 Shell 2", id = 5, image = "https://example.com/k4mb1_shell2.jpg"},
    {name = "K4MB1 Shell 3", id = 6, image = "https://example.com/k4mb1_shell3.jpg"}
}

-- Function to add more shells
function Config.AddShell(name, id, image)
    table.insert(Config.Interiors, {name = name, id = id, image = image})
end

-- Adding more shells
Config.AddShell("K4MB1 Shell 4", 7, "https://example.com/k4mb1_shell4.jpg")
Config.AddShell("K4MB1 Shell 5", 8, "https://example.com/k4mb1_shell5.jpg")

Config.PedLocation = {
    coords = vector3(-268.0, -957.0, 31.0),
    heading = 200.0,
    rotation = 0.0, -- Rotation in degrees
    model = "a_m_m_business_01" -- Default ped model
}
