-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("CollectionService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = game:GetService("ReplicatedFirst")
local v4 = game:GetService("Players")
local v5 = require(v2.Modules.DataController.Modules.Signal)
local v6 = v2.Remotes.UpdateRemotes
local v7 = v6:WaitForChild("UpdateTime")
local v8 = v6:WaitForChild("ShowContent")
local v9 = v6:WaitForChild("HideContent")
local v_u_10 = v4.LocalPlayer.PlayerGui
local v11 = v3.UpdateValues
local v_u_12 = v11.NextUpdateTime
local v_u_13 = v11.PrevUpdateTime
local v_u_14 = {
	["UpdateSignalClient"] = v5.new(),
	["UpdateFinished"] = false,
	["UpdateFinishedClient"] = false
}
local function v_u_23(p15)
	local v16 = p15 / 86400
	local v17 = math.floor(v16)
	local v18 = p15 % 86400 / 3600
	local v19 = math.floor(v18)
	local v20 = p15 % 3600 / 60
	local v21 = math.floor(v20)
	local v22 = p15 % 60
	if v17 > 0 then
		return string.format("%dd %02dh %02dm %02ds", v17, v19, v21, v22)
	elseif v19 > 0 then
		return string.format("%02dh %02dm %02ds", v19, v21, v22)
	elseif v21 > 0 then
		return string.format("%02dm %02ds", v21, v22)
	else
		return string.format("%02ds", v22)
	end
end
local function v_u_28(p24, p25)
	-- upvalues: (copy) v_u_1
	for _, v26 in p24 do
		for _, v27 in v_u_1:GetTagged(v26) do
			if v27:IsA("GuiObject") then
				v27.Visible = p25
			end
		end
	end
end
function v_u_14.Start()
	-- upvalues: (copy) v_u_10, (copy) v_u_13, (copy) v_u_12, (copy) v_u_23, (copy) v_u_14
	local v_u_29 = v_u_10:WaitForChild("UpdateTimer").UpdateTimerFrame.UpdateCounter
	task.spawn(function()
		-- upvalues: (ref) v_u_13, (ref) v_u_12, (ref) v_u_23, (copy) v_u_29, (ref) v_u_14
		if v_u_13.Value == 0 then
			while true do
				local v30 = workspace:GetServerTimeNow()
				local v31 = v_u_12.Value - v30
				local v32 = math.round(v31)
				local v33 = v_u_23(v32)
				v_u_29.Visible = v32 > 0
				v_u_29.Text = ("Update in:\n%*"):format(v33)
				if v32 < 0 then
					break
				end
				task.wait(0.5)
			end
		end
		v_u_29.Visible = false
		v_u_14.UpdateFinishedClient = true
	end)
end
task.spawn(v_u_14.Start)
v8.OnClientEvent:Connect(function(p34)
	-- upvalues: (copy) v_u_28
	v_u_28(p34, true)
end)
v9.OnClientEvent:Connect(function(p35)
	-- upvalues: (copy) v_u_28
	v_u_28(p35, false)
end)
v7.OnClientEvent:Connect(function()
	-- upvalues: (copy) v_u_14
	v_u_14.UpdateSignalClient:Fire()
	if not v_u_14.UpdateFinishedClient then
		v_u_14.UpdateFinishedClient = true
	end
	v_u_14.UpdateFinished = true
end)
return v_u_14
