-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:15
-- Luau version 6, Types version 3
-- Time taken: 0.004826 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "MountController";
	_playerMounts = {};
})
local var4_upvw
local var5_upvw
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local var10_upvw
local Mounts_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("MainUI"):WaitForChild("HUD"):WaitForChild("Bars"):WaitForChild("Bottom"):WaitForChild("Mounts")
function any_CreateController_result1.spawnMount(arg1, arg2, arg3) -- Line 43
	--[[ Upvalues[2]:
		[1]: var8_upvw (read and write)
		[2]: var9_upvw (read and write)
	]]
	if arg1._playerMounts[arg2] then
	else
		local any_new_result1 = var9_upvw.new()
		any_new_result1:setOwner(arg2)
		any_new_result1:setItem(var8_upvw.itemUtils.createItemFromData(arg3))
		any_new_result1:setup()
		any_new_result1:run()
		arg1._playerMounts[arg2] = any_new_result1
	end
end
function any_CreateController_result1.despawnMount(arg1, arg2) -- Line 61
	local var13 = arg1._playerMounts[arg2]
	if var13 then
		var13:remove()
	end
	arg1._playerMounts[arg2] = nil
end
function any_CreateController_result1.toggleMount(arg1) -- Line 70
	--[[ Upvalues[5]:
		[1]: var4_upvw (read and write)
		[2]: var8_upvw (read and write)
		[3]: var5_upvw (read and write)
		[4]: Mounts_upvr (readonly)
		[5]: var7_upvw (read and write)
	]]
	local any_getData_result1_2 = var4_upvw:getData()
	if any_getData_result1_2.tutorialStage <= 9 then
	else
		if not var8_upvw.itemUtils.getItemFromId(any_getData_result1_2, any_getData_result1_2.equippedMount) then
			var5_upvw:createNotification("Default", "You don't have a mount equipped!", 1.5)
			return
		end
		var5_upvw.fx.wiggle(Mounts_upvr.Icon, {
			timeIn = 0.1;
			timeOut = 0.5;
		})
		var7_upvw:toggleMount()
	end
end
function any_CreateController_result1.hideMounts(arg1, arg2) -- Line 91
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	for _, v in arg1._playerMounts do
		for _, v_2 in v:getModel():GetDescendants() do
		local isSurface = v_2:IsA("BasePart") or v_2:IsA("Texture") or v_2:IsA("Decal")
			if isSurface then
				if arg2 then
					if not v_2:GetAttribute("transparency") then
						v_2:SetAttribute("transparency", v_2.Transparency)
					end
				end
				local targetTransp
				if arg2 then
					targetTransp = 1
				else
					targetTransp = v_2:GetAttribute("transparency") or v_2.Transparency
				end
				v_2.Transparency = targetTransp
			else
				if v_2:IsA("BillboardGui") or v_2:IsA("Trail") or v_2:IsA("ParticleEmitter") then
					v_2.Enabled = not arg2
				end
			end
		end
	end
end
local UserInputService_upvr = game:GetService("UserInputService")
function any_CreateController_result1.equipBind(arg1) -- Line 109
	--[[ Upvalues[3]:
		[1]: UserInputService_upvr (readonly)
		[2]: var10_upvw (read and write)
		[3]: var6_upvw (read and write)
	]]
	UserInputService_upvr.InputBegan:Connect(function(arg1_2, arg2) -- Line 110
		--[[ Upvalues[3]:
			[1]: var10_upvw (copied, read and write)
			[2]: var6_upvw (copied, read and write)
			[3]: arg1 (readonly)
		]]
		if arg2 then
		else
			if var6_upvw:getCurrentEgg() ~= "" and var10_upvw.Current == "Gamepad" then return end
			local KeyCode = arg1_2.KeyCode
			if KeyCode ~= Enum.KeyCode.Q and KeyCode ~= Enum.KeyCode.ButtonR1 then return end
			arg1:toggleMount()
		end
	end)
end
function any_CreateController_result1.update(arg1) -- Line 129
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: Mounts_upvr (readonly)
	]]
	local any_getData_result1 = var4_upvw:getData()
	Mounts_upvr.State.ON.Visible = any_getData_result1.isMountEquipped
	Mounts_upvr.State.OFF.Visible = not any_getData_result1.isMountEquipped
end
function any_CreateController_result1.onSet(arg1) -- Line 136
	--[[ Upvalues[1]:
		[1]: var4_upvw (read and write)
	]]
	var4_upvw.replica:OnSet({"isMountEquipped"}, function() -- Line 137
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:update()
	end)
end
function any_CreateController_result1.KnitStart(arg1) -- Line 142
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var7_upvw (read and write)
	]]
	task.spawn(function() -- Line 143
		--[[ Upvalues[3]:
			[1]: var4_upvw (copied, read and write)
			[2]: arg1 (readonly)
			[3]: var7_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
		arg1:equipBind()
		arg1:onSet()
		arg1:update()
		var7_upvw.spawnMount:Connect(function(...) -- Line 151
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:spawnMount(...)
		end)
		var7_upvw.despawnMount:Connect(function(...) -- Line 154
			--[[ Upvalues[1]:
				[1]: arg1 (copied, readonly)
			]]
			arg1:despawnMount(...)
		end)
	end)
end
local var68_upvw
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var70_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 160
	--[[ Upvalues[11]:
		[1]: var7_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var68_upvw (read and write)
		[5]: var5_upvw (read and write)
		[6]: var6_upvw (read and write)
		[7]: var8_upvw (read and write)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: var70_upvw (read and write)
		[10]: var9_upvw (read and write)
		[11]: var10_upvw (read and write)
	]]
	var7_upvw = Knit_upvr.GetService("MountService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var68_upvw = Knit_upvr.GetController("SoundController")
	var5_upvw = Knit_upvr.GetController("UIController")
	var6_upvw = Knit_upvr.GetController("EggController")
	var8_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var70_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
	var9_upvw = require(script.PlayerMount)
	var10_upvw = require(ReplicatedStorage_upvr.Packages.Input).PreferredInput
end
return any_CreateController_result1