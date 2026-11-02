-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local v_u_4 = require(v1.Shared.TimeHelper)
local v_u_5 = v3.LocalPlayer.PlayerGui:WaitForChild("HUD")
local v_u_6 = v1:WaitForChild("Remotes")
local v_u_7 = script.EventFrameTemplate
local v_u_8 = {
	["OnGoingTimers"] = {}
}
local v_u_9 = {
	["LowGravity"] = {
		["DisplayName"] = "Low Gravity",
		["Icon"] = "rbxassetid://72954462474084"
	},
	["Disco"] = {
		["DisplayName"] = "Disco",
		["Icon"] = "rbxassetid://94352776299985"
	},
	["Valentines"] = {
		["DisplayName"] = "Valentines",
		["Icon"] = "rbxassetid://107288370969524"
	},
	["Server Luck"] = {
		["DisplayName"] = "",
		["Icon"] = ""
	},
	["Fuse Luck"] = {
		["DisplayName"] = "Fuse Luck",
		["Icon"] = "rbxassetid://134811111230950"
	}
}
function v_u_8.UpdateEvent(_, p10, p11, p12, p13)
	-- upvalues: (copy) v_u_8
	local v14 = v_u_8.OnGoingTimers[p10]
	if v14 then
		v14.Started = workspace:GetServerTimeNow()
		v14.Duration = p11
		if p12 then
			v14.UI.NameLabel.Text = p12
		end
		if p13 then
			v14.UI.Icon.Image = p13
		end
	end
end
function v_u_8.Init(_)
	-- upvalues: (copy) v_u_9, (copy) v_u_7, (copy) v_u_5, (copy) v_u_8, (copy) v_u_6, (copy) v_u_4, (copy) v_u_2
	for v15, v16 in v_u_9 do
		local v17 = v_u_7:Clone()
		v17.Parent = v_u_5.EventTimers
		v17.Name = v15
		v17.NameLabel.Text = v16.DisplayName
		v17.Icon.Image = v16.Icon
		v_u_8.OnGoingTimers[v15] = {
			["UI"] = v17,
			["Duration"] = 0,
			["Started"] = workspace:GetServerTimeNow()
		}
	end
	v_u_6.UpdateClientTimer.OnClientEvent:Connect(function(p18, p19, p20, p21)
		-- upvalues: (ref) v_u_8
		v_u_8:UpdateEvent(p18, p19, p20, p21)
	end)
	while true do
		for _, v22 in v_u_8.OnGoingTimers do
			local v23 = v22.Duration - (workspace:GetServerTimeNow() - v22.Started)
			local v24 = math.floor(v23)
			local v25 = math.max(0, v24)
			v22.UI.DurationLabel.Text = v_u_4:GenerateColonFormatFromTime(v25)
			v22.UI.Visible = v25 > 0
		end
		v_u_2.RenderStepped:Wait()
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_8
	v_u_8:Init()
end)
return v_u_8
