--credit to leon games studio
local t = {
	StartOrder = 4
}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GardenSyncController = require(script.Parent.GardenSyncController)
local PlacementGrid = require(ReplicatedStorage.ClientModules.PlacementGrid)
local FakeSeat = require(script.FakeSeat)
local LocalPlayer = Players.LocalPlayer
local Gardens = workspace:WaitForChild("Gardens")
local Props = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Props")
local t2 = {}
local t3 = { "Teleport Pad", "Big Teleport Pad", "Huge Teleport Pad" }

function t.Init(p1) --[[ Init | Line: 18 ]] end
function t.Start(p1) --[[ Start | Line: 21 | Upvalues: GardenSyncController (copy) ]]
	GardenSyncController:OnPropAdded(function(p12, p2, p3) --[[ Line: 22 | Upvalues: p1 (copy) ]]
		p1:SpawnPropFromData(p12, p2, p3)
	end)
	GardenSyncController:OnPropRemoved(function(p12, p2) --[[ Line: 26 | Upvalues: p1 (copy) ]]
		p1:RemovePropById(p12, p2)
	end)
	GardenSyncController:OnPropExtraDataUpdated(function(p12, p2, p3) --[[ Line: 30 | Upvalues: p1 (copy) ]]
		p1:UpdatePropExtraData(p12, p2, p3)
	end)
end
function t.GetPlayerPlot(p1, p2) --[[ GetPlayerPlot | Line: 35 | Upvalues: Players (copy), Gardens (copy) ]]
	local v1 = Players:GetPlayerByUserId(p2)

	if not v1 then
		return nil
	end

	local v2 = v1:GetAttribute("PlotId")

	if v2 then
		return Gardens:FindFirstChild("Plot" .. v2)
	end

	return nil
end
function t.GetSpawnPoint(p1, p2) --[[ GetSpawnPoint | Line: 45 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if v1 then
		return v1:FindFirstChild("SpawnPoint")
	end

	return nil
end
function t.GetPropsFolder(p1, p2) --[[ GetPropsFolder | Line: 52 ]]
	local v1 = p1:GetPlayerPlot(p2)

	if not v1 then
		return nil
	end

	local Props = v1:FindFirstChild("Props")

	if not Props then
		local Props2 = Instance.new("Folder")

		Props2.Name = "Props"
		Props2.Parent = v1
		Props = Props2
	end

	return Props
end
function t.SpawnPropFromData(p1, p2, p3, p4) --[[ SpawnPropFromData | Line: 66 | Upvalues: t2 (copy), Props (copy), t3 (copy), PlacementGrid (copy), FakeSeat (copy) ]]
	local v1 = ("%*_%*"):format(p2, p3)

	if t2[v1] then
		p1:RemovePropById(p2, p3)
	end

	local v2 = p1:GetSpawnPoint(p2)

	if not v2 then
		return
	end

	local v3 = p1:GetPropsFolder(p2)

	if not v3 then
		return
	end

	local PropName = p4.PropName

	if not PropName then
		return
	end

	local v4 = Props:FindFirstChild(PropName)

	if not v4 then
		return
	end

	local v5 = v4:Clone()

	v5.Name = p3
	v5:SetAttribute("PropId", p3)
	v5:SetAttribute("UserId", p2)
	v5:SetAttribute("PropName", PropName)
	v5:SetAttribute("ExtraData", p4.ExtraData or "")

	local v6

	if v5:IsA("Model") then
		v6 = v1

		for v7, v8 in v5:GetDescendants() do
			if v8:IsA("BasePart") then
				v8.Anchored = true

				if v8.Transparency >= 0.9 and not table.find(t3, PropName) then
					v8.CanQuery = false
				end
			end
		end

		if v5.PrimaryPart then
			v5.PrimaryPart.CanCollide = false
		end
	else
		if v5:IsA("BasePart") then
			v5.Anchored = true

			if v5.Transparency >= 0.9 and not table.find(t3, PropName) then
				v5.CanQuery = false
			end
		end

		v6 = v1
	end

	v5.Parent = v3

	local v9 = Vector3.new(p4.Positions.PosX, p4.Positions.PosY, p4.Positions.PosZ)
	local v10 = p4.Positions.Rotation or 0
	local v11 = v2.CFrame:PointToWorldSpace(v9)
	local v12

	if p4.V == 2 then
		v12 = PlacementGrid.PositionModel(v5, v11, PlacementGrid.GetGardenRotationY(v2), v10)
	else
		local _, v16, _2 = v2.CFrame:ToWorldSpace(CFrame.new(Vector3.new(0, 0, 0)) * CFrame.Angles(0, math.rad(v10), 0)):ToEulerAnglesYXZ()

		v12 = CFrame.new(v11) * CFrame.Angles(0, v16, 0)
	end

	if v5:IsA("Model") then
		v5:PivotTo(v12)
	elseif v5:IsA("BasePart") then
		v5.CFrame = v12
	end

	t2[v6] = v5

	local v17 = script:FindFirstChild(PropName, true)

	if v17 then
		local _, _2 = pcall(require(v17), v5)
	end

	local _, _2 = pcall(FakeSeat, v5)
end
function t.UpdatePropExtraData(p1, p2, p3, p4) --[[ UpdatePropExtraData | Line: 159 ]]
	local v1 = p1:GetSpawnedProp(p2, p3)

	if not v1 then
		return
	end

	v1:SetAttribute("ExtraData", p4 or "1")
end
function t.RemovePropById(p1, p2, p3) --[[ RemovePropById | Line: 166 | Upvalues: t2 (copy) ]]
	local v1 = ("%*_%*"):format(p2, p3)
	local v2 = t2[v1]

	if not v2 then
		return
	end

	v2:Destroy()
	t2[v1] = nil
end
function t.GetSpawnedProp(p1, p2, p3) --[[ GetSpawnedProp | Line: 176 | Upvalues: t2 (copy) ]]
	return t2[("%*_%*"):format(p2, p3)]
end
function t.GetAllSpawnedProps(p1) --[[ GetAllSpawnedProps | Line: 181 | Upvalues: t2 (copy) ]]
	return t2
end

return t