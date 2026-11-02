local Tool = script.Parent

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

local ToolsCooldown = Net:RemoteEvent("Tools/Cooldown")

local LastUsed = 0

Tool.Activated:Connect(function()
	local Player = Players:GetPlayerFromCharacter(Tool.Parent)
	if not Player then return end

	local Now = os.clock()
	if Now - LastUsed < 54 then return end

	LastUsed = Now
	ToolsCooldown:FireClient(Player, Tool, 54)

	local Handle = Tool:FindFirstChild("Handle")
	if not Handle then return end

	local ViolinSong = Handle:FindFirstChild("ViolinSong")
	if ViolinSong then
		ViolinSong:Play()
	end
end)