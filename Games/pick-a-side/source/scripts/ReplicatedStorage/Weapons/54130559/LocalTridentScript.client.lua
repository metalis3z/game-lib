-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:43
-- Luau version 6, Types version 3
-- Time taken: 0.010144 seconds

local Parent_upvr = script.Parent
local GLib_upvr = require(game:GetService("ReplicatedStorage").GLib)
local var3_upvw
local var4_upvw
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.P = 10000
BodyVelocity.Name = "QuakeVel"
BodyVelocity.maxForce = Vector3.new(10000, 10000, 10000)
local var6_upvw
local tbl_upvr = {Parent_upvr:FindFirstChild("StabAnim"), Parent_upvr:FindFirstChild("SlashAnim")}
QuakeEnabled = Parent_upvr:WaitForChild("QuakeEnabled") -- Setting global
local UserInputService_upvr = game:GetService("UserInputService")
local ContextActionService_upvr = game:GetService("ContextActionService")
local var10_upvw
local var11_upvw
local tbl_upvw = {}
local var13_upvw
function guraGura(arg1, arg2) -- Line 48
	--[[ Upvalues[8]:
		[1]: var10_upvw (read and write)
		[2]: var3_upvw (read and write)
		[3]: var11_upvw (read and write)
		[4]: Parent_upvr (readonly)
		[5]: var4_upvw (read and write)
		[6]: tbl_upvw (read and write)
		[7]: var13_upvw (read and write)
		[8]: GLib_upvr (readonly)
	]]
	var10_upvw = var3_upvw:FindFirstChild("Torso")
	var11_upvw = Parent_upvr:FindFirstChild("ActivateQuake")
	vPlayer = game.Players:GetPlayerFromCharacter(var3_upvw) -- Setting global
	var4_upvw = var3_upvw:FindFirstChild("Humanoid")
	leftArm = var3_upvw:FindFirstChild("Left Arm") -- Setting global
	if arg2 or arg1:lower() == 'q' or QuakeEnabled.Value then
		QuakeEnabled.Value = false
		tbl_upvw = {}
		var13_upvw = var4_upvw:LoadAnimation(Parent_upvr.QuakeAnim)
		if var13_upvw then
			var13_upvw:Play()
		end
		wait(0.75)
		var11_upvw:FireServer(1)
		vPlayer = game.Players:GetPlayerFromCharacter(var3_upvw) -- Setting global
		players = game.Players:GetChildren() -- Setting global
		if 1 < #players then
			for i = 1, #players do
				if players[i] ~= vPlayer and not GLib_upvr.IsTeammate(players[i], vPlayer) then
					tempChar = players[i].Character -- Setting global
					if tempChar then
						tempTorso = tempChar:FindFirstChild("Torso") -- Setting global
						if tempTorso then
							distance = (tempTorso.Position - var10_upvw.Position).magnitude -- Setting global
							if distance < 50 then
								table.insert(tbl_upvw, tempChar)
							end
						end
					end
				end
			end
			for i_2 = 1, #tbl_upvw do
				script.Parent.QuakeRemote:FireServer(tbl_upvw[i_2])
			end
		end
		parts = game.Workspace:FindPartsInRegion3(Region3.new(var10_upvw.Position - Vector3.new(15, 15, 15), var10_upvw.Position + Vector3.new(15, 15, 15)), var3_upvw, 100) -- Setting global
		script.Parent.QuakePartRemote:FireServer(parts, var10_upvw)
		wait(2)
		var11_upvw:FireServer(0)
	end
end
function onActivated() -- Line 94
	--[[ Upvalues[5]:
		[1]: Parent_upvr (readonly)
		[2]: var3_upvw (read and write)
		[3]: var4_upvw (read and write)
		[4]: var6_upvw (read and write)
		[5]: tbl_upvr (readonly)
	]]
	while Parent_upvr.Enabled == false do
		wait()
	end
	var3_upvw = Parent_upvr.Parent
	var4_upvw = var3_upvw:FindFirstChild("Humanoid")
	if var4_upvw == nil then
	else
		rand = math.random(1, 2) -- Setting global
		var6_upvw = var4_upvw:LoadAnimation(tbl_upvr[rand])
		if var6_upvw then
			var6_upvw:Play()
		end
		if rand == 2 then
			Parent_upvr.GripPos = Vector3.new(0, 0, -2.7999)
			wait(1.2)
			Parent_upvr.GripPos = Vector3.new(0, 0, -0.6000)
			return
		end
		wait(0.2)
		Parent_upvr.GripUp = Vector3.new(0, 0, -1)
		Parent_upvr.GripPos = Vector3.new(0, 0, -3)
		wait(0.7)
		Parent_upvr.GripPos = Vector3.new(0, 0, -0.6000)
		Parent_upvr.GripUp = Vector3.new(0, 0, 1)
	end
end
function onEquipped(arg1) -- Line 122
	--[[ Upvalues[5]:
		[1]: var3_upvw (read and write)
		[2]: Parent_upvr (readonly)
		[3]: UserInputService_upvr (readonly)
		[4]: ContextActionService_upvr (readonly)
		[5]: GLib_upvr (readonly)
	]]
	var3_upvw = Parent_upvr.Parent
	if arg1 then
		arg1.KeyDown:connect(guraGura)
	end
	activeQuake = Parent_upvr:FindFirstChild("ActivateQuake") -- Setting global
	if UserInputService_upvr.TouchEnabled then
		local var19_upvw = 0
		ContextActionService_upvr:BindActionToInputTypes("PoseidonsQuakeTrident_Quake", function(arg1_2, arg2) -- Line 134
			--[[ Upvalues[2]:
				[1]: var19_upvw (read and write)
				[2]: GLib_upvr (copied, readonly)
			]]
			if arg2 == Enum.UserInputState.End and 5 < tick() - var19_upvw then
				GLib_upvr.SetButtonCooldown("PoseidonsQuakeTrident_Quake", 5)
				var19_upvw = tick()
				GLib_upvr.FastSpawn(function() -- Line 139
					guraGura('x')
				end)
			end
		end, true, "")
		ContextActionService_upvr:SetTitle("PoseidonsQuakeTrident_Quake", "Quake")
		ContextActionService_upvr:SetImage("PoseidonsQuakeTrident_Quake", Parent_upvr.TextureId)
	end
end
function onUnequipped() -- Line 151
	--[[ Upvalues[3]:
		[1]: var6_upvw (read and write)
		[2]: UserInputService_upvr (readonly)
		[3]: ContextActionService_upvr (readonly)
	]]
	if var6_upvw then
		var6_upvw:Stop()
	end
	if UserInputService_upvr.TouchEnabled then
		ContextActionService_upvr:UnbindAction("PoseidonsQuakeTrident_Quake")
	end
end
Parent_upvr.Activated:connect(onActivated)
Parent_upvr.Equipped:connect(onEquipped)
Parent_upvr.Unequipped:connect(onUnequipped)
local Button = script.Parent:WaitForChild("SpecialGui"):WaitForChild("Frame"):WaitForChild("Button")
Button.MouseButton1Down:Connect(function() -- Line 172
	guraGura(nil, true)
end)
local UserInputService = game:GetService("UserInputService")
if UserInputService.GamepadEnabled then
	Button.Text = 'Y'
end
UserInputService.InputBegan:Connect(function(arg1) -- Line 179
	local KeyCode = arg1.KeyCode
	if KeyCode == Enum.KeyCode.ButtonR1 or KeyCode == Enum.KeyCode.ButtonY or KeyCode == Enum.KeyCode.ButtonL2 then
		guraGura(nil, true)
	end
end)