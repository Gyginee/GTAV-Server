QBCore = exports['qb-core']:GetCoreObject()
LoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  SetTimeout(1250, function()
    LoggedIn = true
  end)
  exports['qb-target']:AddTargetModel(Config.Thungrac,  {
    options = {
        {
            event = "xt-phelieu:client:search:trash",
            icon = "fa-solid fa-dumpster",
            label = "Lục thùng rác",
        },
        },
    distance = 1.0
})
end)

-- Code

function DrawText3D(x, y, z, text)
  SetTextScale(0.35, 0.35)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(255, 255, 255, 215)
  SetTextEntry("STRING")
  SetTextCentre(true)
  AddTextComponentString(text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end