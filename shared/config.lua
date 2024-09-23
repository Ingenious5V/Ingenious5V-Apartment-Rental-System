Config = {}

-- Set the framework to use: 'esx', 'qbcore', or 'standalone'
Config.Framework = 'esx'  -- Change this to 'qbcore' or 'standalone' as needed

-- ESX Configuration
Config.ESX = {
    getSharedObject = 'esx:getSharedObject'
}

-- QB-Core Configuration
Config.QBCore = {
    getCoreObject = 'qb-core'
}

-- Standalone Configuration
Config.Standalone = {
    -- Add any standalone-specific configurations here
}
