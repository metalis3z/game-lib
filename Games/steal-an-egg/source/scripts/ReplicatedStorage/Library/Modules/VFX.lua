-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Observers = require(ReplicatedStorage.Library.Modules.Packages.Observers)
local Timer = require(ReplicatedStorage.Library.Modules.Packages.Timer)
local t = {
	copy = function(p1, p2, p3) --[[ copy | Line: 13 ]]
		if p3 == nil then
			p3 = p1:IsA("Attachment") and workspace.Terrain or workspace.CurrentCamera
		end

		local v2 = p1:Clone()

		if v2:IsA("Attachment") then
			v2.WorldCFrame = if typeof(p2) == "CFrame" and p2 then p2 else CFrame.new(p2)
		elseif v2:IsA("PVInstance") then
			v2:PivotTo(if typeof(p2) == "CFrame" and p2 then p2 else CFrame.new(p2))
		else
			v2:Destroy()
			error("Can\'t move Container")
		end

		v2.Parent = p3

		return v2
	end,
	weld = function(p1, p2) --[[ weld | Line: 38 ]]
		local Weld = Instance.new("Weld")

		Weld.Part0 = p1
		Weld.Part1 = p2
		Weld.Parent = p1

		return Weld
	end,
	rescale = function(p1, p2) --[[ rescale | Line: 46 ]]
		local v1 = p1.Parent
		local Model = Instance.new("Model")

		p1.Parent = Model
		Model:ScaleTo(p2)
		p1.Parent = v1
	end,
	enable = function(p1) --[[ enable | Line: 54 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Beam") then
				v.Enabled = true
			end
		end
	end,
	disable = function(p1) --[[ disable | Line: 62 ]]
		for k, v in pairs(p1:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Beam") then
				v.Enabled = false
			end
		end
	end
}

local function emitEmitter(p1) --[[ emitEmitter | Line: 70 ]]
	local v1 = tonumber(p1:GetAttribute("EmitCount"))

	if not v1 then
		v1 = tonumber(p1.Name) or 0
	end

	local v3 = tonumber(p1:GetAttribute("EmitDuration")) or 0

	p1:Emit(v1)

	if not (v3 > 0) then
		return
	end

	p1.Enabled = true
	task.delay(v3, function() --[[ Line: 76 | Upvalues: p1 (copy) ]]
		p1.Enabled = false
	end)
end

function t.emit(p1) --[[ emit | Line: 82 | Upvalues: emitEmitter (copy) ]]
	for k, v in pairs(p1:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			local v1 = v:GetAttribute("EmitDelay")

			if v1 == nil then
				emitEmitter(v)

				continue
			end

			task.delay(v1, emitEmitter, v)
		end
	end

	if not p1:IsA("ParticleEmitter") then
		return
	end

	local v2 = p1:GetAttribute("EmitDelay")
	local v3 = p1:GetAttribute("EmitCount")

	if not v3 then
		v3 = tonumber(p1.Name) or 0
	end

	if v2 ~= nil then
		task.delay(v2, function() --[[ Line: 98 | Upvalues: p1 (copy), v3 (copy) ]]
			p1:Emit(v3)
		end)

		return
	end

	p1:Emit(v3)
end
function t.emitLoop(p1, p2) --[[ emitLoop | Line: 108 ]]
	p1:SetAttribute("LoopTimer", p2)
	p1:AddTag("EmitLoop")
end

if RunService:IsClient() then
	Observers.observeTag("EmitLoop", function(p1) --[[ Line: 114 | Upvalues: Observers (copy), Timer (copy), t (copy) ]]
		return Observers.observeAttribute(p1, "LoopTimer", function(p12) --[[ Line: 115 | Upvalues: Timer (ref), t (ref), p1 (copy) ]]
			if type(p12) == "number" then
				local v1 = Timer.Simple(p12, function() --[[ Line: 119 | Upvalues: t (ref), p1 (ref) ]]
					t.emit(p1)
				end, true)

				return function() --[[ Line: 122 | Upvalues: v1 (copy) ]]
					v1:Disconnect()
				end
			end

			return nil
		end)
	end, { workspace })
end

return t