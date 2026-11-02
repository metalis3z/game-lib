-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:02
-- Luau version 6, Types version 3
-- Time taken: 0.004608 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "SettingsFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local var14_upvw
local var15_upvw
local var16_upvw
local MainUI = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI")
local SettingsFrame_upvr = MainUI:WaitForChild("Menus"):WaitForChild("SettingsFrame")
local List_upvr = SettingsFrame_upvr:WaitForChild("Main"):WaitForChild("List")
local List = SettingsFrame_upvr:WaitForChild("Displays"):WaitForChild("List")
local Settings_upvr_2 = List_upvr:WaitForChild("Settings")
local Boosts_upvr = MainUI:WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Boosts")
function any_new_result1.settingChanged(arg1, arg2, arg3) -- Line 60
	--[[ Upvalues[4]:
		[1]: var7_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var6_upvw (read and write)
		[4]: Boosts_upvr (readonly)
	]]
	if arg2 == "hideAuras" then
		var7_upvw:toggleAllAuras(not arg3)
	else
		if arg2 == "hideYourPets" then
			var8_upvw:togglePets(true, not arg3)
			return
		end
		if arg2 == "hideOtherPets" then
			var8_upvw:togglePets(false, not arg3)
			return
		end
		if arg2 == "hidePetsInfo" then
			var8_upvw:togglePetInfos(not arg3)
			return
		end
		if arg2 == "muteSounds" then
			var6_upvw:toggleSounds(not arg3)
			return
		end
		if arg2 == "muteMusic" then
			var6_upvw:toggleMusic(not arg3, true)
			return
		end
		if arg2 == "hideBoosts" then
			Boosts_upvr.Visible = not arg3
		end
	end
end
function any_new_result1.setupFrames(arg1) -- Line 78
	--[[ Upvalues[5]:
		[1]: var13_upvw (read and write)
		[2]: Settings_upvr_2 (readonly)
		[3]: var12_upvw (read and write)
		[4]: var10_upvw (read and write)
		[5]: var9_upvw (read and write)
	]]
	for i_upvr, _ in var13_upvw do
		local SOME_2 = Settings_upvr_2:FindFirstChild(var12_upvw.toPascal(i_upvr))
		if SOME_2 then
			var10_upvw.new(SOME_2.Main.State):buttonUp(function() -- Line 88
				--[[ Upvalues[3]:
					[1]: var9_upvw (copied, read and write)
					[2]: i_upvr (readonly)
					[3]: arg1 (readonly)
				]]
				local any_changeSetting_result1, any_changeSetting_result2 = var9_upvw:changeSetting(i_upvr)
				if any_changeSetting_result1 == "success" then
					arg1:settingChanged(i_upvr, any_changeSetting_result2)
				end
			end)
		end
	end
end
function any_new_result1.updateSettings(arg1) -- Line 97
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var13_upvw (read and write)
		[3]: Settings_upvr_2 (readonly)
		[4]: var12_upvw (read and write)
		[5]: var11_upvw (read and write)
	]]
	for i_2, v_2 in var13_upvw do
		local SOME_3 = Settings_upvr_2:FindFirstChild(var12_upvw.toPascal(i_2))
		if SOME_3 then
			local Main = SOME_3.Main
			local any_getSetting_result1 = var11_upvw.settingUtils.getSetting(var4_upvw:getData(), i_2)
			if typeof(v_2) == "boolean" then
				Main.State.ON.Visible = any_getSetting_result1
				Main.State.OFF.Visible = not any_getSetting_result1
			else
				local var40 = v_2[any_getSetting_result1]
				local children = Main.State:GetChildren()
				for _, v_3 in children do
					if v_3:IsA("Frame") then
						v_3.Visible = false
					end
				end
				local var44 = false
				if typeof(var40) == "boolean" then
					var44 = not var40
				end
				Main.State.Disabled.Visible = var44
				if not var44 and var40 and typeof(var40) == "table" and var40.display then
					Main.State[var40.display].Visible = true
				end
			end
		end
	end
end
local Stats_upvr_2 = List_upvr:WaitForChild("Stats")
function any_new_result1.updateStats(arg1) -- Line 131
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: var14_upvw (read and write)
		[4]: Stats_upvr_2 (readonly)
		[5]: var12_upvw (read and write)
	]]
	if not var5_upvw:isFrameOpen() then
	else
		for var46, var47 in var14_upvw do
			local SOME = Stats_upvr_2:FindFirstChild(var12_upvw.toPascal(var46))
			if SOME then
				SOME.Main.Amount.Text = var47(var4_upvw:getData())
			end
		end
	end
end
local Multipliers_upvr = List_upvr:WaitForChild("Multipliers")
function any_new_result1.updateMultipliers(arg1) -- Line 150
	--[[ Upvalues[4]:
		[1]: var4_upvw (read and write)
		[2]: var15_upvw (read and write)
		[3]: Multipliers_upvr (readonly)
		[4]: var12_upvw (read and write)
	]]
	for i_4, v_4 in var15_upvw do
		local SOME_4 = Multipliers_upvr:FindFirstChild(var12_upvw.toPascal(i_4))
		if SOME_4 then
			SOME_4.Main.Amount.Text = v_4(var4_upvw:getData())
		end
	end
end
function any_new_result1.openCategory(arg1, arg2) -- Line 165
	--[[ Upvalues[4]:
		[1]: List_upvr (readonly)
		[2]: var12_upvw (read and write)
		[3]: var16_upvw (read and write)
		[4]: SettingsFrame_upvr (readonly)
	]]
	for _, v_5 in List_upvr:GetChildren() do
		if v_5:IsA("ScrollingFrame") then
			v_5.Visible = false
		end
	end
	List_upvr[var12_upvw.toPascal(arg2)].Visible = true
	local var58 = var16_upvw[arg2]
	SettingsFrame_upvr.TagIcon.Image = var58.icon
	SettingsFrame_upvr.TagIcon.Shadow.Image = var58.icon
	SettingsFrame_upvr.TagLabel.Text = var58.name
end
local Settings_upvr = List:WaitForChild("Settings")
local Stats_upvr = List:WaitForChild("Stats")
local Multipliers_upvr_2 = List:WaitForChild("Multipliers")
function any_new_result1.buttons(arg1) -- Line 179
	--[[ Upvalues[5]:
		[1]: var10_upvw (read and write)
		[2]: Settings_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: Stats_upvr (readonly)
		[5]: Multipliers_upvr_2 (readonly)
	]]
	var10_upvw.new(Settings_upvr):buttonUp(function() -- Line 180
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openCategory("settings")
		arg1:updateSettings()
	end)
	var5_upvw:createTooltipOnHover(Settings_upvr, "Settings")
	var10_upvw.new(Stats_upvr):buttonUp(function() -- Line 186
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openCategory("stats")
		arg1:updateStats()
	end)
	var5_upvw:createTooltipOnHover(Stats_upvr, "Stats")
	var10_upvw.new(Multipliers_upvr_2):buttonUp(function() -- Line 192
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:openCategory("multipliers")
		arg1:updateMultipliers()
	end)
	var5_upvw:createTooltipOnHover(Multipliers_upvr_2, "Multipliers")
end
function any_new_result1.opened(arg1) -- Line 199
	arg1:updateSettings()
	arg1:updateStats()
	arg1:updateMultipliers()
end
function any_new_result1.valuesChanged(arg1) -- Line 205
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"settings"}, function(arg1_2) -- Line 206
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateSettings()
	end)
	var4_upvw.replica:OnSet({"stats"}, function(arg1_3) -- Line 209
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:updateStats()
	end)
end
function any_new_result1.Start(arg1) -- Line 214
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:buttons()
	arg1:setupFrames()
	arg1:valuesChanged()
	arg1:opened()
	var5_upvw:listenToOpen("SettingsFrame"):Connect(function() -- Line 221
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 226
	--[[ Upvalues[15]:
		[1]: var9_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var7_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: var10_upvw (read and write)
		[9]: var11_upvw (read and write)
		[10]: ReplicatedStorage_upvr (readonly)
		[11]: var12_upvw (read and write)
		[12]: var13_upvw (read and write)
		[13]: var14_upvw (read and write)
		[14]: var15_upvw (read and write)
		[15]: var16_upvw (read and write)
	]]
	var9_upvw = Knit_upvr.GetService("SettingsService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var7_upvw = Knit_upvr.GetController("AuraController")
	var8_upvw = Knit_upvr.GetController("PetController")
	var10_upvw = require(Knit_upvr.Modules.Button)
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.Settings)
	var14_upvw = require(script.Stats)
	var15_upvw = require(script.Multipliers)
	var16_upvw = require(script.Categories)
end
return any_new_result1