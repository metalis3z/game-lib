-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:22:34
-- Luau version 6, Types version 3
-- Time taken: 0.001913 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_new_result1 = require(Knit_upvr.Util.Component).new({
	Tag = "TradingPlazaPortalFrame";
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local TradingPlazaPortalFrame_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("Menus"):WaitForChild("TradingPlazaPortalFrame")
function any_new_result1.buttons(arg1) -- Line 35
	--[[ Upvalues[6]:
		[1]: var8_upvw (read and write)
		[2]: TradingPlazaPortalFrame_upvr (readonly)
		[3]: var5_upvw (read and write)
		[4]: var4_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var6_upvw (read and write)
	]]
	var8_upvw.new(TradingPlazaPortalFrame_upvr.Button):buttonUp(function() -- Line 36
		--[[ Upvalues[4]:
			[1]: var5_upvw (copied, read and write)
			[2]: var4_upvw (copied, read and write)
			[3]: var7_upvw (copied, read and write)
			[4]: var6_upvw (copied, read and write)
		]]
		local data = var4_upvw:getData()
		if not data.unlockedTradingPlaza then
			-- Purchase first, then transition on success
			if var7_upvw:buyTradingPlaza() == "success" then
				var6_upvw:play("Upgrade")
				var5_upvw:closeAllFrames()
				var5_upvw:transitionIn()
				task.delay(10, function()
					var5_upvw:transitionOut()
				end)
			end
		else
			-- Already unlocked — just teleport
			var5_upvw:closeAllFrames()
			var5_upvw:transitionIn()
			task.delay(10, function()
				var5_upvw:transitionOut()
			end)
		end
	end)
end
function any_new_result1.update(arg1) -- Line 57
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: TradingPlazaPortalFrame_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	local var13
	if _G.isTradingPlaza and any_getData_result1.unlockedTradingPlaza then
		var13 = "Do you want to teleport to the Normal Game?"
	elseif any_getData_result1.unlockedTradingPlaza then
		var13 = "Do you want to teleport to the Trading Plaza?"
	else
		var13 = "Do you want to purchase access to the Trading Plaza?"
	end
	TradingPlazaPortalFrame_upvr.Message.Text = var13
	TradingPlazaPortalFrame_upvr.Button.Buy.Visible = not any_getData_result1.unlockedTradingPlaza
	TradingPlazaPortalFrame_upvr.Button.Teleport.Visible = any_getData_result1.unlockedTradingPlaza
end
function any_new_result1.onSet(arg1) -- Line 75
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"unlockedTradingPlaza"}, function() -- Line 76
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_new_result1.opened(arg1) -- Line 81
	arg1:update()
end
function any_new_result1.Start(arg1) -- Line 85
	--[[ Upvalues[1]:
		[1]: var5_upvw (read and write)
	]]
	arg1:onSet()
	arg1:buttons()
	arg1:opened()
	var5_upvw:listenToOpen("TradingPlazaPortalFrame"):Connect(function() -- Line 90
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:opened()
	end)
end
local var17_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
function any_new_result1.Construct(arg1) -- Line 95
	--[[ Upvalues[8]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: var17_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
	]]
	var7_upvw = Knit_upvr.GetService("TradingPlazaService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("SoundController")
	var8_upvw = require(Knit_upvr.Modules.Button)
	var17_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_new_result1