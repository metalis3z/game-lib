local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("RunService")
game:GetService("Lighting")
game:GetService("Players")
require(v1.Shared.EventTypes)
local v2 = {}
require(v1.Controllers.AnimalController)
local v_u_3 = require(v1.Controllers.SoundController)
require(v1.Controllers.EventController)
local v_u_4 = require(v1.Controllers.CycleController)
local v5 = require(v1.Packages.Trove)
require(v1.Packages.Net)
local v_u_6 = require(v1.Shared.VFX)
local _ = script.Name
local v_u_7 = workspace.Events.Rainbow
local v_u_8 = v5.new()
function v2.OnStart(_)
	-- upvalues: (copy) v_u_4, (copy) v_u_3, (copy) v_u_6, (copy) v_u_7, (copy) v_u_8
	v_u_4:Update()
	v_u_3:UpdateOST()
	v_u_6.emit(v_u_7.Emit)
	v_u_8:Add(task.spawn(function()
		-- upvalues: (ref) v_u_3, (ref) v_u_7
		v_u_3:PlaySound("Sounds.Sfx.RainbowActivatedEffect", v_u_7.SoundParts.RainbowActivatedEffect.Position)
	end))
	v_u_8:Add(task.spawn(function()
		-- upvalues: (ref) v_u_3, (ref) v_u_7
		v_u_3:PlaySound("Sounds.Sfx.RainbowMachineEnabled", v_u_7.SoundParts.RainbowMachineEnabled.Position)
	end))
	v_u_8:Add(task.spawn(function()
		-- upvalues: (ref) v_u_7
		local v9 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 1) })
		local v10 = v_u_7.Enabled.RainbowMain.RainbowHandle.Wiggler.Attachment3:GetChildren()
		for _, v11 in v10 do
			v11.Transparency = v9
			v11.Enabled = true
		end
		local v12 = workspace:GetServerTimeNow()
		while true do
			local v13 = workspace:GetServerTimeNow()
			local v14 = (v13 - v12) % 3.5 / 3.5
			local v15 = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1 - v14, 1), NumberSequenceKeypoint.new(1, 0) })
			if v13 - v12 >= 3.5 then
				break
			end
			for _, v16 in v10 do
				v16.Transparency = v15
			end
			task.wait()
		end
		for _, v17 in v10 do
			v17.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 0) })
		end
	end))
	v_u_6.enable(v_u_7.Enabled)
	v_u_8:Add(function()
		-- upvalues: (ref) v_u_6, (ref) v_u_7
		v_u_6.disable(v_u_7.Enabled)
	end)
end
function v2.OnStop(_)
	-- upvalues: (copy) v_u_8
	v_u_8:Destroy()
end
function v2.OnLoad(_) end
return v2
