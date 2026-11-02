-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

require(script.Parent.Parent.Types)

local Gears = require(ReplicatedStorage.Directory.Gears)

require(ReplicatedStorage.Library.Types.Tools)

local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local Audio = require(ReplicatedStorage.Library.Audio)
local Sprinklers = ReplicatedStorage.Assets.Sprinklers
local Sprinklers2 = Workspace:FindFirstChild("Sprinklers")

if not Sprinklers2 then
	Sprinklers2 = Instance.new("Folder")
	assert(Sprinklers2, "luau")
	Sprinklers2.Name = "Sprinklers"
	Sprinklers2.Parent = Workspace
end

for k, v in pairs(Gears.Directory) do
	if v.IsSprinkler then
		local v1 = Sprinklers:FindFirstChild((("%* VFX"):format(v._id)))

		if Constants.IS_STUDIO then
			assert(v1, (("Gear vfx not found for sprinkler: \"%*\""):format(v._id)))

			local v3 = ReplicatedStorage.ObjectModels:FindFirstChild(v._id)

			assert(v3, (("Gear model not found for sprinkler: \"%*\""):format(v._id)))
		end

		if v1 then
			local ControllerData = v.ControllerData

			v1.Size = Vector3.new(ControllerData.Radius, v1.Size.Y, ControllerData.Radius)
		end
	end
end

local t = {}
local v5 = table.create(15)
local v6 = table.create(15)
local v7 = nil

local function elasticOut(p1) --[[ elasticOut | Line: 64 | Upvalues: Easing (copy) ]]
	return Easing(p1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
end

local function jellyAngles(p1, p2, p3, p4, p5, p6) --[[ jellyAngles | Line: 68 ]]
	if p3 < p1.PrevPhase then
		p1.WobbleStart = p2
	end

	p1.PrevPhase = p3

	local v1 = p2 - p1.WobbleStart
	local v3 = math.abs((p4 - p5) / math.max(p6, 0.004166666666666667)) / 2.8
	local v4 = math.clamp(v3, 0, 1) * 0.10471975511965978 * math.exp(v1 * -2.2) * math.sin(37.69911184307752 * v1)

	return v4, 0, -v4
end

local function step(p1) --[[ step | Line: 89 | Upvalues: v5 (copy), v6 (copy), t (ref), Easing (copy), Workspace (copy), v7 (ref) ]]
	local v1 = os.clock()

	table.clear(v5)
	table.clear(v6)

	for k, v in pairs(t) do
		if v.Part.Parent then
			v5[#v5 + 1] = v.Part

			local v2 = (v1 - v.Start) / 1 % 1
			local v3 = if v2 < 0.5 then math.sin(v2 * 2 * math.pi / 2) * 1.4 else (1 - Easing((v2 - 0.5) * 2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)) * 1.4
			local LastOffset = v.LastOffset

			if v2 < v.PrevPhase then
				v.WobbleStart = v1
			end

			v.PrevPhase = v2

			local v4 = v1 - v.WobbleStart
			local v62 = math.abs((v3 - LastOffset) / math.max(p1, 0.004166666666666667)) / 2.8
			local v72 = math.clamp(v62, 0, 1) * 0.10471975511965978 * math.exp(v4 * -2.2) * math.sin(37.69911184307752 * v4)

			v.LastOffset = v3
			v6[#v6 + 1] = v.BaseCFrame * CFrame.new(0, -v3, 0) * CFrame.Angles(v72, 0, -v72)

			continue
		end

		t[k] = nil
	end

	if #v5 > 0 then
		Workspace:BulkMoveTo(v5, v6, Enum.BulkMoveMode.FireCFrameChanged)
	end

	if not v7 or next(t) ~= nil then
		return
	end

	v7:Disconnect()
	v7 = nil
end

local function startStepping() --[[ startStepping | Line: 129 | Upvalues: v7 (ref), RunService (copy), step (copy) ]]
	if v7 then
		return
	end

	v7 = RunService.RenderStepped:Connect(step)
end

local function addBounce(p1, p2, p3) --[[ addBounce | Line: 135 | Upvalues: t (ref), v7 (ref), RunService (copy), step (copy) ]]
	t[p1] = {
		PrevPhase = 0,
		LastOffset = 0,
		Part = p2,
		BaseCFrame = p3,
		Start = os.clock(),
		WobbleStart = os.clock()
	}

	if v7 then
		return
	end

	v7 = RunService.RenderStepped:Connect(step)
end

local function removeBounce(p1) --[[ removeBounce | Line: 141 | Upvalues: t (ref), v7 (ref) ]]
	t[p1] = nil

	if not v7 or next(t) ~= nil then
		return
	end

	v7:Disconnect()
	v7 = nil
end

return {
	Create = function(p1) --[[ Create | Line: 150 | Upvalues: ReplicatedStorage (copy), Gears (copy), Sprinklers2 (ref), Sprinklers (copy), Audio (copy), addBounce (copy) ]]
		local ID = p1.Parameters.ID
		local SprinklerType = p1.Parameters.SprinklerType
		local v1 = p1.Parameters.SprinklerCFrame * CFrame.Angles(0, math.pi, math.pi)
		local v2 = ReplicatedStorage.ObjectModels:FindFirstChild(SprinklerType)

		if not v2 then
			return
		end

		local v3 = Gears.Directory[SprinklerType]
		local v4 = v3 and v3.ControllerData

		if not v4 then
			return
		end

		local v5 = v2:Clone()

		v5:SetAttribute("EndTime", p1.Parameters.EndTime)
		v5.PrimaryPart.CFrame = v1 * CFrame.new(0, 1, 0)
		v5.Parent = Sprinklers2

		local v6 = p1.Default:CreateEffect({
			Emit = true,
			DebrisTime = 2,
			Object = Sprinklers.PlaceEffect,
			Position = v1
		})

		if v4.PlaceSFX then
			Audio.PlayFromSoundFile(v4.PlaceSFX, v1)
		else
			p1.Default:PlaySound(Sprinklers.PlaceSFX, v6)
		end

		p1.Libraries.BoatTween:Create(v5.PrimaryPart, {
			Time = 0.8,
			EasingStyle = "Smoother",
			EasingDirection = "In",
			StepType = "Heartbeat",
			Goal = {
				CFrame = v1 * v4.Offset
			}
		}):Play()
		p1.Cache[ID] = {
			Sprinkler = v5,
			SprinklerCFrame = v1,
			ControllerData = v4
		}

		if v4.BounceAnimate then
			task.delay(1, function() --[[ Line: 203 | Upvalues: v5 (copy), addBounce (ref), ID (copy), v1 (copy), v4 (copy) ]]
				if v5 and (v5.PrimaryPart and v5.Parent) then
					addBounce(ID, v5.PrimaryPart, v1 * v4.Offset)
				end
			end)
		end

		task.spawn(function() --[[ Line: 210 | Upvalues: p1 (copy), Sprinklers (ref), SprinklerType (copy), v5 (copy), v1 (copy), v4 (copy), ID (copy), Audio (ref) ]]
			local v12 = p1.Default:CreateEffect({
				Object = Sprinklers[string.format("%s VFX", SprinklerType)],
				Parent = v5,
				Position = CFrame.new((v1 * v4.Offset).Position)
			})

			p1.Cache[ID].SprinklerEffect = v12

			local v2

			if v4.LoopSFX then
				local v3 = Audio.PlayFromSoundFile(v4.LoopSFX, v1)

				v3.Parent = v12
				v2 = v3
			else
				v2 = p1.Default:PlaySound(Sprinklers.SprinklerLoop, v12)
			end

			p1.Cache[ID].LoopSound = v2

			while v5 and v5.Parent do
				local v52 = v4.WaitTime * 100

				task.wait(math.random(math.floor(v52 / 3), v52) / 100)
			end
		end)
	end,
	Destroy = function(p1) --[[ Destroy | Line: 231 | Upvalues: t (ref), v7 (ref), Audio (copy), Sprinklers (copy) ]]
		local ID = p1.Parameters.ID
		local v1 = p1.Cache[ID]

		if typeof(v1) ~= "table" then
			return
		end

		local Sprinkler = v1.Sprinkler

		if not Sprinkler then
			return
		end

		local SprinklerEffect = v1.SprinklerEffect

		if SprinklerEffect then
			p1.Default:UpdateStatus(SprinklerEffect, false, {})
		end

		local LoopSound = v1.LoopSound

		if LoopSound then
			LoopSound:Destroy()
		end

		t[ID] = nil

		if v7 and next(t) == nil then
			v7:Disconnect()
			v7 = nil
		end

		local ControllerData = v1.ControllerData

		if ControllerData and ControllerData.DespawnSFX then
			Audio.PlayFromSoundFile(ControllerData.DespawnSFX, Sprinkler)
		else
			p1.Default:PlaySound(Sprinklers.DespawnSFX, Sprinkler)
		end

		p1.Libraries.BoatTween:Create(Sprinkler.PrimaryPart, {
			Time = 0.6,
			EasingStyle = "ExitExpressive",
			EasingDirection = "In",
			StepType = "Heartbeat",
			Goal = {
				CFrame = (v1.SprinklerCFrame or p1.Parameters.SprinklerCFrame) * CFrame.new(0, 3, 0)
			}
		}):Play()
		task.delay(0.6, function() --[[ Line: 268 | Upvalues: Sprinkler (copy) ]]
			if not Sprinkler then
				return
			end

			Sprinkler:Destroy()
		end)
		p1.Cache[ID] = nil
	end,
	Cancel = function(p1) --[[ Cancel | Line: 275 | Upvalues: t (ref), v7 (ref) ]]
		for k, v in pairs(p1.Cache) do
			local v1 = if v then v.LoopSound else v

			if v1 then
				v1:Destroy()
			end
		end

		p1.Container:Clean()
		p1.Cache = {}
		t = {}

		if not v7 then
			return
		end

		v7:Disconnect()
		v7 = nil
	end
}