local hitboxes = require(game.ReplicatedStorage.Modules.Hitboxes)
local hitboxdata = {
	["Size"] = Vector3.new(4, 4.5, 3.5),
	["CFrameOffset"] = CFrame.new(0, -1.25, -2.5, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	["Damage"] = 25,
	["Time"] = 0.25,
	["Knockback"] = 0,
	["HitMultiple"] = true,
}
task.wait(5)
while wait(1) and script.Parent.Character do
	hitboxes:CreateHitbox({
		Character = script.Parent.Character,
		Name = "ao oni",
		IsA = function(_, t)
			if t == "Player" then
				return true
			end
		end,
		GetNetworkPing = function()
			return 0
		end,
	}, hitboxdata)
end