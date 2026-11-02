-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:35
-- Luau version 6, Types version 3
-- Time taken: 0.022425 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
UserInputService = game:GetService("UserInputService") -- Setting global
AmmoDisplay = script:WaitForChild("AmmoDisplay"):Clone() -- Setting global
CastLaser = Tool:WaitForChild("CastLaser"):Clone() -- Setting global
Camera = game:GetService("Workspace").CurrentCamera -- Setting global
BaseUrl = "http://www.roblox.com/asset/?id=" -- Setting global
AnimationTracks = {} -- Setting global
LocalObjects = {} -- Setting global
Animations = {
	Hold = {
		Animation = Tool:WaitForChild("Hold");
		FadeTime = nil;
		Weight = nil;
		Speed = 1;
		Duration = 2;
	};
	Fire = {
		Animation = Tool:WaitForChild("Fire");
		FadeTime = 0.25;
		Weight = nil;
		Speed = 0.5;
		Duration = 0.5;
	};
	Reload = {
		Animation = Tool:WaitForChild("Reload");
		FadeTime = nil;
		Weight = nil;
		Speed = 1;
		Duration = 2;
	};
} -- Setting global
Sounds = {
	Reload = Handle:WaitForChild("Reload");
	NoAmmo = Handle:WaitForChild("NoAmmo");
} -- Setting global
Modules = Tool:WaitForChild("Modules") -- Setting global
Functions = require(Modules:WaitForChild("Functions")) -- Setting global
Remotes = Tool:WaitForChild("Remotes") -- Setting global
ServerControl = Remotes:WaitForChild("ServerControl") -- Setting global
ClientControl = Remotes:WaitForChild("ClientControl") -- Setting global
ConfigurationBin = Tool:WaitForChild("Configuration") -- Setting global
Configuration = {} -- Setting global
Configuration = Functions.CreateConfiguration(ConfigurationBin, Configuration) -- Setting global
Cursors = {
	Normal = BaseUrl.."170908665";
	EnemyHit = BaseUrl.."172618259";
} -- Setting global
Rate = (1/60) -- Setting global
FiringOffset = Vector3.new(0, Handle.Size.Y / 4 - 0.2, -(Handle.Size.Z / 2)) -- Setting global
Reloading = false -- Setting global
MouseDown = false -- Setting global
ToolEquipped = false -- Setting global
Tool.Enabled = true
function SetAnimation(arg1, arg2) -- Line 59
	if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
		for i, v in pairs(AnimationTracks) do
			if v.Animation == arg2.Animation then
				v.AnimationTrack:Stop()
				table.remove(AnimationTracks, i)
			end
		end
		local Humanoid_LoadAnimation_result1 = Humanoid:LoadAnimation(arg2.Animation)
		table.insert(AnimationTracks, {
			Animation = arg2.Animation;
			AnimationTrack = Humanoid_LoadAnimation_result1;
		})
		Humanoid_LoadAnimation_result1:Play(arg2.FadeTime, arg2.Weight, arg2.Speed)
	elseif arg1 == "StopAnimation" and arg2 then
		for i_8, v_8 in pairs(AnimationTracks) do
			if v_8.Animation == arg2.Animation then
				v_8.AnimationTrack:Stop(arg2.FadeTime)
				table.remove(AnimationTracks, i_8)
			end
		end
	end
end
function ToggleGui() -- Line 80
	if not AmmoDisplayClone or not AmmoDisplayClone.Parent then
	else
		local Ammo = AmmoDisplayClone.Frame.Ammo
		if 0 < Configuration.Ammo.ClipSize.MaxValue then
			Ammo.AmmoCounter.CounterPart.Text = Configuration.Ammo.ClipSize.Value
		end
		Ammo.MagCounter.CounterPart.Text = Configuration.Ammo.Magazines.Value
	end
end
function Reload() -- Line 92
	local var20
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var20 = Tool.Enabled
		return var20
	end
	local function INLINED_2() -- Internal function, doesn't exist in bytecode
		var20 = Configuration.Ammo.Magazines.Value
		return Configuration.Ammo.Magazines.MaxValue <= var20
	end
	if var20 or not INLINED() or INLINED_2() then
	else
		var20 = Tool
		var20.Enabled = false
		var20 = true
		Reloading = var20 -- Setting global
		var20 = ToggleGui
		var20()
		var20 = true
		if 0 < Configuration.Ammo.ClipSize.MaxValue and Configuration.Ammo.ClipSize.Value <= 0 then
			var20 = false
		else
			var20 = true
			local var21
		end
		if var20 then
			var21 = Spawn
			var21(function() -- Line 106
				local Reload_3 = Animations.Reload
				OnClientInvoke("PlayAnimation", Reload_3)
				wait(Reload_3.Duration)
				OnClientInvoke("StopAnimation", Reload_3)
			end)
			var21 = Sounds.Reload:Play
			var21()
			local function INLINED_3() -- Internal function, doesn't exist in bytecode
				var21 = Configuration.Ammo.Magazines.MaxValue - Configuration.Ammo.Magazines.Value
				return var21
			end
			if 0 >= Configuration.Ammo.Magazines.MaxValue or not INLINED_3() then
				var21 = Configuration.Ammo.ClipSize.MaxValue
			end
			local var24
			if 0 < var24 then
				local function INLINED_4() -- Internal function, doesn't exist in bytecode
					var24 = Configuration.Ammo.ClipSize.Value
					return var24
				end
				if Configuration.Ammo.ClipSize.Value >= var21 or not INLINED_4() then
					var24 = var21
				end
				var21 = var24
			end
			wait(Configuration.ReloadTime.Value)
			Configuration.Ammo.Magazines.Value = Configuration.Ammo.Magazines.Value + var21
			Configuration.Ammo.ClipSize.Value = Configuration.Ammo.ClipSize.Value - var21
			Sounds.Reload:Stop()
			ToggleGui()
		end
		Reloading = false -- Setting global
		Tool.Enabled = true
	end
end
function RayTouched(arg1, arg2) -- Line 132
	if not arg1 or not arg1.Parent then
	else
		local Parent_2 = arg1.Parent
		if Parent_2:IsA("Hat") then
			local Parent = Parent_2.Parent
		end
		if Parent == Character then return end
		local Humanoid_2 = Parent:FindFirstChild("Humanoid")
		if not Humanoid_2 or Humanoid_2.Health == 0 then return end
		local Players_GetPlayerFromCharacter_result1 = Players:GetPlayerFromCharacter(Parent)
		if Players_GetPlayerFromCharacter_result1 and Functions.IsTeamMate(Player, Players_GetPlayerFromCharacter_result1) then return end
		Spawn(function() -- Line 152
			IconChangeTick = tick() -- Setting global
			PlayerMouse.Icon = Cursors.EnemyHit
			wait(1)
			if 0.95 <= tick() - IconChangeTick and ToolEquipped and PlayerMouse then
				PlayerMouse.Icon = Cursors.Normal
			end
		end)
	end
end
function FireRay(arg1, arg2) -- Line 162
	local Functions_CastRay_result1_upvr, Functions_CastRay_result2_upvr, _ = Functions.CastRay(arg1, CFrame.new(arg1, arg2).lookVector, Configuration.Range.Value, {Character}, false)
	local Backpack = Player:FindFirstChild("Backpack")
	if Backpack then
		local clone = CastLaser:Clone()
		local Vector3Value_2 = Instance.new("Vector3Value")
		Vector3Value_2.Name = "StartPosition"
		Vector3Value_2.Value = arg1
		Vector3Value_2.Parent = clone
		local Vector3Value = Instance.new("Vector3Value")
		Vector3Value.Name = "TargetPosition"
		Vector3Value.Value = Functions_CastRay_result2_upvr
		Vector3Value.Parent = clone
		local BoolValue = Instance.new("BoolValue")
		BoolValue.Name = "RayHit"
		BoolValue.Value = BoolValue
		BoolValue.Parent = clone
		clone.Disabled = false
		clone.Parent = Backpack
	end
	Spawn(function() -- Line 183
		--[[ Upvalues[3]:
			[1]: arg1 (readonly)
			[2]: Functions_CastRay_result2_upvr (readonly)
			[3]: Functions_CastRay_result1_upvr (readonly)
		]]
		local tbl_2 = {}
		tbl_2.StartPosition = arg1
		local var41 = Functions_CastRay_result2_upvr
		tbl_2.TargetPosition = var41
		if Functions_CastRay_result1_upvr then
			var41 = true
		else
			var41 = false
		end
		tbl_2.RayHit = var41
		InvokeServer("CastLaser", tbl_2)
	end)
	Spawn(function() -- Line 186
		--[[ Upvalues[2]:
			[1]: Functions_CastRay_result1_upvr (readonly)
			[2]: Functions_CastRay_result2_upvr (readonly)
		]]
		InvokeServer("RayHit", {
			Hit = Functions_CastRay_result1_upvr;
			Position = Functions_CastRay_result2_upvr;
		})
	end)
	RayTouched(Functions_CastRay_result1_upvr, Functions_CastRay_result2_upvr)
end
function Button1Pressed(arg1) -- Line 192
	if not arg1 and MouseDown then
		MouseDown = false -- Setting global
	end
end
function KeyPress(arg1, arg2) -- Line 198
	if arg1 == 'r' and arg2 then
		Reload()
	end
end
function Activated() -- Line 204
	-- KONSTANTERROR: [0] 1. Error Block 44 start (CF ANALYSIS FAILED)
	if not Tool.Enabled or not ToolEquipped or Reloading then return end
	Tool.Enabled = false
	-- KONSTANTERROR: [0] 1. Error Block 44 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [291] 187. Error Block 49 start (CF ANALYSIS FAILED)
	Tool.Enabled = true
	Sounds.NoAmmo:Play()
	Reload()
	-- KONSTANTERROR: [291] 187. Error Block 49 end (CF ANALYSIS FAILED)
end
function CheckIfAlive() -- Line 261
	if Player and Player.Parent and Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health then
		return true
	end
	return false
end
local UserInputType_upvr = Enum.UserInputType
function Equipped(arg1) -- Line 266
	--[[ Upvalues[1]:
		[1]: UserInputType_upvr (readonly)
	]]
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	if not CheckIfAlive() then
	else
		ToolEquipped = true -- Setting global
		spawn(function() -- Line 274
			--[[ Upvalues[2]:
				[1]: UserInputType_upvr (copied, readonly)
				[2]: arg1 (readonly)
			]]
			UserInputService.InputBegan:connect(function(arg1_2) -- Line 275
				--[[ Upvalues[1]:
					[1]: UserInputType_upvr (copied, readonly)
				]]
				if arg1_2.UserInputType == UserInputType_upvr.MouseButton1 or arg1_2.UserInputType == UserInputType_upvr.Touch or arg1_2.KeyCode == Enum.KeyCode.ButtonR2 then
					Button1Pressed(true)
				end
			end)
			UserInputService.InputEnded:connect(function(arg1_3) -- Line 280
				--[[ Upvalues[1]:
					[1]: UserInputType_upvr (copied, readonly)
				]]
				if arg1_3.UserInputType == UserInputType_upvr.MouseButton1 or arg1_3.UserInputType == UserInputType_upvr.Touch or arg1_3.KeyCode == Enum.KeyCode.ButtonR2 then
					Button1Pressed(false)
				end
			end)
			PlayerMouse = Player:GetMouse() -- Setting global
			arg1.KeyDown:connect(function(arg1_4) -- Line 286
				KeyPress(arg1_4, true)
			end)
			arg1.KeyUp:connect(function(arg1_5) -- Line 289
				KeyPress(arg1_5, false)
			end)
			Humanoid.CameraOffset = Vector3.new(0, 0.34999, 0)
			OnClientInvoke("PlayAnimation", Animations.Hold)
			local PlayerGui = Player:FindFirstChild("PlayerGui")
			if PlayerGui then
				local function AdjustAmmoDisplay_upvr() -- Line 296, Named "AdjustAmmoDisplay"
					local Frame = AmmoDisplayClone.Frame
					Frame.CurrentWeapon.Text = Configuration.ToolName.Value
					local var57
					local function INLINED_5() -- Internal function, doesn't exist in bytecode
						var57 = Configuration.Ammo.ClipSize.Value
						return var57
					end
					if 0 >= Configuration.Ammo.ClipSize.MaxValue or not INLINED_5() then
						var57 = "--"
					end
					Frame.Ammo.AmmoCounter.CounterPart.Text = var57
					var57 = Frame.Ammo.MagCounter
					var57 = Configuration.Ammo.Magazines.Value
					var57.CounterPart.Text = var57
				end
				AmmoDisplayClone = AmmoDisplay:Clone() -- Setting global
				AdjustAmmoDisplay_upvr()
				AmmoDisplayClone.Parent = PlayerGui
				Debris:AddItem(AmmoDisplayClone, 45)
				ToggleGui()
				for _, v_5 in pairs({ClipSizeChanged, MagazinesChanged}) do
					if v_5 then
						v_5:disconnect()
					end
				end
				ClipSizeChanged = Configuration.Ammo.ClipSize.Changed:connect(function() -- Line 313
					--[[ Upvalues[1]:
						[1]: AdjustAmmoDisplay_upvr (readonly)
					]]
					AdjustAmmoDisplay_upvr()
				end) -- Setting global
				MagazinesChanged = Configuration.Ammo.Magazines.Changed:connect(function() -- Line 316
					--[[ Upvalues[1]:
						[1]: AdjustAmmoDisplay_upvr (readonly)
					]]
					AdjustAmmoDisplay_upvr()
				end) -- Setting global
			end
			AdjustAmmoDisplay_upvr = pairs
			local tbl = {"Left Arm", "Right Arm"}
			AdjustAmmoDisplay_upvr = AdjustAmmoDisplay_upvr(tbl)
			local AdjustAmmoDisplay_result1, AdjustAmmoDisplay_upvr_result2, AdjustAmmoDisplay_result3 = AdjustAmmoDisplay_upvr(tbl)
			for _, v_6 in AdjustAmmoDisplay_result1, AdjustAmmoDisplay_upvr_result2, AdjustAmmoDisplay_result3 do
				local SOME_upvr = Character:FindFirstChild(v_6)
				if SOME_upvr then
					Spawn(function() -- Line 323
						--[[ Upvalues[1]:
							[1]: SOME_upvr (readonly)
						]]
						OnClientInvoke("SetLocalTransparencyModifier", {
							Object = SOME_upvr;
							Transparency = 0;
							AutoUpdate = false;
						})
					end)
				end
			end
			AdjustAmmoDisplay_result1 = arg1
			AdjustAmmoDisplay_result1.Icon = Cursors.Normal
		end)
	end
end
function Unequipped() -- Line 332
	LocalObjects = {} -- Setting global
	if CheckIfAlive() then
		Humanoid.CameraOffset = Vector3.new(0, 0, 0)
	end
	for _, v_2 in pairs(Sounds) do
		v_2:Stop()
	end
	if PlayerMouse then
		PlayerMouse.Icon = ""
	end
	for _, v_3 in pairs({ObjectLocalTransparencyModifier, AmmoDisplayClone, ClipSizeChanged, MagazinesChanged}) do
		if tostring(v_3) == "Connection" then
			v_3:disconnect()
		elseif v_3 and v_3.Parent then
			v_3:Destroy()
		end
	end
	MouseDown = false -- Setting global
	for _, v_4 in pairs(AnimationTracks) do
		if v_4 and v_4.AnimationTrack then
			v_4.AnimationTrack:Stop()
		end
	end
	AnimationTracks = {} -- Setting global
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 360
	pcall(function() -- Line 361
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: arg2 (readonly)
		]]
		return ServerControl:InvokeServer(arg1, arg2)
	end)
end
function OnClientInvoke(arg1, arg2) -- Line 367
	if arg1 == "PlayAnimation" and arg2 and ToolEquipped and Humanoid then
		SetAnimation("PlayAnimation", arg2)
	else
		if arg1 == "StopAnimation" and arg2 then
			SetAnimation("StopAnimation", arg2)
			return
		end
		if arg1 == "PlaySound" and arg2 then
			arg2:Play()
			return
		end
		if arg1 == "StopSound" and arg2 then
			arg2:Stop()
			return
		end
		if arg1 == "MousePosition" then
			return {
				Position = PlayerMouse.Hit.p;
				Target = PlayerMouse.Target;
			}
		end
		if arg1 == "SetLocalTransparencyModifier" and arg2 and ToolEquipped then
			pcall(function() -- Line 379
				--[[ Upvalues[1]:
					[1]: arg2 (readonly)
				]]
				local var97
				for _, v_7 in pairs(LocalObjects) do
					if v_7 == arg2 then
					end
				end
				if not nil then
					table.insert(LocalObjects, arg2)
					if ObjectLocalTransparencyModifier then
						ObjectLocalTransparencyModifier:disconnect()
					end
					ObjectLocalTransparencyModifier = RunService.RenderStepped:connect(function() -- Line 391
						-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
						local pairs_result1_4, pairs_result2_4, pairs_result3_5 = pairs(LocalObjects)
						-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [41] 26. Error Block 13 start (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [41] 26. Error Block 13 end (CF ANALYSIS FAILED)
						-- KONSTANTERROR: [6] 5. Error Block 21 start (CF ANALYSIS FAILED)
						-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.5]
						if nil then
							-- KONSTANTERROR: Expression was reused, decompilation is incorrect
							if nil then
								-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [41.6]
								local function INLINED_9() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil == 1
								end
								local function INLINED_10() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil == 0
								end
								local function INLINED_11() -- Internal function, doesn't exist in bytecode
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									return nil
								end
								if not nil and (INLINED_9() or INLINED_10()) or INLINED_11() then
									-- KONSTANTWARNING: GOTO [41] #26
								end
								-- KONSTANTWARNING: GOTO [41] #26
							end
						end
						-- KONSTANTERROR: [6] 5. Error Block 21 end (CF ANALYSIS FAILED)
					end) -- Setting global
				end
			end)
		end
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Activated:connect(Activated)
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)