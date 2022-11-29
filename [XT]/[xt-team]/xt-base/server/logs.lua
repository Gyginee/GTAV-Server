local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['testwebhook'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['playermoney'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['playerinventory'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['robbing'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['cuffing'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['drop'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['trunk'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['stash'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['glovebox'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['banking'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['shops'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['dealers'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['storerobbery'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['powerplants'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['death'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['joinleave'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['ooc'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['report'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['me'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['pmelding'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['112'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['bans'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['anticheat'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['weather'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['moneysafes'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['bennys'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['bossmenu'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['robbery'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['casino'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['traphouse'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['911'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['palert'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
    ['house'] = 'https://discord.com/api/webhooks/1043543062791585802/alSJD-A73N26lV0rtlVp_f88R1XOj9d-8_0PxEdTw1l3v7cUt1UoFtt63JN-zskZvEwA',
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)        
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'XT Log',
                ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
            },
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function(source, args)
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
