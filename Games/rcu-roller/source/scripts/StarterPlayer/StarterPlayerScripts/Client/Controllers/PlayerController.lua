-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiler will be improved VERY SOON!
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/wyButjTMhM)
-- Decompiled on 2025-03-27 06:20:06
-- Luau version 6, Types version 3
-- Time taken: 0.005661 seconds

local Knit_upvr = require(game:GetService("ReplicatedStorage").Packages.Knit)
local any_CreateController_result1 = Knit_upvr.CreateController({
	Name = "PlayerController";
})
local var4_upvw
local var5_upvw
local var6_upvw
local Players_upvr = game:GetService("Players")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local var9_upvw
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local RunService_upvr = game:GetService("RunService")
local TeleportService_upvr = game:GetService("TeleportService")
function any_CreateController_result1.idled(arg1) -- Line 37
	--[[ Upvalues[4]:
		[1]: RunService_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var6_upvw (read and write)
		[4]: TeleportService_upvr (readonly)
	]]
	if RunService_upvr:IsStudio() then
	else
		LocalPlayer_upvr.Idled:Connect(function(arg1_2) -- Line 41
			--[[ Upvalues[3]:
				[1]: var6_upvw (copied, read and write)
				[2]: TeleportService_upvr (copied, readonly)
				[3]: LocalPlayer_upvr (copied, readonly)
			]]
			if 1050 <= arg1_2 then
				var6_upvw:setIsAutoReconnecting()
				TeleportService_upvr:Teleport(game.PlaceId, LocalPlayer_upvr)
			end
		end)
	end
end
function any_CreateController_result1.hideCharacters(arg1, arg2, arg3) -- Line 49
	--[[ Upvalues[2]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	for _, v in Players_upvr:GetPlayers() do
		local Character = v.Character
		if (v ~= LocalPlayer_upvr or arg3) and Character then
			for _, v_2 in Character:GetDescendants() do
				local isBasePart = v_2:IsA("BasePart") or v_2:IsA("Decal")
				if isBasePart then
					if arg2 then
						if not v_2:GetAttribute("transparency") then
							v_2:SetAttribute("transparency", v_2.Transparency)
						end
					end
					v_2.Transparency = arg2 and 1 or (v_2:GetAttribute("transparency") or 0)
				else
					if v_2:IsA("BillboardGui") then
						v_2.Enabled = not arg2
					end
				end
			end
		end
	end
end
local Assets_upvr = ReplicatedStorage_upvr.Assets
local TweenService_upvr = game:GetService("TweenService")
local Debris_upvr = game:GetService("Debris")
function any_CreateController_result1.launchFireworks(arg1, arg2, arg3, arg4) -- Line 76
	--[[ Upvalues[5]:
		[1]: var9_upvw (read and write)
		[2]: var5_upvw (read and write)
		[3]: Assets_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: Debris_upvr (readonly)
	]]
	local any_getHRP_result1 = var9_upvw.getHRP(arg2)
	if not any_getHRP_result1 then
	else
		var5_upvw:preloadSounds({"Firework Whistle", "Firework Launch", "Firework Explosion"})
		for _ = 1, arg4 or 1 do
			var5_upvw:play("Firework Whistle", {
				parent = any_getHRP_result1;
				playbackSpeed = Random.new():NextNumber(0.9, 1.15);
				rollOffMaxDistance = 125;
				rollOffMinDistance = 1;
				rollOffMode = Enum.RollOffMode.Linear;
				volume = 0.04;
			})
			for _ = 1, arg3 do
				local Part_upvr = Instance.new("Part", workspace.Debris)
				Part_upvr.Transparency = 1
				Part_upvr.Anchored = true
				Part_upvr.CanCollide = false
				Part_upvr.Position = any_getHRP_result1.Position
				local clone = Assets_upvr.VFX.FireworkTrail:Clone()
				clone.Parent = Part_upvr
				local Attachment_2 = Instance.new("Attachment", Part_upvr)
				Attachment_2.Position = Vector3.new(0, 0.5, 0)
				local Attachment = Instance.new("Attachment", Part_upvr)
				Attachment.Position = Vector3.new(0, -0.5, 0)
				clone.Attachment0 = Attachment_2
				clone.Attachment1 = Attachment
				local clone_upvr = Assets_upvr.VFX.FireworkParticleEmitter:Clone()
				clone_upvr.Parent = Part_upvr
				local tbl = {Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(48, 118, 251), Color3.fromRGB(255, 255, 0), Color3.fromRGB(245, 182, 5), Color3.fromRGB(241, 76, 252), Color3.fromRGB(0, 255, 255)}
				clone_upvr.Color = ColorSequence.new(tbl[math.random(1, #tbl)])
				var5_upvw:play("Firework Launch", {
					parent = Part_upvr;
					volume = 0.05;
					rollOffMaxDistance = 125;
					rollOffMinDistance = 1;
					rollOffMode = Enum.RollOffMode.Linear;
				})
				local any_Create_result1 = TweenService_upvr:Create(Part_upvr, TweenInfo.new(Random.new():NextNumber(0.5, 0.8), Enum.EasingStyle.Cubic), {
					Position = any_getHRP_result1.Position + Vector3.new(math.random(-4, 4), math.random(9, 20), math.random(-4, 4));
				})
				any_Create_result1:Play()
				any_Create_result1.Completed:Connect(function() -- Line 156
					--[[ Upvalues[4]:
						[1]: clone_upvr (readonly)
						[2]: var5_upvw (copied, read and write)
						[3]: Part_upvr (readonly)
						[4]: Debris_upvr (copied, readonly)
					]]
					clone_upvr:Emit(200)
					var5_upvw:play("Firework Explosion", {
						parent = Part_upvr;
						playbackSpeed = Random.new():NextNumber(0.95, 1.1);
						volume = 0.45;
						rollOffMaxDistance = 125;
						rollOffMinDistance = 1;
						rollOffMode = Enum.RollOffMode.Linear;
					})
					Debris_upvr:AddItem(Part_upvr, 5)
				end)
				task.wait(Random.new():NextNumber(0.125, 0.15))
			end
			Part_upvr = 0.85
			task.wait(Random.new():NextNumber(Part_upvr, 1))
		end
	end
end
function any_CreateController_result1.KnitStart(arg1) -- Line 176
	--[[ Upvalues[2]:
		[1]: var4_upvw (read and write)
		[2]: var6_upvw (read and write)
	]]
	arg1:idled()
	task.spawn(function() -- Line 178
		--[[ Upvalues[1]:
			[1]: var4_upvw (copied, read and write)
		]]
		var4_upvw:waitForData()
	end)
	var6_upvw.launchFireworks:Connect(function(...) -- Line 182
		--[[ Upvalues[1]:
			[1]: arg1 (readonly)
		]]
		arg1:launchFireworks(...)
	end)
end
local var87_upvw
local var88_upvw
function any_CreateController_result1.KnitInit(arg1) -- Line 187
	--[[ Upvalues[8]:
		[1]: var6_upvw (read and write)
		[2]: Knit_upvr (readonly)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var87_upvw (read and write)
		[6]: var88_upvw (read and write)
		[7]: ReplicatedStorage_upvr (readonly)
		[8]: var9_upvw (read and write)
	]]
	var6_upvw = Knit_upvr.GetService("PlayerService")
	var4_upvw = Knit_upvr.GetController("DataController")
	var5_upvw = Knit_upvr.GetController("SoundController")
	var87_upvw = Knit_upvr.GetController("UIController")
	var88_upvw = require(ReplicatedStorage_upvr.Shared.Util)
	var9_upvw = require(ReplicatedStorage_upvr.Shared.Functions)
end
return any_CreateController_result1