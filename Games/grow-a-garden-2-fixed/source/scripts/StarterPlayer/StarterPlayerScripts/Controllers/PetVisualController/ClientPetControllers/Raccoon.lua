--credit to quartz games studio
local t = {}
local Networking = require(game.ReplicatedStorage.SharedModules.Networking)
local SeedData = require(game.ReplicatedStorage.SharedModules.SeedData)

require(script.Parent.Parent)

local Gardens = game.Workspace.Gardens

local function castGroundRay(p1, p2) --[[ castGroundRay | Line: 15 ]]
	local v1 = game.Workspace:Raycast(p1, p2, nil)

	if not v1 then
		return v1, 0
	end

	if not v1.Instance then
		return v1, 0
	end

	if v1.Instance.Transparency < 0.99 then
		return v1, 0
	end

	local v2 = RaycastParams.new()

	v2.FilterType = (nil).FilterType
	v2.IgnoreWater = (nil).IgnoreWater
	v2.RespectCanCollide = (nil).RespectCanCollide
	v2.FilterDescendantsInstances = (nil).FilterDescendantsInstances
	v2:AddToFilter(v1.Instance)

	for i = 1, 8 do
		local v3 = game.Workspace:Raycast(p1, p2, v2)

		if not v3 then
			return v3, i
		end

		if not v3.Instance then
			return v3, i
		end

		if v3.Instance.Transparency < 0.99 then
			return v3, i
		end

		v2:AddToFilter(v3.Instance)
	end

	return nil, 8
end

local function returnConstraints(p1) --[[ returnConstraints | Line: 47 ]]
	return p1.PetPivot, p1.PetAlignPos, p1.PetAlignOri
end

function t.Init(p1) --[[ Init | Line: 57 | Upvalues: Networking (copy), Gardens (copy), SeedData (copy) ]]
	function Networking.ReturnNearestFruit.ReturnNearestFruit.OnClientInvoke(p1, p2) --[[ Line: 58 | Upvalues: Gardens (ref), SeedData (ref) ]]
		local v1 = game.Players:FindFirstChild(p2)

		if not (v1 and v1.Parent) then
			return nil
		end

		local v2 = v1:GetAttribute("PlotId")

		if not v2 then
			return nil
		end

		local v3 = Gardens:FindFirstChild("Plot" .. v2)

		if not v3 then
			return nil
		end

		local v4 = (1 / 0)
		local v5 = nil

		for k, v in pairs(v3.Plants:GetChildren()) do
			local v6 = nil

			for k2, v7 in pairs(SeedData) do
				if v7.SeedName == v:GetAttribute("SeedName") then
					v6 = v7

					break
				end
			end

			if v6 then
				if v6.IsSingleHarvest == true then
					local Magnitude = (v.PrimaryPart.Position - p1).Magnitude

					if Magnitude < v4 then
						v4 = Magnitude
						v5 = v
					end

					continue
				end

				for k2, v7 in pairs(v.Fruits:GetChildren()) do
					local Magnitude = (v7.PrimaryPart.Position - p1).Magnitude

					if Magnitude < v4 then
						v4 = Magnitude
						v5 = v7
					end
				end
			end
		end

		if v5 then
			return v5.Name, v5.PrimaryPart.Position
		end
	end
	Networking.Raccoon.RaccoonWalkToPoint.OnClientEvent:Connect(function(p1, p2, p3, p4) --[[ Line: 98 ]] end)
end
function t.PlayerEnteredGarden(p1) --[[ PlayerEnteredGarden | Line: 104 ]] end

return t