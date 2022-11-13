Gara = {}

function Gara:Init(index, data)
    local o = data
    setmetatable(o, {__index = Gara})
    o.index = index
    o:CreatePolyZone()
    o:MainThread()
    return o
end

function Gara:CreatePolyZone()
    self.zone = PolyZone:Create(self.poly, {
        name = self.index,
        minZ = (self.pos.z -3),
        maxZ = (self.pos.z + 10),
        debugGrid = false,
        gridOvisions = 25
        }
    )
end

function Gara:MainThread()
    CreateThread(function()
       while true do
            Wait(0)
            self.isInside = self.zone:isPointInside(pedpos)
            print(self.isInside)
        end
    end)
end