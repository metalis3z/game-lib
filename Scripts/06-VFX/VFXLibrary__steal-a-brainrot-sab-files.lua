-- Reference copy for study. Game: steal-a-brainrot-sab-files
-- Original: ReplicatedStorage/Shared/VFX.lua  (ModuleScript, 145 lines)
-- What it does: Copy an effect to a CFrame (Attachment -> WorldCFrame, Model -> PivotTo), weld or follow a target, rescale with a temp Model, enable/disable, emit with EmitCount/EmitDelay/EmitDuration attributes, and looping emits via a tag.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local Observers = require(ReplicatedStorage.Packages.Observers)
local Timer = require(ReplicatedStorage.Packages.Timer)
local EventUtils = require(ReplicatedStorage.Shared.SharedEventUtils)

local VFXLib = {
	Library = script.Library,

	copy = function(source, position, parent)
		if parent == nil then
			parent = if source:IsA("Attachment") then workspace.Terrain else workspace.CurrentCamera
		end

		local clone = source:Clone()
		local cframe = if typeof(position) == "CFrame" then position else CFrame.new(position)

		if clone:IsA("Attachment") then
			clone.WorldCFrame = cframe
		elseif clone:IsA("PVInstance") then
			clone:PivotTo(cframe)
		else
			clone:Destroy()
			error("Can't move Container")
		end

		clone.Parent = parent
		return clone
	end,

	weld = function(part0, part1)
		local weld = Instance.new("Weld")
		weld.Part0 = part0
		weld.Part1 = part1
		weld.Parent = part0
		return weld
	end,

	weldPosition = function(vfxPart, targetInstance)
		vfxPart.Anchored = true

		local connection = RunService.PostSimulation:Connect(function()
			debug.profilebegin("VFX:weldPosition:pushCFrame")
			EventUtils.pushPartCFrame(vfxPart, CFrame.new(targetInstance:GetPivot().Position))
			debug.profileend()
		end)

		local destroyConn = vfxPart.Destroying:Once(function()
			connection:Disconnect()
		end)

		return function()
			connection:Disconnect()
			destroyConn:Disconnect()
		end
	end,

	rescale = function(object, scale)
		local originalParent = object.Parent
		local tempModel = Instance.new("Model")
		object.Parent = tempModel
		tempModel:ScaleTo(scale)
		object.Parent = originalParent
	end,

	enable = function(container, includeLights)
		for _, desc in container:GetDescendants() do
			if desc:IsA("ParticleEmitter") or desc:IsA("Beam") then
				desc.Enabled = true
			elseif includeLights and desc:IsA("Light") then
				desc.Enabled = true
			end
		end
	end,

	disable = function(container, includeLights)
		for _, desc in container:GetDescendants() do
			if desc:IsA("ParticleEmitter") or desc:IsA("Beam") then
				desc.Enabled = false
			elseif includeLights and desc:IsA("Light") then
				desc.Enabled = false
			end
		end
	end
}

local function triggerEmit(emitter)
	local count = tonumber(emitter:GetAttribute("EmitCount")) or tonumber(emitter.Name) or 0
	local duration = tonumber(emitter:GetAttribute("EmitDuration")) or 0

	emitter:Emit(count)

	if duration > 0 then
		emitter.Enabled = true
		task.delay(duration, function()
			emitter.Enabled = false
		end)
	end
end

VFXLib.emit = function(container)
	for _, desc in container:GetDescendants() do
		if desc:IsA("ParticleEmitter") then
			local delayTime = desc:GetAttribute("EmitDelay")
			if delayTime then
				task.delay(delayTime, triggerEmit, desc)
			else
				triggerEmit(desc)
			end
		end
	end

	if container:IsA("ParticleEmitter") then
		local delayTime = container:GetAttribute("EmitDelay")
		if delayTime then
			task.delay(delayTime, triggerEmit, container)
		else
			triggerEmit(container)
		end
	end
end

VFXLib.emitLoop = function(container, interval)
	container:SetAttribute("LoopTimer", interval)
	container:AddTag("EmitLoop")
end

if RunService:IsClient() then
	Observers.observeTag("EmitLoop", function(instance)
		return Observers.observeAttribute(instance, "LoopTimer", function(interval)
			if type(interval) ~= "number" then return nil end

			local timer = Timer.Simple(interval, function()
				VFXLib.emit(instance)
			end, true)

			return function()
				timer:Disconnect()
			end
		end)
	end, { workspace })
end

return VFXLib
