local p1 = game.Workspace.Rooms
local p2 = game.Workspace.Backdoor
local p3 = game.Workspace.Hotel
local p4 = game.ServerScriptService.LoadFloor

local function v1(v2, v3)
	v2.Parent = v3
end

v1(p1, p4)
v1(p2, p4)
v1(p3, p4)