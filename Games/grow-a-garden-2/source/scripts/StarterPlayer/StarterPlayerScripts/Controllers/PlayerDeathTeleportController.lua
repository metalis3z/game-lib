--credit to prince games studio
local t = {}
local Players = game:GetService("Players")

game:GetService("ReplicatedStorage")
game:GetService("RunService")
game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer

LocalPlayer:WaitForChild("PlayerGui")

local Gardens = workspace:WaitForChild("Gardens")

function t.Init(p1) --[[ Init | Line: 12 ]] end

local function getGardenSpawnPoint() --[[ getGardenSpawnPoint | Line: 15 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local v1 = LocalPlayer:GetAttribute("PlotId")

	if not v1 then
		return nil
	end

	local v2 = Gardens:FindFirstChild("Plot" .. tostring(v1))

	if v2 then
		return v2:FindFirstChild("SpawnPoint")
	end

	return nil
end

function t.Start(p1) --[[ Start | Line: 23 | Upvalues: LocalPlayer (copy), Gardens (copy) ]]
	local function charAdded(p1) --[[ charAdded | Line: 24 | Upvalues: LocalPlayer (ref), Gardens (ref) ]]
		local Humanoid = p1:WaitForChild("Humanoid")

		Humanoid:GetPropertyChangedSignal("Health"):Connect(function() --[[ Line: 26 | Upvalues: Humanoid (copy), LocalPlayer (ref), Gardens (ref), p1 (copy) ]]
			if not (Humanoid.Health <= 1) then
				return
			end

			local v1 = LocalPlayer:GetAttribute("PlotId")
			local v2

			if v1 then
				local v3 = Gardens:FindFirstChild("Plot" .. tostring(v1))

				v2 = if v3 then v3:FindFirstChild("SpawnPoint") else nil
			else
				v2 = nil
			end

			if not v2 then
				return
			end

			p1:PivotTo(v2.CFrame + Vector3.new(0, 3, 0))
			Humanoid.Health = 100
		end)
	end
end

return t