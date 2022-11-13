local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('xt-doben:server:UpdateToolQuality', function(data, RepeatAmount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ToolSlot = Player.PlayerData.items[data.slot]
    local DecreaseAmount = Config.DurabilityMultiplier[data.name]
    if ToolSlot ~= nil then
            if ToolSlot.info.quality ~= nil then
                for i = 1, RepeatAmount, 1 do
                    if ToolSlot.info.quality - DecreaseAmount > 0 then
                        ToolSlot.info.quality = ToolSlot.info.quality - DecreaseAmount
                    else
                        ToolSlot.info.quality = 0
                        break
                    end
                end
            else
                ToolSlot.info.quality = 100
                for i = 1, RepeatAmount, 1 do
                    if ToolSlot.info.quality - DecreaseAmount > 0 then
                        ToolSlot.info.quality = ToolSlot.info.quality - DecreaseAmount
                    else
                        ToolSlot.info.quality = 0
                        break
                    end
                end
            end
        end
    Player.Functions.SetInventory(Player.PlayerData.items)
end)

RegisterServerEvent("xt-doben:server:SetToolQuality", function(data, hp)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ToolSlot = Player.PlayerData.items[data.slot]
    ToolSlot.info.quality = hp
    Player.Functions.SetInventory(Player.PlayerData.items)
end)


