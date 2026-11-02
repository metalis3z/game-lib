-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:58
-- Luau version 6, Types version 3
-- Time taken: 0.010423 seconds

local Parent_upvr = script.Parent
Parent_upvr.Enabled = true
local RunService_upvr = game:GetService("RunService")
local var3_upvw
local var4_upvw
local var5_upvw
local var6_upvw
local SlashSound_upvr = Parent_upvr.Handle.SlashSound
local SpinSound_upvr = Parent_upvr.Handle.SpinSound
local WhackSound_upvr = Parent_upvr.Handle.WhackSound
function slashIt(arg1, arg2) -- Line 15
	--[[ Upvalues[3]:
		[1]: Parent_upvr (readonly)
		[2]: var3_upvw (read and write)
		[3]: SlashSound_upvr (readonly)
	]]
	nsAnim = arg1:LoadAnimation(Parent_upvr["Ninja Slash"]) -- Setting global
	if nsAnim == nil then
		Parent_upvr.Enabled = true
	else
		nsAnim:Play()
		local TargetPoint = arg1.TargetPoint
		local var11 = (TargetPoint - arg2.Position) * Vector3.new(1, 0, 1)
		var3_upvw = nil
		if 0.01 < var11.magnitude then
			var3_upvw = Instance.new("BodyVelocity")
			var3_upvw.P = 100000
			var3_upvw.maxForce = Vector3.new(var3_upvw.P, 0, var3_upvw.P)
			var3_upvw.velocity = var11.unit * 50
			var3_upvw.Parent = arg2
			arg2.CFrame = CFrame.new(arg2.Position, TargetPoint * Vector3.new(1, 0, 1) + Vector3.new(0, arg2.Position.Y, 0))
		end
		wait(0.5)
		SlashSound_upvr:Play()
		if var3_upvw ~= nil then
			var3_upvw:remove()
		end
		wait(0.5)
	end
end
function dashIt(arg1, arg2) -- Line 43
	--[[ Upvalues[6]:
		[1]: Parent_upvr (readonly)
		[2]: var4_upvw (read and write)
		[3]: var6_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var3_upvw (read and write)
		[6]: SpinSound_upvr (readonly)
	]]
	ndAnim = arg1:LoadAnimation(Parent_upvr["Ninja Dash"]) -- Setting global
	if ndAnim == nil then
		Parent_upvr.Enabled = true
	else
		target = arg1.TargetPoint -- Setting global
		local var12 = (target - arg2.Position) * Vector3.new(1, 0, 1)
		if var12.magnitude < 0.01 then
			Parent_upvr.Enabled = true
			return
		end
		var4_upvw = Instance.new("BodyGyro")
		var4_upvw.P = 30000
		var4_upvw.maxTorque = Vector3.new(var4_upvw.P, var4_upvw.P, var4_upvw.P)
		local Position = arg2.Position
		var4_upvw.cframe = CFrame.new(Position, target * Vector3.new(1, 0, 1) + Vector3.new(0, Position.Y, 0)) * CFrame.Angles((-math.pi/2), 0, 0)
		var4_upvw.Parent = arg2
		var6_upvw = Instance.new("BodyPosition")
		var6_upvw.P = 100000
		var6_upvw.maxForce = Vector3.new(var6_upvw.P, var6_upvw.P, var6_upvw.P)
		var6_upvw.position = Position + Vector3.new(0, 1.5, 0)
		var6_upvw.Parent = arg2
		var5_upvw = Instance.new("BodyAngularVelocity")
		var5_upvw.P = 100000
		var5_upvw.maxTorque = Vector3.new(var5_upvw.P, var5_upvw.P, var5_upvw.P)
		var3_upvw = Instance.new("BodyVelocity")
		var3_upvw.P = 100000
		var3_upvw.maxForce = Vector3.new(var3_upvw.P, 0, var3_upvw.P)
		var3_upvw.velocity = var12.unit * 64
		ndAnim:Play()
		wait(0.5)
		SpinSound_upvr:Play()
		var4_upvw.maxTorque = Vector3.new(var6_upvw.P, 0, var6_upvw.P)
		var6_upvw.maxForce = Vector3.new(0, var6_upvw.P, 0)
		var3_upvw.Parent = arg2
		var5_upvw.angularvelocity = arg2.CFrame:vectorToWorldSpace(Vector3.new(0, -30, 0))
		arg1.Sit = true
		var5_upvw.Parent = arg2
		wait(1)
		arg1.Sit = false
		if var5_upvw ~= nil then
			var5_upvw:remove()
		end
		if var6_upvw ~= nil then
			var6_upvw:remove()
		end
		if var3_upvw ~= nil then
			var3_upvw:remove()
		end
		if var4_upvw ~= nil then
			var4_upvw.cframe = CFrame.new(Position, target * Vector3.new(1, 0, 1) + Vector3.new(0, Position.Y, 0))
		end
		if var4_upvw ~= nil then
			var4_upvw.maxTorque = Vector3.new(var4_upvw.P, var4_upvw.P, var4_upvw.P)
		end
		SpinSound_upvr:Stop()
		wait(0.25)
		if var4_upvw ~= nil then
			var4_upvw:remove()
		end
	end
end
local var14_upvw = 0
local var15_upvw = false
local var16_upvw = 0
function onActivated() -- Line 128
	--[[ Upvalues[6]:
		[1]: Parent_upvr (readonly)
		[2]: var15_upvw (read and write)
		[3]: RunService_upvr (readonly)
		[4]: var14_upvw (read and write)
		[5]: var16_upvw (read and write)
		[6]: WhackSound_upvr (readonly)
	]]
	vChar = Parent_upvr.Parent -- Setting global
	if vChar == nil then
	else
		hum = vChar:FindFirstChild("Humanoid") -- Setting global
		if hum == nil then return end
		if var15_upvw then return end
		Parent_upvr.Enabled = false
		var15_upvw = true
		torso = vChar:FindFirstChild("Torso") -- Setting global
		if torso == nil then
			Parent_upvr.Enabled = true
			return
		end
		t = RunService_upvr.Stepped:wait() -- Setting global
		if t - var14_upvw < 0.2 then
			dashIt(hum, torso)
			wait(0.5)
			var15_upvw = false
		elseif t - var16_upvw < 0.2 then
			slashIt(hum, torso)
			var15_upvw = false
		else
			WhackSound_upvr:Play()
			var16_upvw = t
			var15_upvw = false
			wait(0.5)
		end
		if not var15_upvw then
			Parent_upvr.Enabled = true
		end
	end
end
local var17_upvw
local var18_upvw = 0
function onKeyDown(arg1) -- Line 164
	--[[ Upvalues[3]:
		[1]: RunService_upvr (readonly)
		[2]: var18_upvw (read and write)
		[3]: var14_upvw (read and write)
	]]
	if arg1:lower() == 'w' then
		t = RunService_upvr.Stepped:wait() -- Setting global
		if t - var18_upvw < 0.2 then
			var14_upvw = t
		end
		var18_upvw = t
	end
end
function onEquippedLocal(arg1) -- Line 172
	--[[ Upvalues[4]:
		[1]: SlashSound_upvr (readonly)
		[2]: SpinSound_upvr (readonly)
		[3]: WhackSound_upvr (readonly)
		[4]: var17_upvw (read and write)
	]]
	SlashSound_upvr.Volume = 1
	SpinSound_upvr.Volume = 1
	WhackSound_upvr.Volume = 1
	var17_upvw = arg1.KeyDown:connect(onKeyDown)
end
function onUnequippedLocal() -- Line 180
	--[[ Upvalues[8]:
		[1]: var17_upvw (read and write)
		[2]: var3_upvw (read and write)
		[3]: var4_upvw (read and write)
		[4]: var5_upvw (read and write)
		[5]: var6_upvw (read and write)
		[6]: SlashSound_upvr (readonly)
		[7]: SpinSound_upvr (readonly)
		[8]: WhackSound_upvr (readonly)
	]]
	if var17_upvw ~= nil then
		var17_upvw:disconnect()
	end
	if var3_upvw ~= nil then
		var3_upvw:remove()
	end
	if var4_upvw ~= nil then
		var4_upvw:remove()
	end
	if var5_upvw ~= nil then
		var5_upvw:remove()
	end
	if var6_upvw ~= nil then
		var6_upvw:remove()
	end
	SlashSound_upvr.Volume = 0
	SpinSound_upvr.Volume = 0
	WhackSound_upvr.Volume = 0
end
Parent_upvr.Equipped:connect(onEquippedLocal)
Parent_upvr.Unequipped:connect(onUnequippedLocal)
Parent_upvr.Activated:connect(onActivated)