-- Saved by anthu decompiler gui script (used universalsynsaveinstance) (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = game:GetService("ContextActionService")
local v2 = game:GetService("ReplicatedStorage")
game:GetService("UserInputService")
local v3 = game:GetService("Players")
local v4 = game:GetService("StarterPlayer")
local v_u_5 = v3.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD")
local v_u_6 = nil
local v_u_7 = require(v4.StarterPlayerScripts.Controllers.PollController)
local v_u_8 = require(v2.Modules.HasProperty)
local v9 = require(v2.Modules.Signal)
local v_u_10 = require(v2.Modules.Spring)
local v_u_11 = require(v2.Icon)
local v_u_12 = require(script.Autocomplete)
local v_u_13 = v2.Events.AdminPanel
local v_u_14 = script.UIGradient
local v_u_15 = {
	["Visible"] = true,
	["AccessGranted"] = false,
	["AccessCode"] = "12345",
	["PanelOpened"] = v9.new(),
	["PanelClosed"] = v9.new(),
	["CurrentPage"] = "Actions",
	["GlobalState"] = false
}
function _SetupAutocomplete()
	-- upvalues: (ref) v_u_6, (copy) v_u_12
	for _, v16 in v_u_6.Pages:GetDescendants() do
		local v17 = v16:FindFirstChildWhichIsA("TextBox")
		if v17 then
			local v18 = v17:FindFirstChild("Options")
			if v18 then
				local v19 = v18:GetAttribute("GetSuggestionsFunction")
				if v19 then
					local v20 = v_u_12[v19]
					if v20 then
						v_u_12.SetupAutocomplete(v17, v18, v20)
					end
				end
			end
		end
	end
end
function SetupButton(p_u_21, p_u_22)
	-- upvalues: (copy) v_u_15, (copy) v_u_10
	local v23 = p_u_21:FindFirstChild("SENSOR")
	if v23 then
		local v_u_24 = p_u_21:FindFirstChild("UIScale")
		if not v_u_24 then
			v_u_24 = Instance.new("UIScale")
			v_u_24.Scale = 1
			v_u_24.Parent = p_u_21
		end
		local v_u_25 = false
		v23.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_25, (ref) v_u_10, (ref) v_u_24, (copy) p_u_21
			if v_u_15.AccessGranted then
				v_u_25 = true
				v_u_10.target(v_u_24, 1, 8, {
					["Scale"] = 1.1
				})
				v_u_10.target(p_u_21, 1, 8, {
					["BackgroundTransparency"] = 0.6
				})
			end
		end)
		v23.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_25, (ref) v_u_10, (ref) v_u_24, (copy) p_u_21
			if v_u_15.AccessGranted then
				v_u_25 = false
				v_u_10.target(v_u_24, 1, 8, {
					["Scale"] = 1
				})
				v_u_10.target(p_u_21, 1, 8, {
					["BackgroundTransparency"] = 0.8
				})
			end
		end)
		v23.MouseButton1Down:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_10, (ref) v_u_24
			if v_u_15.AccessGranted then
				v_u_10.target(v_u_24, 1, 8, {
					["Scale"] = 0.9
				})
			end
		end)
		v23.MouseButton1Up:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_10, (ref) v_u_24, (ref) v_u_25
			if v_u_15.AccessGranted then
				local v26 = {
					["Scale"] = v_u_25 and 1.1 or 1
				}
				v_u_10.target(v_u_24, 1, 8, v26)
			end
		end)
		if p_u_22 then
			v23.Activated:Connect(function()
				-- upvalues: (ref) v_u_15, (copy) p_u_22
				if v_u_15.AccessGranted then
					p_u_22()
				end
			end)
		end
	end
end
function v_u_15.OpenPage(_, p27)
	-- upvalues: (copy) v_u_15, (ref) v_u_6, (copy) v_u_10, (copy) v_u_14
	if v_u_15.Visible then
		local v28 = v_u_6.Menu_Selection.ScrollingFrame.Button_List.Main:FindFirstChild(p27)
		local v29 = v_u_6.Pages:FindFirstChild(p27)
		if v28 and v29 then
			for _, v30 in v_u_6.Menu_Selection.ScrollingFrame.Button_List.Main:GetChildren() do
				if v30:IsA("Frame") then
					local v31 = v30 == v28 and "selected" or "unselected"
					v30:SetAttribute("_state", v31)
					v_u_10.target(v30, 1, 6, {
						["BackgroundTransparency"] = v31 == "unselected" and 0.95 or 0,
						["BackgroundColor3"] = v31 == "unselected" and Color3.new(1, 1, 1) or Color3.fromRGB(25, 255, 214)
					})
					local v32 = v30:FindFirstChild("UIStroke")
					if v32 then
						v32.Enabled = v30 ~= v28
					end
					local v33 = v30:FindFirstChild("Title_Text")
					if v33 then
						v33.TextColor3 = v30 == v28 and Color3.new(0, 0, 0) or Color3.new(1, 1, 1)
						v33.TextTransparency = v30 == v28 and 0 or 0.7
						v33.FontFace = Font.new(v33.FontFace.Family, v30 == v28 and Enum.FontWeight.SemiBold or Enum.FontWeight.Regular)
					end
				end
			end
			v_u_14.Parent = v28
			for _, v34 in v_u_6.Pages:GetChildren() do
				v34.Visible = v34 == v29
			end
		end
	else
		return
	end
end
function v_u_15.ToggleGlobalState(_)
	-- upvalues: (copy) v_u_15, (ref) v_u_6, (copy) v_u_8, (copy) v_u_10
	v_u_15.GlobalState = not v_u_15.GlobalState
	local v35 = v_u_6.Menu_Selection.Global_Toggle:GetChildren()
	local v36 = v_u_6.Menu_Selection.Global_Toggle
	table.insert(v35, v36)
	local v37 = v_u_6.Menu_Selection.Details.Button_Disclaimer
	table.insert(v35, v37)
	v_u_6.Menu_Selection.Global_Toggle.Status.Text = ("GLOBAL:                   %*"):format(v_u_15.GlobalState and "ON" or "OFF")
	for _, v38 in v35 do
		local v39 = {}
		for _, v40 in {
			"TextColor3",
			"Color",
			"ImageColor3",
			"BackgroundColor3"
		} do
			if v_u_8(v38, v40) then
				v39[v40] = v_u_15.GlobalState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
			end
		end
		if next(v39) then
			v_u_10.target(v38, 1, 6, v39)
		end
	end
end
function v_u_15.ToggleVisibility(_)
	-- upvalues: (copy) v_u_15
	v_u_15:SetVisibility(not v_u_15.Visible)
end
function v_u_15.SetVisibility(_, p41)
	-- upvalues: (copy) v_u_15, (copy) v_u_10, (ref) v_u_6
	v_u_15.Visible = p41
	v_u_10.target(v_u_6.UIScale, 1, 6, {
		["Scale"] = p41 and 1.125 or 0
	});
	(p41 and v_u_15.PanelOpened or v_u_15.PanelClosed):Fire()
end
function v_u_15.Start()
	-- upvalues: (ref) v_u_6, (copy) v_u_5, (copy) v_u_15, (copy) v_u_10, (copy) v_u_13, (copy) v_u_7, (copy) v_u_8, (copy) v_u_1, (copy) v_u_11
	v_u_6 = v_u_5:FindFirstChild("AdminPanel")
	if v_u_6 then
		v_u_15:SetVisibility(false)
		for _, v42 in v_u_6.Pages:GetChildren() do
			if v42:IsA("Frame") then
				v42.Visible = false
			end
		end
		v_u_6.Intro.Visible = true
		local v_u_43 = v_u_6.Top_Bar.Main.Exit_Button
		local v_u_44 = {
			["Idle"] = Color3.fromRGB(1, 12, 10),
			["Hover"] = Color3.fromRGB(20, 204, 171),
			["SpringSettings"] = {
				["Damping"] = 1,
				["Speed"] = 6
			}
		}
		v_u_43.SENSOR.MouseEnter:Connect(function()
			-- upvalues: (ref) v_u_10, (copy) v_u_43, (copy) v_u_44
			v_u_10.target(v_u_43, v_u_44.SpringSettings.Damping, v_u_44.SpringSettings.Speed, {
				["BackgroundColor3"] = v_u_44.Hover
			})
		end)
		v_u_43.SENSOR.MouseLeave:Connect(function()
			-- upvalues: (ref) v_u_10, (copy) v_u_43, (copy) v_u_44
			v_u_10.target(v_u_43, v_u_44.SpringSettings.Damping, v_u_44.SpringSettings.Speed, {
				["BackgroundColor3"] = v_u_44.Idle
			})
		end)
		v_u_43.SENSOR.Activated:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_10, (copy) v_u_43, (copy) v_u_44
			v_u_15:SetVisibility(false)
			v_u_10.target(v_u_43, v_u_44.SpringSettings.Damping, v_u_44.SpringSettings.Speed, {
				["BackgroundColor3"] = v_u_44.Idle
			})
		end)
		for _, v_u_45 in v_u_6.Menu_Selection.ScrollingFrame.Button_List.Main:GetChildren() do
			if v_u_45:IsA("Frame") and v_u_45:FindFirstChild("SENSOR") then
				local v46 = v_u_45.SENSOR
				v_u_45:SetAttribute("_state", "unselected")
				v46.MouseEnter:Connect(function()
					-- upvalues: (ref) v_u_15, (ref) v_u_10, (copy) v_u_45
					if v_u_15.AccessGranted then
						v_u_10.target(v_u_45, 1, 6, {
							["BackgroundTransparency"] = 0.5,
							["BackgroundColor3"] = Color3.fromRGB(25, 255, 214)
						})
					end
				end)
				v46.MouseLeave:Connect(function()
					-- upvalues: (ref) v_u_15, (copy) v_u_45, (ref) v_u_10
					if v_u_15.AccessGranted then
						local v47 = v_u_45:GetAttribute("_state")
						v_u_10.target(v_u_45, 1, 6, {
							["BackgroundTransparency"] = v47 == "unselected" and 0.95 or 0,
							["BackgroundColor3"] = v47 == "unselected" and Color3.new(1, 1, 1) or Color3.fromRGB(25, 255, 214)
						})
					end
				end)
				v46.Activated:Connect(function()
					-- upvalues: (ref) v_u_15, (copy) v_u_45
					if v_u_15.AccessGranted then
						v_u_15:OpenPage(v_u_45.Name)
					end
				end)
			end
		end
		local v66 = {
			["Ban"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Ban", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Explode"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Explode", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Fling"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Fling", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Freeze"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Freeze", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Invincibility_On"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("InvincibleOn", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Invincibility_Off"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("InvincibleOff", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Kick"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Kick", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Kill"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Kill", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Tp_Here"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("TPHere", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["Tp_To"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("TPTo", {
					["Player"] = v_u_6.Pages.Actions.Textbox.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["GiveMoney"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				local v48 = v_u_13
				local v49 = {
					["Player"] = v_u_6.Pages.Economy.Player_Name.TextBox.Text
				}
				local v50 = v_u_6.Pages.Economy.Amount.TextBox.Text
				v49.Amount = tonumber(v50)
				v49.Global = v_u_15.GlobalState
				v48:FireServer("GiveMoney", v49)
			end,
			["TakeMoney"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				local v51 = v_u_13
				local v52 = {
					["Player"] = v_u_6.Pages.Economy.Player_Name.TextBox.Text
				}
				local v53 = v_u_6.Pages.Economy.Amount.TextBox.Text
				v52.Amount = tonumber(v53)
				v52.Global = v_u_15.GlobalState
				v51:FireServer("TakeMoney", v52)
			end,
			["StartEvent"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("StartEvent", {
					["Event"] = v_u_6.Pages.Events.ScrollingFrame.Event.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["EndEvent"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("EndEvent", {
					["Event"] = v_u_6.Pages.Events.ScrollingFrame.Event.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["SendAnnouncement"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("Announce", {
					["Message"] = v_u_6.Pages.Events.ScrollingFrame.Announcement.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["SpawnCutscene"] = function()
				-- upvalues: (ref) v_u_6, (ref) v_u_13, (ref) v_u_15
				local v54 = v_u_6.Pages.Events.ScrollingFrame.Cutscene.LuckyBlock.TextBox.Text
				local v55 = v_u_6.Pages.Events.ScrollingFrame.Cutscene.Area.TextBox.Text
				if v54 == "" then
					v54 = nil
				end
				if v55 == "" then
					v55 = nil
				end
				v_u_13:FireServer("SpawnLuckyblockCutscene", {
					["Luckyblock"] = v54,
					["Area"] = v55,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["GiveItem"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("GiveItem", {
					["Player"] = v_u_6.Pages.Items.Player_Name.TextBox.Text,
					["Item"] = v_u_6.Pages.Items.Item.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["TakeItem"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("TakeItem", {
					["Player"] = v_u_6.Pages.Items.Player_Name.TextBox.Text,
					["Item"] = v_u_6.Pages.Items.Item.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["BaseSpawn"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("SpawnItem", {
					["Player"] = v_u_6.Pages.Items.Player_Name.TextBox.Text,
					["Item"] = v_u_6.Pages.Items.Item.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["ServerSpawn"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("SpawnItemServer", {
					["Player"] = v_u_6.Pages.Items.Player_Name.TextBox.Text,
					["Item"] = v_u_6.Pages.Items.Item.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end,
			["ChanceSpawnItemServer"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				local v56 = v_u_13
				local v57 = {
					["Player"] = v_u_6.Pages.Items.Player_Name.TextBox.Text
				}
				local v58 = v_u_6.Pages.Spawner.Chance.TextBox.Text
				local v59 = tonumber(v58)
				v57.Chance = (not v59 or v59 < 0.001) and 0 or math.clamp(v59, 0.001, 100)
				v57.Item = v_u_6.Pages.Spawner.Brainrot_Name.TextBox.Text
				v57.Global = v_u_15.GlobalState
				v56:FireServer("ChanceSpawnItemServer", v57)
			end,
			["Open_Poll"] = function()
				-- upvalues: (ref) v_u_7, (ref) v_u_15, (ref) v_u_6
				local v60 = v_u_7
				local v61 = v_u_15.GlobalState
				local v62 = v_u_6.Pages.Poll.Textbox.TextBox.Text
				v60:OpenPollCreate(v61, (tonumber(v62)))
				v_u_15:SetVisibility(false)
			end,
			["GiveFuseLuck"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				local v63 = v_u_13
				local v64 = {
					["Player"] = v_u_6.Pages.FuseMachine.Player_Name.TextBox.Text
				}
				local v65 = v_u_6.Pages.FuseMachine.Duration.TextBox.Text
				v64.Duration = tonumber(v65) or 0
				v64.Global = v_u_15.GlobalState
				v63:FireServer("GiveFuseLuck", v64)
			end,
			["SkipFuseMachineTime"] = function()
				-- upvalues: (ref) v_u_13, (ref) v_u_6, (ref) v_u_15
				v_u_13:FireServer("SkipFuseMachineTime", {
					["Player"] = v_u_6.Pages.FuseMachine.Player_Name.TextBox.Text,
					["Global"] = v_u_15.GlobalState
				})
			end
		}
		for _, v67 in v_u_6.Pages:QueryDescendants("Frame:has(TextButton [Name = SENSOR])") do
			local v68 = v66[v67.Name]
			SetupButton(v67, v68)
		end
		v_u_6.Menu_Selection.Global_Toggle.SENSOR.Activated:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_6
			if v_u_15.AccessGranted then
				v_u_15:ToggleGlobalState()
				for _, v69 in v_u_6:QueryDescendants(".NoGlobal") do
					if v69:IsA("GuiObject") then
						v69.Visible = not v_u_15.GlobalState
					end
				end
			end
		end)
		local v_u_70 = {}
		local v_u_71 = {}
		local v_u_72 = {}
		for _, v73 in Enum.KeyCode:GetEnumItems() do
			if v73.Name:match("^[A-Z]$") then
				table.insert(v_u_70, v73)
				table.insert(v_u_71, v73)
			elseif v73.Value >= 48 and v73.Value <= 57 then
				table.insert(v_u_72, v73)
				table.insert(v_u_71, v73)
			end
		end
		local v_u_74 = {
			["Zero"] = 0,
			["One"] = 1,
			["Two"] = 2,
			["Three"] = 3,
			["Four"] = 4,
			["Five"] = 5,
			["Six"] = 6,
			["Seven"] = 7,
			["Eight"] = 8,
			["Nine"] = 9
		}
		local v_u_75 = nil
		local v_u_76 = v_u_6.Intro.Login_Sequence.Main.Main
		v_u_15.PanelOpened:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_6, (copy) v_u_76, (ref) v_u_10, (ref) v_u_8, (ref) v_u_75, (ref) v_u_1, (copy) v_u_74, (copy) v_u_72, (copy) v_u_70, (copy) v_u_71
			if not v_u_15.AccessGranted then
				local v_u_77 = "ACCESS TERMINAL"
				local function v_u_85(p78)
					-- upvalues: (ref) v_u_76, (ref) v_u_10, (ref) v_u_8
					local v79 = {
						v_u_76.Topbar,
						v_u_76.Details.Underlight,
						v_u_76.Code.Dash,
						v_u_76.Disclaimer,
						v_u_76.UIStroke
					}
					for v80 = 1, 5 do
						local v81 = v_u_76.Code[tostring(v80)].Main
						table.insert(v79, v81)
						local v82 = v_u_76.Code[tostring(v80)].UIStroke
						table.insert(v79, v82)
					end
					for _, v83 in v79 do
						v_u_10.stop(v83)
						local v84 = {
							["BackgroundColor3"] = v_u_8(v83, "BackgroundColor3") and Color3.fromRGB(25, 255, 214) or nil,
							["TextColor3"] = v_u_8(v83, "TextColor3") and Color3.fromRGB(25, 255, 214) or nil,
							["Color"] = v_u_8(v83, "Color") and Color3.fromRGB(25, 255, 214) or nil
						}
						if v84.BackgroundColor3 then
							v83.BackgroundColor3 = p78
						end
						if v84.TextColor3 then
							v83.TextColor3 = p78
						end
						if v84.Color then
							v83.Color = p78
						end
						v_u_10.target(v83, 1, 1, v84)
					end
				end
				v_u_75 = task.spawn(function()
					-- upvalues: (ref) v_u_6, (ref) v_u_77
					while true do
						for v86 = 1, 3 do
							v_u_6.Intro.Login_Sequence.Main.Main.Topbar.Frame_Title.Text = ("%* %* %*"):format(string.rep(">", v86), v_u_77, (string.rep("<", v86)))
							task.wait(0.75)
						end
					end
				end)
				local v87 = v_u_77
				local v88 = v_u_6.Intro.Login_Sequence.Main.Main.Topbar.Frame_Title
				v88.Text = v88.Text:gsub(v_u_77, v87:upper())
				v_u_77 = v87
				local v_u_89 = v_u_6.Intro.Login_Sequence.Main.Main.Code
				local v90 = ""
				v90 = ""
				local v_u_91 = v90
				local v_u_92 = v_u_77
				for _, v93 in v_u_89:QueryDescendants(">Frame") do
					local v94 = v93.Name
					if v94 then
						local v95 = v_u_89:FindFirstChild(v94)
						v95.Main.BackgroundTransparency = 0.8
						v95.Main.Number.Text = ""
						v95.UIStroke.Transparency = 0.4
					end
				end
				local v96 = v_u_15.AccessCode:gsub("%-", "")
				v_u_6.Intro.Login_Sequence.Visible = not v_u_15.AccessGranted
				local v97 = v_u_1
				local function v108(_, p98, p99)
					-- upvalues: (ref) v_u_74, (ref) v_u_91, (copy) v_u_89, (ref) v_u_15, (ref) v_u_75, (ref) v_u_1, (copy) v_u_85, (ref) v_u_6, (ref) v_u_92, (ref) v_u_10
					if p98 == Enum.UserInputState.Begin then
						local v100 = v_u_74[p99.KeyCode.Name] or p99.KeyCode.Name
						v_u_91 = v_u_91 .. v100
						local v101 = #v_u_91
						if v101 then
							local v102 = v_u_89:FindFirstChild(v101)
							v102.Main.BackgroundTransparency = v100 and 0.4 or 0.8
							v102.Main.Number.Text = v100 and "*" or ""
							v102.UIStroke.Transparency = v100 and 0 or 0.4
						end
						if #v_u_91 ~= #v_u_15.AccessCode then
							return Enum.ContextActionResult.Sink
						end
						if v_u_91:lower() == v_u_15.AccessCode:lower() then
							pcall(task.cancel, v_u_75)
							v_u_15.AccessGranted = true
							v_u_1:UnbindAction("ACCESSCODE")
							v_u_85(Color3.fromRGB(50, 255, 50))
							local v103 = v_u_6.Intro.Login_Sequence.Main.Main.Topbar.Frame_Title
							v103.Text = v103.Text:gsub(v_u_92, ("ACCESS GRANTED"):upper())
							v_u_92 = "ACCESS GRANTED"
							task.wait(1)
							v_u_10.target(v_u_6.Intro.Login_Sequence.Main.UIScale, 1, 3, {
								["Scale"] = 0
							})
							v_u_10.target(v_u_6.Intro.Login_Sequence, 1, 3, {
								["BackgroundTransparency"] = 1
							})
							v_u_10.target(v_u_6.Intro.Login_Sequence.Details.Static, 1, 3, {
								["ImageTransparency"] = 1
							})
							v_u_10.completed(v_u_6.Intro.Login_Sequence.Main.UIScale, function()
								-- upvalues: (ref) v_u_6
								v_u_6.Intro.Visible = false
							end)
							v_u_6.Menu_Selection.Visible = true
							v_u_15:OpenPage("Actions")
						else
							v_u_91 = ""
							for _, v104 in v_u_89:QueryDescendants(">Frame") do
								local v105 = v104.Name
								if v105 then
									local v106 = v_u_89:FindFirstChild(v105)
									v106.Main.BackgroundTransparency = 0.8
									v106.Main.Number.Text = ""
									v106.UIStroke.Transparency = 0.4
								end
							end
							v_u_85(Color3.fromRGB(255, 50, 50))
							local v107 = v_u_6.Intro.Login_Sequence.Main.Main.Topbar.Frame_Title
							v107.Text = v107.Text:gsub(v_u_92, ("ACCESS DENIED"):upper())
							v_u_92 = "ACCESS DENIED"
						end
						return Enum.ContextActionResult.Sink
					end
				end
				local v109 = v96:match("^%d+$") and v_u_72 or (v96:match("^[A-Za-z]+$") and v_u_70 or v_u_71)
				v97:BindActionAtPriority("ACCESSCODE", v108, false, 2000, table.unpack(v109))
			end
		end)
		v_u_15.PanelClosed:Connect(function()
			-- upvalues: (ref) v_u_15, (ref) v_u_1, (ref) v_u_75
			if not v_u_15.AccessGranted then
				v_u_1:UnbindAction("ACCESSCODE")
				pcall(task.cancel, v_u_75)
			end
		end)
		v_u_11.new():setLabel("Admin [WIP]"):setRight(true):bindEvent("deselected", function()
			-- upvalues: (ref) v_u_15
			v_u_15:ToggleVisibility(true)
		end):oneClick()
		_SetupAutocomplete()
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_5, (copy) v_u_15
	local v_u_110 = nil
	if v_u_5:FindFirstChild("AdminPanel") then
		v_u_15.Start()
	else
		local _ = v_u_5.ChildAdded:Connect(function(p111)
			-- upvalues: (ref) v_u_15, (ref) v_u_110
			if p111:IsA("Frame") and p111.Name == "AdminPanel" then
				v_u_15.Start()
				v_u_110:Disconnect()
				v_u_110 = nil
			end
		end)
	end
end)
return v_u_15
