-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("StarterPlayer")
local v2 = {}
local v_u_3 = require(v1.StarterPlayerScripts.Controllers.TweenModel)
local v_u_4 = workspace.UpdateInstances.LuckyBlockMachine.Model:GetPivot()
local v_u_5 = v_u_4 * CFrame.new(0, -30, 0)
if workspace:GetAttribute("LuckyBlockFuseEnabled") then
	workspace.UpdateInstances.LuckyBlockMachine.Model:PivotTo(v_u_4)
else
	workspace.UpdateInstances.LuckyBlockMachine.Model:PivotTo(v_u_5)
end
workspace:GetAttributeChangedSignal("LuckyBlockFuseEnabled"):Connect(function()
	-- upvalues: (copy) v_u_3, (copy) v_u_4, (copy) v_u_5
	local v6 = v_u_3
	local v7 = workspace.UpdateInstances.LuckyBlockMachine.Model
	local v8 = TweenInfo.new(5)
	local v9 = {}
	local v10
	if workspace:GetAttribute("LuckyBlockFuseEnabled") then
		v10 = v_u_4
	else
		v10 = v_u_5
	end
	v9.CFrame = v10
	v6(v7, v8, v9):Play()
end)
return v2
