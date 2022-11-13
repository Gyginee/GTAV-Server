
QBCore = exports['qb-core']:GetCoreObject()
MAIN = {}
ped = PlayerPedId()
pedpos = GetEntityCoords(ped)

CreateThread(function()
    Wait(500)
    while true do
        pedpos = GetEntityCoords(ped)
    end
end)

function MAIN:Init()
   local o = {}
   setmetatable(o, {__index = MAIN})
   o.PlayerData = QBCore.Functions.GetPlayerData()
   o.inGarageRange = false
   o.Garas = {}
   o:InitGara()
   return o
end

function MAIN:InitGara()
    for k , v in pairs(Config.Garage) do
        self.Garas[k] = Gara:Init(k,v)
    end
end

function MAIN:EventHandler()
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        self.PlayerData = QBCore.Functions.GetPlayerData()
        self.PlayerData.job = QBCore.Functions.GetPlayerData().job
        self.PlayerData.gang = QBCore.Functions.GetPlayerData().gang
    end)
    RegisterNetEvent('QBCore:Client:OnGangUpdate', function(gang)
        self.PlayerData.gang = gang
    end)
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        self.PlayerData.job = job
    end)
end


CreateThread(function()
	Main = MAIN:Init()
	Main:EventHandler()
end)

