Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 213 -- https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 256) -- It returnes 64 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["storerobbery"] = {
        minimum = 4,
        busy = false,
    },
    ["bankrobbery"] = {
        minimum = 6,
        busy = false,
    },
    ["jewellery"] = {
        minimum = 6,
        busy = false,
    },
    ["pacific"] = {
        minimum = 8,
        busy = false,
    },
}

-- Current Cops Online
Config.CurrentCops = 0

-- Current Ambulance / Doctors Online
Config.CurrentAmbulance = 0