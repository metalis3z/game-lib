local Victrola = {}

local Debris = game:GetService("Debris")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Packages = ReplicatedStorage:WaitForChild("Packages")

local Net = require(Packages.Net)
local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local Debounce = {}

function Victrola.OnExecution(Player: Player, Character: Model, Tool: Tool)
	if Debounce[Player.UserId] and tick() - Debounce[Player.UserId] < 10 then
		return
	end

	Debounce[Player.UserId] = tick()
	ToolsCooldown:FireClient(Player, Tool, 10)

	local Handle = Tool:FindFirstChild("Handle")
	if not Handle then return end

	local Sound = Handle:FindFirstChild("Victrola")

	if Sound then
		Sound:Play()
	end
end

return Victrola