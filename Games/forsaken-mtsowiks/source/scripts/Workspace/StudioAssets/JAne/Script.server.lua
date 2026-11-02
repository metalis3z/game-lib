local hitboxes = require(game.ReplicatedStorage.Modules.Hitboxes)
local statuses = require(game.ReplicatedStorage.Modules.Statuses)
local sounds = require(game.ReplicatedStorage.Modules.Sounds)
local util = require(game.ReplicatedStorage.Modules.Util)
local hitboxdata = {
	["Size"] = Vector3.new(4, 6, 5),
	["CFrameOffset"] = CFrame.new(0, 0, -2.25),
	["Damage"] = 30,
	["Time"] = 0.25,
	["Knockback"] = 5,
	["HitMultiple"] = false,
	["Connections"] = {
		["Hit"] = function(p10)
			statuses:ApplyStatus(p10, "Stunned", {
				["Duration"] = 3
			})
			sounds:Play("rbxassetid://17837549788", {
				["Parent"] = script.Parent.Character.PrimaryPart
			})
		end
	}
}

local startingCFrame = script.Parent.Character.HumanoidRootPart.CFrame

script.Parent.Character.HumanoidRootPart.Changed:Connect(function(property)
	if property == "Anchored" then
		script.Parent.Character.HumanoidRootPart.Anchored = true
		script.Parent.Character.HumanoidRootPart.CFrame = startingCFrame
	end
end)

while wait(4) and script.Parent.Character do
	util:LoadAnimationFromID(script.Parent.Character, "rbxassetid://132797885234978"):Play()
	--sounds:Play("rbxassetid://12222225", {
	--	Parent = script.Parent.Character.Sword
	--})
	task.delay(0.575, function()
		--sounds:Play("rbxassetid://12222208", {
		--	Parent = script.Parent.Character.Sword
		--})
		hitboxes:CreateHitbox({
			Character = script.Parent.Character,
			Name = "jane doe",
			IsA = function(_, t)
				if t == "Player" then
					return true
				end
			end,
			GetNetworkPing = function()
				return 0
			end,
		}, hitboxdata)
	end)
end