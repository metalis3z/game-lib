--credit to quartz games studio
local t = {
	StartOrder = 5
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Networking = require(ReplicatedStorage.SharedModules.Networking)
local EggEffect = require(script.EggEffect)

function t.Init(p1) --[[ Init | Line: 10 ]] end
function t.Start(p1) --[[ Start | Line: 13 | Upvalues: Networking (copy), EggEffect (copy), Players (copy) ]]
	Networking.Egg.ReplicateOpenEgg.OnClientEvent:Connect(function(p1, p2, p3, p4, p5, p6, p7) --[[ Line: 14 | Upvalues: EggEffect (ref), Players (ref), Networking (ref) ]]
		if not (p1 and p1.Character) then
			return
		end

		local HumanoidRootPart = p1.Character:FindFirstChild("HumanoidRootPart")

		if not (HumanoidRootPart and HumanoidRootPart:IsA("BasePart")) then
			return
		end

		local Position = HumanoidRootPart.Position
		local v1 = CFrame.new(p5, p5 + CFrame.new(p5, Position).LookVector)
		local v2 = if p6 == "" then nil else p6
		local v3 = if p7 == "" then nil else p7

		task.spawn(function() --[[ Line: 29 | Upvalues: EggEffect (ref), p2 (copy), p3 (copy), p4 (copy), Position (copy), v1 (copy), p1 (copy), v2 (copy), v3 (copy), Players (ref), Networking (ref) ]]
			EggEffect.Open(p2, p3, p4, Position, v1, p1, v2, v3)

			if p1 ~= Players.LocalPlayer then
				return
			end

			Networking.Egg.ConfirmEgg:Fire(p2, p3, p4)
		end)
	end)
end

return t