VEHICLES = {}

function VEHICLES:Init()
    local o = {}
    setmetatable(o, {__index = VEHICLES})
    return o
end