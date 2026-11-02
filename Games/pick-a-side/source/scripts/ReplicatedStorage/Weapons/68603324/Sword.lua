-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:42
-- Luau version 6, Types version 3
-- Time taken: 0.019524 seconds

local Parent_2_upvr = script.Parent
local Handle_upvr = Parent_2_upvr.Handle
local Configurations_upvr = Parent_2_upvr:WaitForChild("Configurations")
local module_upvr = {
	DoubleClickMaxTime = 0.2;
	State = "Idle";
	SlashingStartedAt = 0;
	AttackTicket = 0;
	PoisonedCharacters = {};
}
local GLib_upvr = require(game:GetService("ReplicatedStorage").GLib)
function module_upvr.PoisonStep(arg1) -- Line 24
	--[[ Upvalues[4]:
		[1]: GLib_upvr (readonly)
		[2]: Parent_2_upvr (readonly)
		[3]: module_upvr (readonly)
		[4]: Configurations_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [94] 67. Error Block 12 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [94] 67. Error Block 12 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [12] 10. Error Block 21 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [94.7]
	if nil then
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [94.8]
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
		if nil < nil then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if nil then
			else
			end
			-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [94.9]
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			if nil <= nil then
				-- KONSTANTWARNING: GOTO [94] #67
			end
			-- KONSTANTWARNING: GOTO [94] #67
		end
	end
	-- KONSTANTERROR: [12] 10. Error Block 21 end (CF ANALYSIS FAILED)
end
function module_upvr.GetHumanoidIsPoisoned(arg1, arg2) -- Line 63
	local var8
	if arg2:FindFirstChild("Venomshank_Poison") == nil then
		var8 = false
	else
		var8 = true
	end
	return var8
end
function module_upvr.PoisonHumanoid(arg1, arg2) -- Line 67
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: GLib_upvr (readonly)
	]]
	if not module_upvr:GetHumanoidIsPoisoned(arg2) and not GLib_upvr.IsProtected(arg2) then
		local tbl = {
			Character = arg2.Parent;
		}
		tbl.Humanoid = arg2
		tbl.ChangeColorObjects = {}
		tbl.StartedAt = tick()
		for _, v in next, GLib_upvr.GetDescendants(tbl.Character) do
			if v:IsA("BasePart") then
				tbl.ChangeColorObjects[v] = {
					Property = "BrickColor";
					Type = "BrickColor";
					Original = v.BrickColor;
				}
			elseif v:IsA("FileMesh") then
				tbl.ChangeColorObjects[v] = {
					Property = "VertexColor";
					Type = "Vector3";
					Original = v.VertexColor;
				}
			elseif v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Light") then
				tbl.ChangeColorObjects[v] = {
					Property = "Color";
					Type = "Color3";
					Original = v.Color;
				}
			elseif v:IsA("Sparkles") then
				tbl.ChangeColorObjects[v] = {
					Property = "SparkleColor";
					Type = "Colors";
					Original = v.SparkleColor;
				}
			end
		end
		module_upvr.PoisonedCharacters[arg2] = tbl
		local Model = Instance.new("Model")
		Model.Name = "Venomshank_Poison"
		Model.Parent = arg2
	end
end
function module_upvr.CureHumanoid(arg1, arg2) -- Line 112
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	module_upvr.PoisonedCharacters[arg2] = nil
	if module_upvr:GetHumanoidIsPoisoned(arg2) then
		arg2.Venomshank_Poison:Destroy()
	end
end
local var19_upvw = false
local function Connect(arg1) -- Line 121
	--[[ Upvalues[6]:
		[1]: Handle_upvr (readonly)
		[2]: var19_upvw (read and write)
		[3]: GLib_upvr (readonly)
		[4]: Parent_2_upvr (readonly)
		[5]: Configurations_upvr (readonly)
		[6]: module_upvr (readonly)
	]]
	Handle_upvr.Touched:connect(function(arg1_2) -- Line 122
		--[[ Upvalues[6]:
			[1]: Handle_upvr (copied, readonly)
			[2]: var19_upvw (copied, read and write)
			[3]: GLib_upvr (copied, readonly)
			[4]: Parent_2_upvr (copied, readonly)
			[5]: Configurations_upvr (copied, readonly)
			[6]: module_upvr (copied, readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var21
		if 10 < (Handle_upvr.Position - arg1_2.Position).Magnitude then
		else
			if not arg1_2 or not arg1_2.Parent or var19_upvw then return end
			local Parent = arg1_2.Parent
			local Humanoid = Parent:FindFirstChild("Humanoid")
			local Torso = Parent:FindFirstChild("Torso")
			if not Torso then
				Torso = Parent:FindFirstChild("UpperTorso")
			end
			if not Humanoid or Humanoid.Health == 0 or not Torso then return end
			local any_GetPlayerFromPart_result1_2 = GLib_upvr.GetPlayerFromPart(Parent)
			local any_GetPlayerFromPart_result1 = GLib_upvr.GetPlayerFromPart(Parent_2_upvr)
			var21 = GLib_upvr
			var21 = any_GetPlayerFromPart_result1
			if any_GetPlayerFromPart_result1_2 and (any_GetPlayerFromPart_result1_2 == any_GetPlayerFromPart_result1 or var21.IsTeammate(var21, any_GetPlayerFromPart_result1_2) == true) then return end
			var21 = Configurations_upvr.IdleDamage.Value
			if module_upvr.State == "Slashing" then
				var21 = Configurations_upvr.SlashDamage.Value
			elseif module_upvr.State == "Lunging" then
				var21 = Configurations_upvr.LungeDamage.Value
			end
			var19_upvw = true
			GLib_upvr.TagHumanoid(Humanoid, any_GetPlayerFromPart_result1, 1)
			Humanoid:TakeDamage(var21)
			module_upvr:PoisonHumanoid(Humanoid)
			wait(0.5)
			var19_upvw = false
			local var27
			if any_GetPlayerFromPart_result1 ~= nil and Parent ~= nil and Humanoid ~= nil and any_GetPlayerFromPart_result1 ~= any_GetPlayerFromPart_result1_2 or debounce then
				var27 = any_GetPlayerFromPart_result1.Character
				if var27 then
					var27 = any_GetPlayerFromPart_result1.Character:FindFirstChild("Humanoid")
				end
				local var29
				local function INLINED() -- Internal function, doesn't exist in bytecode
					-- KONSTANTERROR: Expression was reused, decompilation is incorrect
					return var21.IsTeammate(var21, any_GetPlayerFromPart_result1_2) ~= true
				end
				local function INLINED_2() -- Internal function, doesn't exist in bytecode
					var29 = var27:IsA("Humanoid")
					return var29
				end
				local function INLINED_3() -- Internal function, doesn't exist in bytecode
					var29 = var27.Health
					return 0 < var29
				end
				local function INLINED_4() -- Internal function, doesn't exist in bytecode
					var29 = Configurations_upvr.CanKillWithForceField.Value
					return var29
				end
				local function INLINED_5() -- Internal function, doesn't exist in bytecode
					var29 = any_GetPlayerFromPart_result1.Character:FindFirstChild("ForceField")
					return var29 == nil
				end
				if var29 == true or INLINED() or var27 and INLINED_2() and INLINED_3() and (INLINED_4() or INLINED_5()) then
					var29 = true
					debounce = var29 -- Setting global
					var29 = Configurations_upvr.IdleDamage.Value
					if module_upvr.State == "Slashing" then
						var29 = Configurations_upvr.SlashDamage.Value
					elseif module_upvr.State == "Lunging" then
						var29 = Configurations_upvr.LungeDamage.Value
					end
					GLib_upvr.TagHumanoid(Humanoid, any_GetPlayerFromPart_result1, 1)
					Humanoid:TakeDamage(var29)
					module_upvr:PoisonHumanoid(Humanoid)
					wait(0.5)
					debounce = false -- Setting global
				end
			end
		end
	end)
end
module_upvr.Connect = Connect
local var30_upvw = false
function module_upvr.Connect(arg1) -- Line 181
	--[[ Upvalues[6]:
		[1]: Handle_upvr (readonly)
		[2]: GLib_upvr (readonly)
		[3]: Parent_2_upvr (readonly)
		[4]: var30_upvw (read and write)
		[5]: Configurations_upvr (readonly)
		[6]: module_upvr (readonly)
	]]
	Handle_upvr.Touched:connect(function(arg1_3) -- Line 182
		--[[ Upvalues[6]:
			[1]: Handle_upvr (copied, readonly)
			[2]: GLib_upvr (copied, readonly)
			[3]: Parent_2_upvr (copied, readonly)
			[4]: var30_upvw (copied, read and write)
			[5]: Configurations_upvr (copied, readonly)
			[6]: module_upvr (copied, readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		if 10 < (Handle_upvr.Position - arg1_3.Position).Magnitude then
		else
			local any_GetPlayerFromPart_result1_3 = GLib_upvr.GetPlayerFromPart(Parent_2_upvr)
			local any_GetCharacterFromPart_result1_3, any_GetCharacterFromPart_result2_2, any_GetCharacterFromPart_result3_3 = GLib_upvr.GetCharacterFromPart(arg1_3)
			if var30_upvw == false and any_GetPlayerFromPart_result1_3 ~= nil and any_GetCharacterFromPart_result1_3 ~= nil then
				local var43
				if any_GetCharacterFromPart_result3_3 ~= nil and any_GetPlayerFromPart_result1_3 ~= any_GetCharacterFromPart_result2_2 then
					var43 = any_GetCharacterFromPart_result2_2
					var43 = any_GetPlayerFromPart_result1_3.Character
					if var43 then
						var43 = any_GetPlayerFromPart_result1_3.Character:FindFirstChild("Humanoid")
					end
					local var45
					local function INLINED_10() -- Internal function, doesn't exist in bytecode
						var45 = var43:IsA("Humanoid")
						return var45
					end
					local function INLINED_11() -- Internal function, doesn't exist in bytecode
						var45 = var43.Health
						return 0 < var45
					end
					local function INLINED_12() -- Internal function, doesn't exist in bytecode
						var45 = Configurations_upvr.CanKillWithForceField.Value
						return var45
					end
					local function INLINED_13() -- Internal function, doesn't exist in bytecode
						var45 = any_GetPlayerFromPart_result1_3.Character:FindFirstChild("ForceField")
						return var45 == nil
					end
					if var45 == true or GLib_upvr.IsTeammate(any_GetPlayerFromPart_result1_3, var43) ~= true or var43 and INLINED_10() and INLINED_11() and (INLINED_12() or INLINED_13()) then
						var45 = Configurations_upvr.IdleDamage.Value
						if module_upvr.State == "Slashing" then
							var45 = Configurations_upvr.SlashDamage.Value
						elseif module_upvr.State == "Lunging" then
							var45 = Configurations_upvr.LungeDamage.Value
						end
						GLib_upvr.TagHumanoid(any_GetCharacterFromPart_result3_3, any_GetPlayerFromPart_result1_3, 1)
						var30_upvw = true
						any_GetCharacterFromPart_result3_3:TakeDamage(var45)
						module_upvr:PoisonHumanoid(any_GetCharacterFromPart_result3_3)
						wait(0.5)
						var30_upvw = false
					end
				end
			end
		end
	end)
end
function module_upvr.Attack(arg1) -- Line 225
	--[[ Upvalues[4]:
		[1]: GLib_upvr (readonly)
		[2]: Parent_2_upvr (readonly)
		[3]: Configurations_upvr (readonly)
		[4]: module_upvr (readonly)
	]]
	local any_GetCharacterFromPart_result1, _, any_GetCharacterFromPart_result3_2 = GLib_upvr.GetCharacterFromPart(Parent_2_upvr)
	if any_GetCharacterFromPart_result3_2 ~= nil and 0 < any_GetCharacterFromPart_result3_2.Health and (Configurations_upvr.CanKillWithForceField.Value or any_GetCharacterFromPart_result1:FindFirstChild("ForceField") == nil) then
		if module_upvr.State == "Slashing" and tick() - module_upvr.SlashingStartedAt < module_upvr.DoubleClickMaxTime then
			module_upvr.AttackTicket += 1
			module_upvr:Lunge(module_upvr.AttackTicket)
			return
		end
		if module_upvr.State == "Idle" then
			module_upvr.AttackTicket += 1
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			module_upvr.SlashingStartedAt = tick()
			module_upvr:Slash(module_upvr.AttackTicket)
		end
	end
end
function module_upvr.Slash(arg1, arg2) -- Line 246
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
function module_upvr.Lunge(arg1, arg2) -- Line 259
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: Handle_upvr (readonly)
		[3]: Parent_2_upvr (readonly)
	]]
	module_upvr.State = "Lunging"
	Handle_upvr.LungeSound:Play()
	module_upvr:Animate("Lunge")
	local BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.velocity = Vector3.new(0, 10, 0)
	BodyVelocity.maxForce = Vector3.new(0, 4000, 0)
	BodyVelocity.Parent = Parent_2_upvr.Parent.Torso
	wait(0.25)
	Parent_2_upvr.GripForward = Vector3.new(0, 0, 1)
	Parent_2_upvr.GripRight = Vector3.new(0, -1, 0)
	Parent_2_upvr.GripUp = Vector3.new(-1, 0, 0)
	wait(0.25)
	BodyVelocity:Destroy()
	wait(0.5)
	Parent_2_upvr.GripForward = Vector3.new(-1, 0, 0)
	Parent_2_upvr.GripRight = Vector3.new(0, 1, 0)
	Parent_2_upvr.GripUp = Vector3.new(0, 0, 1)
	module_upvr.State = "Idle"
end
function module_upvr.Animate(arg1, arg2) -- Line 284
	--[[ Upvalues[1]:
		[1]: Parent_2_upvr (readonly)
	]]
	local StringValue = Instance.new("StringValue")
	StringValue.Name = "toolanim"
	StringValue.Value = arg2
	StringValue.Parent = Parent_2_upvr
end
function module_upvr.Initialize(arg1) -- Line 292
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: Configurations_upvr (readonly)
	]]
	module_upvr:Connect()
	spawn(function() -- Line 295
		--[[ Upvalues[2]:
			[1]: module_upvr (copied, readonly)
			[2]: Configurations_upvr (copied, readonly)
		]]
		while script:IsDescendantOf(game) do
			module_upvr:PoisonStep()
			wait(Configurations_upvr.PoisonRate.Value)
		end
	end)
end
return module_upvr