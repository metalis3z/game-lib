-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = {}
local v_u_2 = game:GetService("TextService")
local v_u_3 = game:GetService("UserInputService")
local v_u_4 = game:GetService("GuiService")
local v_u_5 = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("PlatformRemotes")
local v_u_6 = v_u_2:GetTextSize(utf8.char(65535), 16, "SourceSans", Vector2.one * 1000)
local v_u_7 = {
	["Desktop"] = "Desktop",
	["Mobile"] = "Mobile",
	["Console"] = "Console",
	["Unknown"] = "Unknown"
}
local v_u_8 = {
	["Xbox"] = "Xbox",
	["PlayStation"] = "PlayStation",
	["Windows"] = "Windows",
	["MacOs"] = "macOS",
	["Ios"] = "iOS",
	["Linux"] = "Linux",
	["MetaHorizon"] = "Meta Horizon OS",
	["Android"] = "Android",
	["Unknown"] = "Unknown"
}
local v_u_9 = {
	[0] = v_u_7.Desktop,
	[2] = v_u_7.Mobile,
	[1] = v_u_7.Console
}
local function v_u_17()
	-- upvalues: (copy) v_u_9, (copy) v_u_7, (copy) v_u_4, (copy) v_u_3
	local v_u_10 = Version()
	local v11, v12 = pcall(function()
		-- upvalues: (copy) v_u_10
		return v_u_10:split(".")
	end)
	local v13
	if v11 then
		local v14 = v12[1]
		v13 = v_u_9[tonumber(v14)] or v_u_7.Unknown
	else
		v13 = nil
	end
	if v13 and v13 ~= v_u_7.Unknown then
		return v13
	elseif v_u_4:IsTenFootInterface() then
		return v_u_7.Console
	else
		local v15 = 0
		local v16 = 0
		if v_u_3.PreferredInput == Enum.PreferredInput.KeyboardAndMouse then
			v15 = v15 + 1
		end
		if v_u_3.GyroscopeEnabled then
			v16 = v16 + 2
		end
		if v_u_3.AccelerometerEnabled then
			v16 = v16 + 2
		end
		if v_u_3.KeyboardEnabled then
			v15 = v15 + 1
		end
		if v_u_3.MouseEnabled then
			v15 = v15 + 1
		end
		if v_u_3.GamepadEnabled then
			v15 = v15 + 1
		end
		if v16 == v15 then
			if v_u_3.TouchEnabled then
				return v_u_7.Mobile
			else
				return v_u_7.Desktop
			end
		elseif v15 < v16 then
			return v_u_7.Mobile
		else
			return v_u_7.Desktop
		end
	end
end
function v_u_1.GetPlatform(_)
	-- upvalues: (copy) v_u_17
	return v_u_17()
end
function v_u_1.GetSpecificPlatform(_)
	-- upvalues: (copy) v_u_17, (copy) v_u_7, (copy) v_u_3, (copy) v_u_8, (copy) v_u_4, (copy) v_u_2, (copy) v_u_6
	local v18 = v_u_17()
	if v18 == v_u_7.Console then
		local v19 = v_u_3:GetStringForKeyCode(Enum.KeyCode.ButtonL2)
		if v19 == "ButtonLT" then
			return v_u_8.Xbox
		elseif v19 == "ButtonL2" then
			return v_u_8.PlayStation
		else
			return v_u_8.Unknown
		end
	elseif v18 == v_u_7.Desktop then
		if v_u_4.IsWindows then
			return v_u_8.Windows
		else
			return v_u_8.MacOs
		end
	elseif v18 == v_u_7.Mobile then
		if v_u_3.VREnabled then
			return v_u_8.MetaHorizon
		else
			local v20 = v_u_2:GetTextSize(utf8.char(63743), 16, "SourceSans", Vector2.one * 1000)
			if v_u_6.Magnitude ~= v20.Magnitude then
				return v_u_8.Ios
			elseif v_u_3.TouchEnabled then
				return v_u_8.Android
			else
				return v_u_8.Linux
			end
		end
	else
		return
	end
end
function v_u_1.Start(p21)
	-- upvalues: (copy) v_u_17, (copy) v_u_5
	local v22 = v_u_17()
	if v22 then
		local v23 = p21:GetSpecificPlatform()
		if v23 then
			v_u_5.SendPlatformType:FireServer(v22, v23)
		end
	else
		return
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_1
	v_u_1:Start()
end)
return v_u_1
