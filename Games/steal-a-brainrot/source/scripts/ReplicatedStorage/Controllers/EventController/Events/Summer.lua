local v_u_1 = game:GetService("ReplicatedStorage")
game:GetService("ContentProvider")
local v_u_2 = game:GetService("RunService")
local v_u_3 = game:GetService("Lighting")
local v4 = game:GetService("Players")
local v_u_5 = game:GetService("Debris")
require(v_u_1.Shared.EventTypes)
local v6 = {}
local v_u_7 = require(v_u_1.Controllers.EffectController)
local v_u_8 = require(v_u_1.Controllers.AnimalController)
local v_u_9 = require(v_u_1.Controllers.EventController)
local v_u_10 = require(v_u_1.Controllers.SoundController)
local v_u_11 = require(v_u_1.Controllers.CycleController)
require(v_u_1.Shared.SharedEventUtils)
require(v_u_1.Packages.CreateTween)
local v_u_12 = require(v_u_1.Packages.Timer)
local v_u_13 = require(v_u_1.Packages.Trove)
local v14 = require(v_u_1.Packages.Net)
local v_u_15 = require(v_u_1.Shared.VFX)
local v_u_16 = v4.LocalPlayer
local v_u_17 = script.Name -- "Mario"
local v_u_18 = v14:RemoteEvent(("EventService/%*/SpawnPipe"):format(v_u_17))
local v_u_19 = v14:RemoteEvent(("EventService/%*/Burst"):format(v_u_17))
local v_u_20 = v_u_13.new()
local v_u_21 = false
local v_u_22 = CFrame.identity
local v_u_23 = CFrame.new(0, -2.441, 0.21)
local v_u_24 = {}

-- Variables pour sauvegarder le tapis
local carpetModel = workspace:FindFirstChild("Carpet")
local carpetOriginalCFrame = nil
local carpetOriginalParent = nil

local function v_u_50(p_u_25, _, p26)
	local v_u_27 = v_u_13.new()
	v_u_10:PlaySound(v_u_1.Sounds.Events.Summer.Pop, p_u_25.Position, false)

	-- Clone le modèle Pipe au lieu de Skibidi
	local v_u_28 = table.remove(v_u_24, 1) or script.Pipe:Clone()
	local v29 = v_u_28.Parent ~= nil
	local v_u_30 = 0
	local v_u_31 = -5.1
	local v_u_32 = time()
	local v33 = v_u_28.PrimaryPart
	local v_u_34 = v33.__skibidi_transform -- le Weld interne, garde le même nom
	v33.Anchored = false
	if not v29 then
		v_u_34.C1 = v_u_23
		v_u_34.Part0 = workspace.Terrain
		v_u_34.Part1 = v33
		v_u_28.Parent = workspace
	end
	v_u_27:Add(v_u_2.PostSimulation:Connect(function()
		debug.profilebegin("Summer:update")
		local v35 = time() - v_u_32
		if v35 <= 0.75 then
			local v36 = v35 / 0.75 * math.pi * 0.5
			local v37 = math.sin(v36)
			v_u_30 = math.lerp(0, 12.566370614359172, v37)
			v_u_31 = math.lerp(-7.921, 2, v37)
		elseif v35 >= 1.25 then
			local v38 = (v35 - 1.25) / 0.75
			local v39 = math.clamp(v38, 0, 1) * math.pi * 0.5
			local v40 = 1 - math.cos(v39)
			v_u_30 = math.lerp(12.566370614359172, 25.132741228718345, v40)
			v_u_31 = math.lerp(2.5, -7.5, v40)

		end
		local v41 = p_u_25 * CFrame.new(0, v_u_31, 0)
		local v42 = v_u_34
		local v43 = CFrame.lookAt
		local v44 = v41.Position
		local v45 = v_u_22.X
		local v46 = v41.Y
		local v47 = v_u_22.Z
		v_u_34.Transform = CFrame.new(v41.Position) * CFrame.Angles(0, math.rad(180), math.rad(90))
		debug.profileend()
	end))

	v_u_27:Add(task.delay(p26 and 0.5 or 2, function()
		if v_u_21 then
			v_u_34.Transform = CFrame.identity
			table.insert(v_u_24, v_u_28)
		else
			v_u_28:Destroy()
		end
		v_u_27:Destroy()
	end))
end

function v6.OnStart(_)
	local v_u_51 = v_u_9:GetActiveEventData(v_u_17)
	assert(v_u_51)
	local v_u_52 = v_u_1:GetAttribute("SummerEventSeed")
	v_u_1:SetAttribute("SummerEvent", true)
	v_u_20:Add(function()
		v_u_1:SetAttribute("SummerEvent", nil)
	end)

	-- Sauvegarde du tapis et déplacement sous la carte
	if carpetModel then
		carpetOriginalCFrame = carpetModel:GetPivot()
		carpetOriginalParent = carpetModel.Parent

		-- Déplace le tapis très bas sous la carte (Y = -1000)
		local undergroundCFrame = CFrame.new(carpetOriginalCFrame.X, -1000, carpetOriginalCFrame.Z)
		carpetModel:PivotTo(undergroundCFrame)
	end

	v_u_21 = true
	v_u_20:Add(function()
		v_u_21 = false
		task.defer(function()
			for _, v53 in v_u_24 do
				v53:Destroy()
			end
			table.clear(v_u_24)
		end)
	end)

	v_u_7:Activate("Blink")
	v_u_10:UpdateOST()
	v_u_11:Update()
	v_u_20:Add(function()
		v_u_7:Activate("Blink")
		v_u_10:UpdateOST()
		v_u_11:Update()
	end)

	local v_u_54 = v_u_3:FindFirstChild("Atmosphere")
	if v_u_54 then
		v_u_54.Parent = script
		v_u_20:Add(function()
			v_u_54.Parent = v_u_3
		end)
	end
	v_u_20:Clone(script.Atmosphere).Parent = v_u_3
	v_u_20:Clone(script.MapVFX).Parent = workspace
	local v_u_55 = v_u_52 + (workspace:GetServerTimeNow() - v_u_51.startedAt) // 5
	local v_u_56 = Random.new(v_u_55)
	local v_u_57 = workspace.Events.Summer.Ground:GetChildren()
	local v_u_58 = workspace.Events.Summer.WallTop:GetChildren()
	local function v_u_64(p59)
		local v60
		if p59 == "WallTop" then
			v60 = v_u_58
		else
			v60 = v_u_57
		end
		local v61 = v60[v_u_56:NextInteger(1, #v60)]
		local v62 = v61.CFrame
		local v63 = v61.Size
		return v62 * CFrame.new(v_u_56:NextNumber(-v63.X * 0.5, v63.X * 0.5), v63.Y * 0.5, v_u_56:NextNumber(-v63.Z * 0.5, v63.Z * 0.5))
	end
	v_u_20:Add(v_u_12.Simple(0.1, function()
		local v65 = v_u_52 + (workspace:GetServerTimeNow() - v_u_51.startedAt) // 5
		if v_u_55 ~= v65 then
			v_u_55 = v65
			v_u_56 = Random.new(v65)
		end
		v_u_50(v_u_64("Ground"), "Ground")
		v_u_50(v_u_64("WallTop"), "WallTop")
	end))
	local v_u_66 = v_u_16.Character
	v_u_20:Add(v_u_16.CharacterAdded:Connect(function(p67)
		v_u_66 = p67
	end))
	v_u_20:Add(v_u_2.PostSimulation:Connect(function()
		v_u_22 = v_u_66:GetPivot()
	end))
end

function v6.OnStop(_)
	-- Remet le tapis à sa position d'origine à la fin de l'événement
	if carpetModel and carpetOriginalCFrame then
		carpetModel:PivotTo(carpetOriginalCFrame)
		if carpetOriginalParent then
			carpetModel.Parent = carpetOriginalParent
		end
	end

	v_u_20:Destroy()
end

function v6.OnLoad(_)
	v_u_18.OnClientEvent:Connect(function(p68)
		if typeof(p68) == "CFrame" then
			v_u_50(p68, "Ground")
			return
		else
			local v69 = v_u_8:GetAnimals()[p68]
			if v69 then
				local v70 = v69.AnimalModel
				if v70 then
					v70 = v70.PrimaryPart
				end
				local v71 = v69.Instance
				local v72
				if v71 then
					v72 = v71.PrimaryPart
				else
					v72 = v71
				end
				if v72 and v70 then
					v_u_50(v71:GetPivot(), "Ground", true)
				end
			else
				return
			end
		end
	end)
	v_u_19.OnClientEvent:Connect(function(p73)
		local v74 = v_u_8:GetAnimals()[p73]
		if v74 then
			local v75 = v74.AnimalModel
			local v76
			if v75 then
				v76 = v75.PrimaryPart
			else
				v76 = v75
			end
			local v77 = v74.Instance
			local v78
			if v77 then
				v78 = v77.PrimaryPart
			else
				v78 = v77
			end
			if v78 and v76 then
				local v79 = v_u_20:Clone(script.Burst)
				v79:PivotTo(v78.CFrame * CFrame.new(0, (v79.Size.Y + v75:GetExtentsSize().Y) / 2, 0))
				v79.Parent = v77
				local v80 = Instance.new("WeldConstraint")
				v80.Part0 = v79
				v80.Part1 = v74.AnimalModel.PrimaryPart
				v80.Parent = v79
				v_u_15.emit(v79)
				v_u_5:AddItem(v79, 5)
				v_u_10:PlaySound(v_u_1.Sounds.Events.Summer.BrainrotHit, v78.CFrame.Position, false)
			end
		else
			return
		end
	end)
end

return v6