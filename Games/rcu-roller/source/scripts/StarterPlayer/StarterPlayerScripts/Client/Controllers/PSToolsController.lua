-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:19:27
-- Luau version 6, Types version 3
-- Time taken: 0.024117 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "PSToolsController";
	_toolsEnabled = false;
	_showAdminPanel = false;
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local Players_upvr = game:GetService("Players")
local var10_upvw
local var11_upvw
local var12_upvw
local var13_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local tbl_37_upvr = {Enum.KeyCode.F2, Enum.KeyCode.E}
local UserInputService_upvr = game:GetService("UserInputService")
local RunService_upvr = game:GetService("RunService")
function any_CreateController_result1.toggleToolsUI(arg1) -- Line 50
	--[[ Upvalues[5]:
		[1]: UserInputService_upvr (readonly)
		[2]: tbl_37_upvr (readonly)
		[3]: var10_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: RunService_upvr (readonly)
	]]
	UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 51
		--[[ Upvalues[6]:
			[1]: tbl_37_upvr (copied, readonly)
			[2]: UserInputService_upvr (copied, readonly)
			[3]: var10_upvw (copied, read and write)
			[4]: arg1 (readonly)
			[5]: var8_upvw (copied, read and write)
			[6]: RunService_upvr (copied, readonly)
		]]
		if arg2 then return end
		if not table.find(tbl_37_upvr, arg1_2.KeyCode) then return end
		if not LocalPlayer_upvr:GetAttribute("psToolsEnabled") then return end
		if typeof(arg1._toolsEnabled) ~= "table" then
			arg1._toolsEnabled = var10_upvw.State(false)
			arg1._showAdminPanel = var10_upvw.State(false)
			arg1:createToolsUI()
		end
		arg1._toolsEnabled:set(not arg1._toolsEnabled:get())
	end)
end
function any_CreateController_result1.createToolsUI(arg1) -- Line 92
	--[[ Upvalues[11]:
		[1]: var4_upvw (read and write)
		[2]: var10_upvw (read and write)
		[3]: LocalPlayer_upvr (readonly)
		[4]: var11_upvw (read and write)
		[5]: var8_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var12_upvw (read and write)
		[8]: var7_upvw (read and write)
		[9]: var13_upvw (read and write)
		[10]: var5_upvw (read and write)
		[11]: Players_upvr (readonly)
	]]
	local any_State_result1_upvr = var10_upvw.State("")
	var10_upvw:Connect(function() -- Line 103
		--[[ Upvalues[12]:
			[1]: var10_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: LocalPlayer_upvr (copied, readonly)
			[4]: var11_upvw (copied, read and write)
			[5]: var8_upvw (copied, read and write)
			[6]: var6_upvw (copied, read and write)
			[7]: var12_upvw (copied, read and write)
			[8]: var7_upvw (copied, read and write)
			[9]: var13_upvw (copied, read and write)
			[10]: var5_upvw (copied, read and write)
			[11]: Players_upvr (copied, readonly)
			[12]: any_State_result1_upvr (readonly)
		]]
		local _ = {
			[var10_upvw.Args.Window.Title] = "PSTools v1.0.0";
			[var10_upvw.Args.Window.NoClose] = true;
		}
		local _ = {
			isOpened = arg1._toolsEnabled;
		}
		if arg1._toolsEnabled:get() and LocalPlayer_upvr:GetAttribute("psToolsAdmin") then
			var10_upvw.SeparatorText({"Admin"})
			if var10_upvw.Button({"Open Admin Panel"}).clicked() then
				arg1._showAdminPanel:set(true)
			end
		end
		var10_upvw.SeparatorText({"Client"})
		var10_upvw.Text({`Ping: {math.floor(LocalPlayer_upvr:GetNetworkPing() * 1000)}ms`})
		var10_upvw.SeparatorText({"Server"})
		var10_upvw.Text({`Uptime: {var11_upvw.formatTime2(math.floor((DateTime.now().UnixTimestampMillis - arg1._serverCreateTime) / 1000))}`})
		var10_upvw.Text({`Version: {game.PlaceVersion}`})
		var10_upvw.End()
		var10_upvw.Window({
			[var10_upvw.Args.Window.Title] = "PSAdmin";
			[var10_upvw.Args.Window.NoClose] = true;
		}, {
			isOpened = arg1._showAdminPanel;
		})
		var10_upvw.CollapsingHeader({"Game"})
		var10_upvw.SeparatorText({"Moderator"})
		var10_upvw.Tree({"Pets"})
		var10_upvw.Tree({"Give Pet"})
		local any_InputText_result1_3 = var10_upvw.InputText({"Username"})
		if var10_upvw.Button({"Select Self"}).clicked() then
			any_InputText_result1_3.text:set(LocalPlayer_upvr.Name)
		end
		var10_upvw.Separator()
		if var10_upvw.Button({"Give"}).clicked() then
			var8_upvw.call:Fire("givePet", {
				username = any_InputText_result1_3.text.value;
				name = var10_upvw.InputText({"Pet Name"}).text.value;
				tier = var10_upvw.InputNum({
					[var10_upvw.Args.InputNum.Text] = "Pet Tier";
					[var10_upvw.Args.InputNum.Max] = 3;
					[var10_upvw.Args.InputNum.Min] = 1;
				}, {
					number = 1;
				}).number.value;
				shiny = var10_upvw.Checkbox({"Shiny?"}).isChecked.value;
				amount = var10_upvw.InputNum({"Amount"}, {
					number = 1;
				}).number.value;
			})
		end
		var10_upvw.End()
		var10_upvw.End()
		var10_upvw.Tree({"Unlock Trades"})
		local any_InputText_result1_7 = var10_upvw.InputText({"Username"})
		if var10_upvw.Button({"Select Self"}).clicked() then
			any_InputText_result1_7.text:set(LocalPlayer_upvr.Name)
		end
		var10_upvw.Separator()
		if var10_upvw.Button({"Unlock"}).clicked() then
			var8_upvw.call:Fire("unlockTrades", {
				username = any_InputText_result1_7.text.value;
			})
		end
		var10_upvw.End()
		var10_upvw.SeparatorText({"Admin"})
		var10_upvw.Tree({"Data"})
		var10_upvw.Tree({"Edit"})
		local tbl_102 = {"Username"}
		if var10_upvw.Button({"Select Self"}).clicked() then
			var10_upvw.InputText(tbl_102).text:set(LocalPlayer_upvr.Name)
		end
		var10_upvw.Separator()
		local any_InputText_result1 = var10_upvw.InputText({"Data Path"})
		var10_upvw.Separator()
		if any_InputText_result1.hovered() then
			var10_upvw.Tooltip({"Example: stats.totalCoins"})
		end
		if var10_upvw.Button({"Save"}).clicked() then
			local tbl_30 = {}
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			tbl_30.username = var10_upvw.InputText(tbl_102).text.value
			tbl_30.path = any_InputText_result1.text.value
			tbl_30.amount = var10_upvw.InputText({"New Value"}).text.value
			var8_upvw.call:Fire("editData", tbl_30)
		end
		var10_upvw.End()
		var10_upvw.Tree({"Reset"})
		var10_upvw.Tree({"Reset"})
		if var10_upvw.Button({"Reset Data"}).clicked() then
			var8_upvw.call:Fire("resetData")
		end
		var10_upvw.End()
		var10_upvw.End()
		var10_upvw.End()
		var10_upvw.Tree({"Items"})
		var10_upvw.Tree({"Give Item"})
		local any_InputText_result1_2 = var10_upvw.InputText({"Username"})
		if var10_upvw.Button({"Select Self"}).clicked() then
			any_InputText_result1_2.text:set(LocalPlayer_upvr.Name)
		end
		var10_upvw.Separator()
		if var10_upvw.Button({"Give"}).clicked() then
			var8_upvw.call:Fire("giveItem", {
				username = any_InputText_result1_2.text.value;
				class = var10_upvw.InputText({"Class"}).text.value;
				name = var10_upvw.InputText({"Name"}).text.value;
				amount = var10_upvw.InputNum({"Amount"}, {
					number = 1;
				}).number.value;
			})
		end
		var10_upvw.End()
		var10_upvw.End()
		var10_upvw.Tree({"Events"})
		if var10_upvw.Button({"Global Falling Stars Event"}).clicked() then
			var8_upvw.call:Fire("globalFallingStars")
		end
		var10_upvw.End()
		var10_upvw.Tree({"Trading Plaza"})
		if var10_upvw.Button({"Remove booth"}).clicked() then
			var8_upvw.call:Fire("removeBooth")
			for _, v in game:GetService("CollectionService"):GetTagged("Booth") do
				v.Primary.ProximityPrompt.Enabled = true
			end
		end
		var10_upvw.End()
		var10_upvw.Tree({"Cutscenes"})
		if var10_upvw.Button({"Aura Cutscene"}).clicked() then
			task.spawn(function() -- Line 306
				--[[ Upvalues[1]:
					[1]: var6_upvw (copied, read and write)
				]]
				var6_upvw:startAuraCutscene()
			end)
		end
		if var10_upvw.Button({"Eternal Cutscene"}).clicked() then
			task.spawn(function() -- Line 311
				--[[ Upvalues[1]:
					[1]: var12_upvw (copied, read and write)
				]]
				require(script.Parent.HatchingController.Animations).eternal({
					item = var12_upvw.pet("Dragon King");
				})
			end)
		end
		if var10_upvw.Button({"Secret Cutscene"}).clicked() then
			task.spawn(function() -- Line 318
				--[[ Upvalues[1]:
					[1]: var12_upvw (copied, read and write)
				]]
				require(script.Parent.HatchingController.Animations).secret({
					item = var12_upvw.pet("Dragon King");
				})
			end)
		end
		if var10_upvw.Button({"City Cutscene"}).clicked() then
			task.spawn(function() -- Line 325
				--[[ Upvalues[1]:
					[1]: var7_upvw (copied, read and write)
				]]
				var7_upvw:unlockedAnimation()
			end)
		end
		var10_upvw.End()
		var10_upvw.Tree({"FFlags"})
		if var10_upvw.Button({"Update FFlags"}).clicked() then
			var8_upvw.call:Fire("updateFFlags")
		end
		var10_upvw.Table({2})
		for i_2, _ in var13_upvw do
			var10_upvw.Text({i_2})
			var10_upvw.NextRow()
			var10_upvw.Text({`{var5_upvw:getFFlag(i_2)}`})
			var10_upvw.NextColumn()
		end
		var10_upvw.End()
		var10_upvw.End()
		var10_upvw.Separator()
		var10_upvw.End()
		var10_upvw.CollapsingHeader({"Players"})
		var10_upvw.Tree({"Player List"})
		var10_upvw.Table({2})
		for i_3, v_3 in Players_upvr:GetPlayers() do
			var10_upvw.Text({v_3.Name})
			var10_upvw.NextRow()
			local tbl_61 = {"Select"}
			if var10_upvw.Button(tbl_61).clicked() then
				if any_State_result1_upvr:get() == v_3.Name then
					tbl_61 = ""
				else
					tbl_61 = v_3.Name
				end
				any_State_result1_upvr:set(tbl_61)
			end
			var10_upvw.NextColumn()
		end
		var10_upvw.End()
		var10_upvw.End()
		if any_State_result1_upvr:get() ~= "" and Players_upvr:FindFirstChild(any_State_result1_upvr:get()) then
			local tbl_85 = {}
			i_3 = `Selected: {any_State_result1_upvr:get()}`
			tbl_85[1] = i_3
			var10_upvw.SeparatorText(tbl_85)
			var10_upvw.Tree({"Modify"})
			local tbl_13 = {3}
			v_3 = var10_upvw.Args.Table
			i_3 = v_3.RowBg
			v_3 = true
			tbl_13[i_3] = v_3
			v_3 = var10_upvw.Args.Table
			i_3 = v_3.BordersOuter
			v_3 = false
			tbl_13[i_3] = v_3
			v_3 = var10_upvw.Args.Table
			i_3 = v_3.BordersInner
			v_3 = false
			tbl_13[i_3] = v_3
			var10_upvw.Table(tbl_13)
			local tbl_89 = {}
			i_3 = "Kill"
			tbl_89[1] = i_3
			if var10_upvw.Button(tbl_89).clicked() then
				i_3 = {}
				v_3 = any_State_result1_upvr:get()
				i_3.player = v_3
				var8_upvw.call:Fire("kill", i_3)
			end
			var10_upvw.NextColumn()
			local tbl_72 = {}
			i_3 = "Jump"
			tbl_72[1] = i_3
			if var10_upvw.Button(tbl_72).clicked() then
				i_3 = {}
				v_3 = any_State_result1_upvr:get()
				i_3.player = v_3
				var8_upvw.call:Fire("jump", i_3)
			end
			var10_upvw.NextColumn()
			local tbl_71 = {}
			i_3 = "Bring"
			tbl_71[1] = i_3
			if var10_upvw.Button(tbl_71).clicked() then
				i_3 = {}
				v_3 = any_State_result1_upvr:get()
				i_3.player = v_3
				var8_upvw.call:Fire("bring", i_3)
			end
			var10_upvw.NextRow()
			var10_upvw.NextColumn()
			local tbl_27 = {}
			i_3 = "Teleport To"
			tbl_27[1] = i_3
			if var10_upvw.Button(tbl_27).clicked() then
				i_3 = {}
				v_3 = any_State_result1_upvr:get()
				i_3.player = v_3
				var8_upvw.call:Fire("teleportTo", i_3)
			end
			var10_upvw.NextColumn()
			local tbl_4 = {}
			i_3 = "Test 1"
			tbl_4[1] = i_3
			if not var10_upvw.Button(tbl_4).clicked() then
			end
			var10_upvw.NextColumn()
			local tbl_69 = {}
			i_3 = "Test 2"
			tbl_69[1] = i_3
			if not var10_upvw.Button(tbl_69).clicked() then
			end
			var10_upvw.NextRow()
			var10_upvw.NextColumn()
			local tbl_18 = {}
			i_3 = "Test 3"
			tbl_18[1] = i_3
			if not var10_upvw.Button(tbl_18).clicked() then
			end
			var10_upvw.NextColumn()
			local tbl_49 = {}
			i_3 = "Test 4"
			tbl_49[1] = i_3
			if not var10_upvw.Button(tbl_49).clicked() then
			end
			var10_upvw.NextColumn()
			local tbl_68 = {}
			i_3 = "Test 5"
			tbl_68[1] = i_3
			if not var10_upvw.Button(tbl_68).clicked() then
			end
			var10_upvw.End()
			local tbl_15 = {}
			tbl_61 = Players_upvr
			v_3 = tbl_61[any_State_result1_upvr:get()].Character.Humanoid
			i_3 = v_3.WalkSpeed
			tbl_15.number = i_3
			local tbl_67 = {}
			i_3 = "Jump Height"
			tbl_67[1] = i_3
			i_3 = {}
			tbl_61 = Players_upvr[any_State_result1_upvr:get()]
			v_3 = tbl_61.Character.Humanoid.JumpHeight
			i_3.number = v_3
			if var10_upvw.InputNum({"WalkSpeed"}, tbl_15).numberChanged() then
				i_3 = var8_upvw
				v_3 = "walkSpeed"
				local tbl_66 = {
					player = any_State_result1_upvr:get();
				}
				tbl_61 = var10_upvw.InputNum({"WalkSpeed"}, tbl_15).number:get()
				tbl_66.amount = tbl_61 + 1
				i_3.call:Fire(v_3, tbl_66)
			end
			if var10_upvw.InputNum(tbl_67, i_3).numberChanged() then
				i_3 = var8_upvw
				v_3 = "jumpHeight"
				local tbl_2 = {
					player = any_State_result1_upvr:get();
				}
				tbl_61 = var10_upvw.InputNum(tbl_67, i_3).number:get()
				tbl_2.amount = tbl_61 + 1
				i_3.call:Fire(v_3, tbl_2)
			end
			var10_upvw.End()
			var10_upvw.Tree({"Information"})
			i_3 = any_State_result1_upvr:get()
			local HumanoidRootPart_2 = Players_upvr[i_3].Character:FindFirstChild("HumanoidRootPart")
			if HumanoidRootPart_2 then
				local pos = HumanoidRootPart_2.Position
				local posX = var11_upvw.floatingPoint(pos.X, 2)
				local posY = var11_upvw.floatingPoint(pos.Y, 2)
				local posZ = var11_upvw.floatingPoint(pos.Z, 2)
				var10_upvw.Text({`Position: X: {posX}, Y: {posY}, Z: {posZ}`})
			end
			var10_upvw.End()
		end
		var10_upvw.End()
		var10_upvw.End()
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 457
	arg1:toggleToolsUI()
end
local var265_upvw
local var266_upvw
local var267_upvw
local var268_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var270_upvw
local var271_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 462
	--[[ Upvalues[16]:
		[1]: var265_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: Knit_upvr (readonly)
		[4]: var266_upvw (read and write)
		[5]: var4_upvw (read and write)
		[6]: var267_upvw (read and write)
		[7]: var268_upvw (read and write)
		[8]: var5_upvw (read and write)
		[9]: var6_upvw (read and write)
		[10]: var7_upvw (read and write)
		[11]: var11_upvw (read and write)
		[12]: ReplicatedStorage_upvr (readonly)
		[13]: var270_upvw (read and write)
		[14]: var12_upvw (read and write)
		[15]: var271_upvw (read and write)
		[16]: var13_upvw (read and write)
	]]
	var265_upvw = {}
	var8_upvw = Knit_upvr.GetService("PSToolsService")
	var266_upvw = Knit_upvr.GetController("UIController")
	var4_upvw = Knit_upvr.GetController("DataController")
	var267_upvw = Knit_upvr.GetController("HatchingController")
	var268_upvw = Knit_upvr.GetController("ExclusiveEggController")
	var5_upvw = Knit_upvr.GetController("FFlagController")
	var6_upvw = Knit_upvr.GetController("AuraController")
	var7_upvw = Knit_upvr.GetController("CityController")
	var11_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var270_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var12_upvw = require(ReplicatedStorage_upvr.Shared.Items)
	var271_upvw = require(ReplicatedStorage_upvr.Shared.Values)
	var13_upvw = require(ReplicatedStorage_upvr.Shared.List.FFlags)
end
return any_CreateController_result1