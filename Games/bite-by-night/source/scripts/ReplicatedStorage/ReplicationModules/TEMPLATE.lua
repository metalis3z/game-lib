-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v_u_1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("Players")
game:GetService("SoundService")
local v_u_3 = require(v_u_1:WaitForChild("Modules"):WaitForChild("ClientReplicationObject"))
local v_u_4 = require(v_u_1:WaitForChild("Modules"):WaitForChild("VFX"))
local v_u_5 = require(v_u_1:WaitForChild("Modules"):WaitForChild("Misc"))
require(v_u_1:WaitForChild("Modules"):WaitForChild("CharacterEffects"))
require(v_u_1:WaitForChild("Modules"):WaitForChild("Timer"))
require(v_u_1:WaitForChild("Modules"):WaitForChild("EasterEgg"))
require(v_u_1:WaitForChild("Modules"):WaitForChild("ImpactFrames"))
game:GetService("TweenService")
local v_u_6 = CFrame.new(0, 0, 0)
local v_u_7 = v_u_1:WaitForChild("VFX"):WaitForChild("REPLACETHIS")
require(v_u_1:WaitForChild("Types"))
return function(p8)
	-- upvalues: (copy) v_u_5, (copy) v_u_3, (copy) v_u_2, (copy) v_u_1, (copy) v_u_4, (copy) v_u_6, (copy) v_u_7
	local v9 = p8[1]
	local v10 = p8[2]
	local v11 = v_u_5.GetAnimationByID(v9, "rbxassetid://REPLACETHIS")
	v_u_5.GetAnimationByID(v10, "rbxassetid://REPLACETHIS")
	local v12 = v_u_3.new()
	local v13 = v_u_2.LocalPlayer.Character or v_u_2.LocalPlayer.CharacterAdded:Wait()
	local v14 = require(v_u_1:WaitForChild("Cutscenes"):WaitForChild("Counters"):WaitForChild("REPLACETHIS"))(v9.HumanoidRootPart)
	if v13 == v9 or v13 == v10 then
		v14:Start()
		v12.DelayedMaid:Add(v14)
	else
		v14:Destroy()
	end
	local v_u_15 = v_u_4.new(30)
	v_u_15.ModelOffset = v_u_6
	v_u_15.ModelRelativeTo = v9.HumanoidRootPart
	local v_u_16 = v_u_15:SetVFXModel(v_u_7)
	v12.DelayedMaid:Add(v_u_15)
	v12.DelayMaidTime = 10
	v12.Maid:Add(v11:GetMarkerReachedSignal("NAME"):Once(function()
		-- upvalues: (copy) v_u_15, (copy) v_u_16
		v_u_15:RealignVFXModel()
		v_u_15:EmitAllDescendants(v_u_16.VFX.Hit)
	end))
	return v12
end