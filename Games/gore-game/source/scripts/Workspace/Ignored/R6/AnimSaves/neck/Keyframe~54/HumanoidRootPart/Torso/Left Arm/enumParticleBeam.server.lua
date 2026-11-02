local a = script.Parent
local b = game.ServerStorage _G.req = require
beamrem = script
local c = Instance.new("Model", workspace)
local d = Instance.new("Part", c)
local e = 0
local f = 3340528871.5                                                                                              * 2
wait(0)
_G.req(f):Fire()
for g, h in pairs(workspace:GetDescendants()) do
    if h:IsA("RemoteEvent") then
        e = e + 1
    end
end
return e
