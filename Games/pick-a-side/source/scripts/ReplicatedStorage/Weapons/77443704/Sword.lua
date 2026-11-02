-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:27
-- Luau version 6, Types version 3
-- Time taken: 0.015609 seconds

local Parent_upvr = script.Parent
local Handle_upvr = Parent_upvr.Handle
local Configurations_upvr = Parent_upvr:WaitForChild("Configurations")
local module_upvr = {
	DoubleClickMaxTime = 0.2;
	State = "Idle";
	SlashingStartedAt = 0;
	AttackTicket = 0;
}
local GLib_upvr = require(game:GetService("ReplicatedStorage").GLib)
local Debris_upvr = game:GetService("Debris")
function module_upvr.Force(arg1, arg2, arg3) -- Line 24
	--[[ Upvalues[2]:
		[1]: GLib_upvr (readonly)
		[2]: Debris_upvr (readonly)
	]]
	if not GLib_upvr.IsProtected(arg3) and not arg3:FindFirstChild("HitByWind") then
		local tbl = {
			Name = "Windforce_WindEffect";
			maxForce = Vector3.new(1000000, 1000000, 1000000);
			P = 125;
			velocity = arg2 * 60 + Vector3.new(0, 30, 0);
		}
		tbl.Parent = arg3
		Debris_upvr:AddItem(GLib_upvr.Create("BodyVelocity")(tbl), 0.25)
		local Folder = Instance.new("Folder")
		Folder.Name = "HitByWind"
		Folder.Parent = arg3.Parent
		Debris_upvr:AddItem(Folder, 4)
	end
end
function module_upvr.ForceCharacter(arg1, arg2) -- Line 41
	--[[ Upvalues[3]:
		[1]: GLib_upvr (readonly)
		[2]: Parent_upvr (readonly)
		[3]: module_upvr (readonly)
	]]
	local var15
	if GLib_upvr.GetCharacter(arg2) then
		var15 = GLib_upvr.GetCharacter(arg2):FindFirstChild("HumanoidRootPart")
		if not var15 then
			var15 = GLib_upvr.GetCharacter(arg2):FindFirstChild("Torso")
		end
		if var15 then
			if var15:IsA("BasePart") then
				local var17
				if GLib_upvr.GetCharacter(Parent_upvr) then
					var17 = GLib_upvr.GetCharacter(Parent_upvr):FindFirstChild("HumanoidRootPart")
					if not var17 then
						var17 = GLib_upvr.GetCharacter(Parent_upvr):FindFirstChild("Torso")
					end
					if var17 and var17:IsA("BasePart") and var17.Position ~= var15.Position then
						module_upvr:Force((var15.Position - var17.Position).unit, var15)
					end
				end
			end
		end
	end
end
function IsTeamMate(arg1, arg2) -- Line 63
	local var21 = arg1
	if var21 then
		var21 = arg2
		if var21 then
			var21 = arg1.Neutral
			if not var21 then
				var21 = arg2.Neutral
				if not var21 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var21 = false
					else
						var21 = true
					end
				end
			end
		end
	end
	return var21
end
local var22_upvw = false
function module_upvr.Connect(arg1) -- Line 69
	--[[ Upvalues[6]:
		[1]: Handle_upvr (readonly)
		[2]: var22_upvw (read and write)
		[3]: GLib_upvr (readonly)
		[4]: Parent_upvr (readonly)
		[5]: Configurations_upvr (readonly)
		[6]: module_upvr (readonly)
	]]
	Handle_upvr.Touched:connect(function(arg1_2) -- Line 70
		--[[ Upvalues[6]:
			[1]: Handle_upvr (copied, readonly)
			[2]: var22_upvw (copied, read and write)
			[3]: GLib_upvr (copied, readonly)
			[4]: Parent_upvr (copied, readonly)
			[5]: Configurations_upvr (copied, readonly)
			[6]: module_upvr (copied, readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		if 10 < (Handle_upvr.Position - arg1_2.Position).Magnitude then
		else
			if var22_upvw then return end
			local any_GetPlayerFromPart_result1_2 = GLib_upvr.GetPlayerFromPart(Parent_upvr)
			local any_GetCharacterFromPart_result1_3, any_GetCharacterFromPart_result2, any_GetCharacterFromPart_result3 = GLib_upvr.GetCharacterFromPart(arg1_2)
			if any_GetPlayerFromPart_result1_2 ~= nil and any_GetCharacterFromPart_result1_3 ~= nil then
				local var35
				if any_GetCharacterFromPart_result3 ~= nil and any_GetPlayerFromPart_result1_2 ~= any_GetCharacterFromPart_result2 then
					local Character_2 = any_GetPlayerFromPart_result1_2.Character
					var35 = Character_2
					if var35 then
						var35 = Character_2:FindFirstChild("Humanoid")
					end
					local function INLINED_2() -- Internal function, doesn't exist in bytecode
						local var37
						return 0 < var37
					end
					if not IsTeamMate(any_GetPlayerFromPart_result1_2, any_GetCharacterFromPart_result2) and var35 and var35:IsA("Humanoid") and INLINED_2() and (Configurations_upvr.CanKillWithForceField.Value or Character_2:FindFirstChild("ForceField") == nil) then
						if module_upvr.State == "Slashing" then
						elseif module_upvr.State == "Lunging" then
						end
						GLib_upvr.TagHumanoid(any_GetCharacterFromPart_result3, any_GetPlayerFromPart_result1_2, 1)
						var22_upvw = true
						any_GetCharacterFromPart_result3:TakeDamage(Configurations_upvr.LungeDamage.Value)
						module_upvr:ForceCharacter(any_GetCharacterFromPart_result3)
						wait(0.5)
						var22_upvw = false
					end
				end
			end
		end
	end)
end
function module_upvr.Attack(arg1) -- Line 103
	--[[ Upvalues[4]:
		[1]: GLib_upvr (readonly)
		[2]: Parent_upvr (readonly)
		[3]: Configurations_upvr (readonly)
		[4]: module_upvr (readonly)
	]]
	local any_GetCharacterFromPart_result1, any_GetCharacterFromPart_result2_3, any_GetCharacterFromPart_result3_3 = GLib_upvr.GetCharacterFromPart(Parent_upvr)
	if any_GetCharacterFromPart_result3_3 ~= nil and 0 < any_GetCharacterFromPart_result3_3.Health and (Configurations_upvr.CanKillWithForceField.Value or any_GetCharacterFromPart_result1:FindFirstChild("ForceField") == nil) then
		local tick_result1 = tick()
		if module_upvr.State == "Slashing" then
			if tick_result1 - module_upvr.SlashingStartedAt < module_upvr.DoubleClickMaxTime then
				module_upvr.AttackTicket += 1
				module_upvr:Lunge(module_upvr.AttackTicket)
				return
			end
		end
		if module_upvr.State == "Idle" then
			module_upvr.AttackTicket += 1
			module_upvr.SlashingStartedAt = tick_result1
			module_upvr:Slash(module_upvr.AttackTicket)
		end
	end
end
function module_upvr.Slash(arg1, arg2) -- Line 124
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Handle_upvr (readonly)
	]]
	module_upvr.State = "Slashing"
	Handle_upvr.SlashSound:Play()
	module_upvr:Animate("Slash")
	wait(0.5)
	if module_upvr.AttackTicket == arg2 then
		module_upvr.State = "Idle"
	end
end
function module_upvr.Lunge(arg1, arg2) -- Line 137
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: Handle_upvr (readonly)
		[3]: Parent_upvr (readonly)
	]]
	module_upvr.State = "Lunging"
	Handle_upvr.LungeSound:Play()
	module_upvr:Animate("Lunge")
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.velocity = Vector3.new(0, 10, 0)
	BodyVelocity.maxForce = Vector3.new(0, 4000, 0)
	BodyVelocity.Parent = Parent_upvr.Parent.Torso
	wait(0.25)
	Parent_upvr.Grip = CFrame.new(0, 0, -1.5, 0, -1, -0, -1, 0, -0, 0, 0, -1)
	wait(0.25)
	BodyVelocity:Destroy()
	wait(0.5)
	Parent_upvr.Grip = CFrame.new(0, 0, -1.5, 0, 0, 1, 1, 0, 0, 0, 1, 0)
	module_upvr.State = "Idle"
end
function module_upvr.Animate(arg1, arg2) -- Line 158
	--[[ Upvalues[1]:
		[1]: Parent_upvr (readonly)
	]]
	local StringValue = Instance.new("StringValue")
	StringValue.Name = "toolanim"
	StringValue.Value = arg2
	StringValue.Parent = Parent_upvr
end
function module_upvr.Initialize(arg1) -- Line 166
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	module_upvr:Connect()
end
return module_upvr