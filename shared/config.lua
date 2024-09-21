Config = {}

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

Config.PedLocation = {
    x = -268.0,
    y = -957.0,
    z = 31.0,
    heading = 200.0
}
