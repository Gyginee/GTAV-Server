local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/950756280807608381/9-kUTGVD3pagodKU4ybU4jstKBpiFj_Wh6RVHal4IaDWqHnpF2z254hbPplAhLNMlVoa',
    ['testwebhook'] = 'https://discord.com/api/webhooks/957432527298113587/Uerd2ADhztRUAGf3iWhqMeqLgiT46A4iW5Fx1lfariSnBpsT8yjWpWhAxt4LKA_oikTU',
    ['playermoney'] = 'https://discord.com/api/webhooks/950756409094570004/wYmNbkBa7TtX9kz64UWU1ZQ4-agG7mS3OtWQIsotklN2o9VmM6Y0qfaUoY8rtW4wiVz3',
    ['playerinventory'] = 'https://discord.com/api/webhooks/950756503130878002/SS7Jhw7V3liivS91Gb4uvxZrSjv62u9pNW659TVttZHPH3TIlNAEED3dh4C-bdnPlH6c',
    ['robbing'] = 'https://discord.com/api/webhooks/950756606008786964/YflBkoipsaPgoAmgk3mAGXYrh7U1TOPIM7p63AePSxV_-encd9u-oFyYjGu-3zbn-7lB',
    ['cuffing'] = 'https://discord.com/api/webhooks/950756732626423829/6_6xuePGUgOWFiS3nf-ChcWoO8ECKIHg5nWZEA1IqidySRFwT-cSmfefrirePFyzll19',
    ['drop'] = 'https://discord.com/api/webhooks/950756833474252901/-5lE9vzsHCG3NcQg94flXz5piH1K6FryVOTCouDNDvnxEUuk9tRtjqgfJkACvbL0Z9-0',
    ['trunk'] = 'https://discord.com/api/webhooks/950757052794421250/yljreJjTaqrJLaizwsb5wLt7t0tQEcxUMS_CUgGIcoLfKTkfygE3AuhVnp6l8aH_sSQs',
    ['stash'] = 'https://discord.com/api/webhooks/950757154296565780/l7MbXMojLdsYPUpmFcYFJRhrYODhEoOpfhylaIFnXpgvq58hiaama1MXDshZfM-1_Jp-',
    ['glovebox'] = 'https://discord.com/api/webhooks/950757240267218954/eKwNCx9aJ4RIZdS6LLBZ15SPB6N7CZvpg0thnmb7nLOxUUGgB-OJw4urAby1XsuzcNQg',
    ['banking'] = 'https://discord.com/api/webhooks/950757312312774717/E3ZW2uWGn8Jm4zNlaGGULMnjiO6O8bcGmxGP7KBmhCiUpdc4sn9ENKkFPZMsR6hyX0P7',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/950757407355703346/oDvR6gzISLahRz6-NVGoTCZjp42h1QS1GSGEKmFK43RNKkkGxRtpAxBPt4krHOM2v4eZ',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/950757664693051483/d-h0ckoFNOyMoxtdABF1eDnuagV134oY3zt8p4aPjNDSNRWqIpKbiHaEMWYVIeGkPbEK',
    ['shops'] = 'https://discord.com/api/webhooks/950757750403629067/UIoTD1U3vhzzYGUS97IBvm-fED1cnEX0gn8lWhFMf3DEsM3scMlX2nVkayDhbJrP9m7H',
    ['dealers'] = 'https://discord.com/api/webhooks/950757916259024917/sUKfX6bnorLDaass5JXnWlW6Lb3RsO7PyDnWP5C4u1ksAujOk7hE6PpuvJG0FLYEr_KR',
    ['storerobbery'] = 'https://discord.com/api/webhooks/950758005912272926/JEExLPlVuCN4SVdjxpsUVcs-AfLZkf-yTLWQ2eqBcfVki6r7U-zvQyAzBbpo4DrW4V6p',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/944291063487692831/gbZK7nD_-I51v_14S9QtHfae9sisxlmnBHtokCYWIdx4ok-BrmttH-fEEF1Ig9a1SMXp',
    ['powerplants'] = 'https://discord.com/api/webhooks/944291137647149056/a2pd8g5i2MbgeS_bo54BYJAP497M-Rf9K7AsuhXcsqz0DZkaOJmFLfbs73BMlS2_xMmI',
    ['death'] = 'https://discord.com/api/webhooks/944291249832202360/hjKAOkXgrCOnLnCWUkZYzsG1ckjj6Ec7Ww_uyPq116bXGHcQHXBXcqI0L1FnP0xR7_v8',
    ['joinleave'] = 'https://discord.com/api/webhooks/944291355620941824/UQ_HzCggDEc2FbwHqRFOuYs5niH0ZDzbnwD9nJ1EwIgzI5ITD2Kxe6HXcf0rKvhZQwQq',
    ['ooc'] = 'https://discord.com/api/webhooks/944305545073025074/dZrcftdodnsXZuNeBhFBQ3TRt_Ni0UEC-e_3Jf_nTzMzeAG368msxcMc1Ul94zK0bzQO',
    ['report'] = 'https://discord.com/api/webhooks/944305706906046534/5uV4Ra2VMnmW4fhemNg-TZJS0xr1BFNmTy1PFMzrgcOWXi-nX4BU4_IBLp2GSebAwJOo',
    ['me'] = 'https://discord.com/api/webhooks/944305800011214918/zBvjLZkEpDTIfWLhy7HTMgloyfIUl4hW_2mlGa2rduBRlsgovcdNRY-NzTr3Z6csgEFE',
    ['pmelding'] = 'https://discord.com/api/webhooks/944305862602805319/e_dq_4LlHNkuzqyOQ3ET8Dsn5vCYNNDuAcMaU2J6sG4qLjhX14KkBUr3_ZpxGaRShkhb',
    ['112'] = 'https://discord.com/api/webhooks/944305957922545744/mbX_mGECbTPJvaVa1A4tRU3l0Ebxav8WdUV_ZjdSa4hjdHXUDKvlk9Frrsf7hZOLEmeF',
    ['bans'] = 'https://discord.com/api/webhooks/944306027682226226/m5naq3J8DTbmAS51nsj2MFkGRMK3ibekQWn8mHpsQxlmef_me-L7wrXk3W6luAqQm9FW',
    ['anticheat'] = 'https://discord.com/api/webhooks/944306124721639455/PLTMYsOLPiMY-QkPVVBaeYgKfqq3jJZM0QXS6sHH_DjA_Hb9MAToG_RBv0madeCcF6NX',
    ['weather'] = 'https://discord.com/api/webhooks/944306215314391080/CLfKTQB8KuDMt6DF6CGZdTZs-nA_0ASEm81QmeJx085CQuwtzggMjj5b9jWFGbFnnBGF',
    ['moneysafes'] = 'https://discord.com/api/webhooks/944306273858506812/6AJIPoWrRxYcFjt05kXK9cdbpeNPnL9MONb-XQ9ZnxAB8FU49wDlF2-xXZKpYVb0iw3H',
    ['bennys'] = 'https://discord.com/api/webhooks/944306360064045106/sSiiaAmikRp4UeXyYlmWn-iQUVScBR0uVygMplCiHA6QKvZF1RDeFaVslOQM-dHWzr_d',
    ['bossmenu'] = 'https://discord.com/api/webhooks/944306465152303154/dWAJYGKHyoB0HlfIhVRphdBjnFyeui2MgFcLTkoYBwnMqzP90ywW27l94m0PA-JMI3Nk',
    ['robbery'] = 'https://discord.com/api/webhooks/944306550460256386/9uPaRKiLM_wNIl6epaWP-4xmVGVzy3lGvbs8G9XZy-Lro_k9FbXK-Zue0uMg4SXWGDQh',
    ['casino'] = 'https://discord.com/api/webhooks/944306631833960548/n0phx-DEwNU-iWXIVd8VYfMEIKVis6uLVjINQENAcmiHy-ew342IVByY789y7MIYbda_',
    ['traphouse'] = 'https://discord.com/api/webhooks/944306698389188628/urFR8pGSBFXrePuMN5ZHWDEyB2pVzzJapX38xYBC9DByESvQJ27TpgM4rJmeI0osM82a',
    ['911'] = 'https://discord.com/api/webhooks/944306779771256854/CDPYjFr4ROirJXtDThF1bEfxAACvv_awSegZ4xk7h9SFhDgDCTYff7ufEqOlFQONrg15',
    ['palert'] = 'https://discord.com/api/webhooks/944306851154120774/HPgyqgJmBwfJfAoTnU9Uwgc-XyJYC5ObSqfzhF6WIbX0aP-UyycVeJUcT_7ldIemf55w',
    ['house'] = 'https://discord.com/api/webhooks/957432444167024721/wI-A0tDAUev3ruOAbp8TdW5HfEitkk4jMuUh0SYvpYEayhN5ZtEyDRWKFwQRdAEICu7j',
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
