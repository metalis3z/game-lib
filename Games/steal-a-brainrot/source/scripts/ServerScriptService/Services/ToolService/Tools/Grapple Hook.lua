local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")
local Net = require(Packages.Net)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local GrappleHook = {}

local CoolDown = 3
local ServerDebounce = {}

function GrappleHook.OnExecution(Player: Player, Character: Model, Tool: Tool)
	local Last = ServerDebounce[Player.UserId]
	if Last and os.clock() - Last < CoolDown then
		return
	end
	ServerDebounce[Player.UserId] = os.clock()
	ToolsCooldown:FireClient(Player, Tool, CoolDown)
end

return GrappleHook