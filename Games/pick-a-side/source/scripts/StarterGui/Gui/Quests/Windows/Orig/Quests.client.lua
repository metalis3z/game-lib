-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:45:44
-- Luau version 6, Types version 3
-- Time taken: 0.006247 seconds

while not _G.ClientDataReady do
	wait()
end
local CLIENT_DATA_upvr = _G.CLIENT_DATA
local Topbar_upvr = game.Players.LocalPlayer.PlayerGui:WaitForChild("Topbar")
local List_upvr = script.Parent.List
local Parent_upvr = script.Parent
Parent_upvr.Visible = true
local Quests_upvr = require(game.ReplicatedStorage.Settings.Quests)
local function UpdateList() -- Line 29
	--[[ Upvalues[4]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: List_upvr (readonly)
		[3]: Quests_upvr (readonly)
		[4]: Topbar_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	local var9
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [26] 20. Error Block 40 start (CF ANALYSIS FAILED)
	var9 = true
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [27.9]
	nil.Visible = var9
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [29.6]
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [31.5]
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [31.8]
	if nil >= nil then
		var9 = false
	else
		var9 = true
	end
	nil.Progress.Visible = var9
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	var9 = nil.Progress
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	var9 = nil.." / "..nil
	var9.Title.Text = var9
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	var9 = nil.Progress
	var9 = UDim2.new
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	var9 = var9(nil / nil, 0, 1, 0)
	var9.Bar.Size = var9
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [63.7]
	var9 = '$'..nil[2]
	nil.Reward.Text = var9
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [67.4]
	if nil == "Login" then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
		nil.Title.Text = nil
	else
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		if nil == "Win" then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x3)
			var9 = nil..' '..nil.." times"
			nil.Title.Text = var9
		else
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if nil == "Deal" then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x3)
				var9 = nil..' '..nil.." damage"
				nil.Title.Text = var9
			end
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	var9 = nil.Claim
	if var9.Visible then
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		if nil ~= "Login" then
			var9 = Topbar_upvr.Holder.Quests
			var9 = true
			var9.Notification.Visible = var9
		end
	end
	-- KONSTANTERROR: [26] 20. Error Block 40 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [8] 7. Error Block 36 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	if nil >= nil then
	else
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x2)
	if nil ~= nil then
		-- KONSTANTWARNING: GOTO [27] #21
	end
	-- KONSTANTERROR: [8] 7. Error Block 36 end (CF ANALYSIS FAILED)
end
task.defer(UpdateList)
CLIENT_DATA_upvr.change.Event:connect(UpdateList)
Parent_upvr:GetPropertyChangedSignal("Visible"):Connect(function() -- Line 58
	--[[ Upvalues[2]:
		[1]: Parent_upvr (readonly)
		[2]: Topbar_upvr (readonly)
	]]
	if not Parent_upvr.Visible then
	else
		Topbar_upvr.Holder.Quests.Notification.Visible = false
	end
end)
for _, v in List_upvr:GetChildren() do
	if v:IsA("GuiObject") then
		local Signals_upvr = game.ReplicatedStorage.Signals
		local Name_upvr = v.Name
		v.Claim.Activated:Connect(function() -- Line 72
			--[[ Upvalues[2]:
				[1]: Signals_upvr (readonly)
				[2]: Name_upvr (readonly)
			]]
			Signals_upvr.CompleteQuest:FireServer(Name_upvr)
		end)
	end
end
local Description_upvr = script.Parent.Description
local function UpdateReset() -- Line 79
	--[[ Upvalues[2]:
		[1]: CLIENT_DATA_upvr (readonly)
		[2]: Description_upvr (readonly)
	]]
	local var18 = (86400) - (os.time() - CLIENT_DATA_upvr.data.daily)
	while 0 < var18 do
		local var19 = var18 - 1
		Description_upvr.Text = string.format("%02d:%02d:%02d", math.floor(var19 / 3600), math.floor(var19 % 3600 / 60), var19 % 60)
		task.wait(1)
	end
end
task.defer(UpdateReset)
CLIENT_DATA_upvr.change.Event:connect(UpdateReset)