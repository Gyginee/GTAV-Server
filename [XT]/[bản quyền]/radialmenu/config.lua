AxRadialMenu = {
    Menus = {
        [1] = {
            shouldclose = false,
            label = "Example",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [2] = {
            shouldclose = false,
            label = "Example",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [3] = {
            shouldclose = false,
            label = "Example",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [4] = {
            shouldclose = false,
            label = "Example",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [5] = {
            shouldclose = false,
            label = "Example",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [6] = {
            shouldclose = false,
            label = "Example",
            submenu = {},
            icon = "fas fa-briefcase"
        },
        [7] = {
            shouldclose = false,
            label = "Vehicle",
            submenu = {
                {
                    shouldclose = false,
                    label = "Front Left",
                    submenu = false,
                    event = "AXFW:PersonalMenu:Doors",
                    type = "client",
                    parameter = "f_l_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shouldclose = false,
                    label = "Front Right",
                    submenu = false,
                    event = "AXFW:PersonalMenu:Doors",
                    type = "client",
                    parameter = "f_r_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shouldclose = false,
                    label = "Rear Left",
                    submenu = false,
                    event = "AXFW:PersonalMenu:Doors",
                    type = "client",
                    parameter = "r_l_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shouldclose = false,
                    label = "Rear Right",
                    submenu = false,
                    event = "AXFW:PersonalMenu:Doors",
                    type = "client",
                    parameter = "r_r_doors",
                    icon = "fas fa-door-open"
                },
                {
                    shouldclose = false,
                    label = "Hood",
                    submenu = false,
                    event = "AXFW:PersonalMenu:Doors",
                    type = "client",
                    parameter = "hood",
                    icon = "fas fa-car"
                },
                {
                    shouldclose = false,
                    label = "Trunk",
                    submenu = false,
                    event = "AXFW:PersonalMenu:Doors",
                    type = "client",
                    parameter = "trunk",
                    icon = "fas fa-truck-loading"
                }
            },
            icon = "fas fa-car"
        },
        [8] = {
            shouldclose = false,
            label = "Extras",
            submenu = {},
            icon = "fas fa-truck-loading"
        },
        [9] = {
            shouldclose = false,
            label = "Work",
            submenu = {},
            icon = "fas fa-briefcase"
        },
    },
    WorkMenu = {}
}

LoadFrameWork = function()
    return exports.ax:GetFunctions()
end

PlayerJob = function()
    return Core.GetPlayer().job.name
end

Notification = function(text)
    return TriggerEvent('ax-ui:DoNotification',text)
end

DefaultMenuKey = 'F1' -- Default Key (https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/) For Key names

WalkWithMenu = true -- Enables Players to walk around with their menu open 

WhileMenuIsOpen = function() --- Runs at 0ms Loop
    DisablePlayerFiring(PlayerId())
end

RegisterCommand('closemenu',function()--- Command to force close the menu
    SendNUIMessage({action = 'forceclose'})
    isMenuOpen = false
end)