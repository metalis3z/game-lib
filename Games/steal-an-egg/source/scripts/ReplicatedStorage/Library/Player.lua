-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local t = {
	Optional = {},
	Player = function(p1) --[[ Player | Line: 11 | Upvalues: Players (copy) ]]
		return if p1 then p1 else Players.LocalPlayer
	end
}

function t.Get(p1) --[[ Line: 16 | Upvalues: t (copy) ]]
	return t.Player(p1)
end
function t.Optional.Character(p1) --[[ Line: 21 | Upvalues: t (copy) ]]
	return t.Player(p1).Character
end
function t.Character(p1) --[[ Line: 26 | Upvalues: t (copy) ]]
	local v1 = t.Player(p1)

	return v1.Character or v1.CharacterAdded:Wait()
end
function t.Optional.Position(p1) --[[ Line: 32 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	return if v1 then v1:GetPivot().Position or nil else nil
end
function t.Position(p1) --[[ Line: 38 | Upvalues: t (copy) ]]
	return t.Character(p1):GetPivot().Position
end
function t.Optional.CFrame(p1) --[[ Line: 43 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	return if v1 then v1:GetPivot() or nil else nil
end
function t.CFrame(p1) --[[ Line: 49 | Upvalues: t (copy) ]]
	return t.Character(p1):GetPivot()
end

local function GetDistanceFrom(p1, p2) --[[ GetDistanceFrom | Line: 53 | Upvalues: Asserts (copy), t (copy) ]]
	Asserts.Vector3(p2)

	local v1 = t.Optional.Position(p1)

	if v1 then
		return (p2 - v1).Magnitude
	end
end

t.Optional.GetDistanceFrom = GetDistanceFrom
function t.GetDistanceFrom(p1, p2) --[[ GetDistanceFrom | Line: 64 | Upvalues: t (copy) ]]
	return assert(t.Optional.GetDistanceFrom(p1, p2), "Invalid distance")
end

local function IsWithinRange(p1, p2, p3) --[[ IsWithinRange | Line: 69 | Upvalues: t (copy), Asserts (copy) ]]
	local v1 = t.Optional.GetDistanceFrom(p1, p2)

	if not v1 then
		return
	end

	Asserts.Vector3(p2)
	Asserts.number(p3)

	return v1 <= p3
end

t.Optional.IsWithinRange = IsWithinRange
function t.IsWithinRange(p1, p2, p3) --[[ IsWithinRange | Line: 81 | Upvalues: t (copy) ]]
	local v1 = t.Optional.IsWithinRange(p1, p2, p3)

	assert(v1 ~= nil, "Invalid result for is within range")

	return v1
end
function t.Optional.PrimaryPart(p1) --[[ Line: 88 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	return if v1 then v1.PrimaryPart else v1
end
function t.PrimaryPart(p1) --[[ Line: 94 | Upvalues: t (copy) ]]
	local v1 = t.Character(p1)
	local PrimaryPart = v1.PrimaryPart

	if not PrimaryPart then
		v1:WaitForChild("HumanoidRootPart", (1 / 0))
		PrimaryPart = v1.PrimaryPart
		assert(PrimaryPart, "PrimaryPart not found")
	end

	return PrimaryPart
end
function t.Optional.PrimaryPartPosition(p1) --[[ Line: 107 | Upvalues: t (copy) ]]
	local v1 = t.Optional.PrimaryPart(p1)

	return if v1 then v1.Position or nil else nil
end
function t.PrimaryPartPosition(p1) --[[ Line: 113 | Upvalues: t (copy) ]]
	return t.PrimaryPart(p1).Position
end
function t.Optional.PrimaryPartCFrame(p1) --[[ Line: 117 | Upvalues: t (copy) ]]
	local v1 = t.Optional.PrimaryPart(p1)

	return if v1 then v1.CFrame or nil else nil
end
function t.PrimaryPartCFrame(p1) --[[ Line: 123 | Upvalues: t (copy) ]]
	return t.PrimaryPart(p1).CFrame
end
function t.Optional.Humanoid(p1) --[[ Line: 128 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	return if v1 then v1:FindFirstChildOfClass("Humanoid") else v1
end
function t.Humanoid(p1) --[[ Line: 134 | Upvalues: t (copy) ]]
	local v1 = t.Character(p1)
	local Humanoid = v1:FindFirstChildOfClass("Humanoid")

	if not Humanoid then
		v1:WaitForChild("Humanoid", (1 / 0))

		local Humanoid2 = v1:FindFirstChildOfClass("Humanoid")

		assert(Humanoid2, "Humanoid not found")
		Humanoid = Humanoid2
	end

	return Humanoid
end
function t.Optional.Part(p1, p2) --[[ Line: 148 | Upvalues: t (copy) ]]
	return t.Character(p1):FindFirstChild(p2)
end
function t.Part(p1, p2) --[[ Line: 153 | Upvalues: t (copy) ]]
	return t.Character(p1):WaitForChild(p2, (1 / 0))
end
function t.Optional.EmbeddedMotor6D(p1, p2, p3) --[[ Line: 158 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Part(p1, p2)

	return if v1 then v1:FindFirstChild(p3) else v1
end
function t.EmbeddedMotor6D(p1, p2, p3) --[[ Line: 164 | Upvalues: t (copy) ]]
	return t.Part(p1, p2):WaitForChild(p3, (1 / 0))
end
function t.Optional.Head(p1) --[[ Line: 169 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "Head")
end
function t.Head(p1) --[[ Line: 174 | Upvalues: t (copy) ]]
	return t.Part(p1, "Head")
end
function t.Optional.UpperTorso(p1) --[[ Line: 179 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "UpperTorso")
end
function t.UpperTorso(p1) --[[ Line: 184 | Upvalues: t (copy) ]]
	return t.Part(p1, "UpperTorso")
end
function t.Optional.Torso(p1) --[[ Line: 189 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "Torso")
end
function t.Torso(p1) --[[ Line: 194 | Upvalues: t (copy) ]]
	return t.Part(p1, "Torso")
end
function t.Optional.LowerTorso(p1) --[[ Line: 199 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LowerTorso")
end
function t.LowerTorso(p1) --[[ Line: 204 | Upvalues: t (copy) ]]
	return t.Part(p1, "LowerTorso")
end
function t.Optional.LeftFoot(p1) --[[ Line: 209 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LeftFoot")
end
function t.LeftFoot(p1) --[[ Line: 214 | Upvalues: t (copy) ]]
	return t.Part(p1, "LeftFoot")
end
function t.Optional.LeftHand(p1) --[[ Line: 219 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LeftHand")
end
function t.LeftHand(p1) --[[ Line: 224 | Upvalues: t (copy) ]]
	return t.Part(p1, "LeftHand")
end
function t.Optional.LeftLowerArm(p1) --[[ Line: 229 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LeftLowerArm")
end
function t.LeftLowerArm(p1) --[[ Line: 234 | Upvalues: t (copy) ]]
	return t.Part(p1, "LeftLowerArm")
end
function t.Optional.LeftLowerLeg(p1) --[[ Line: 239 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LeftLowerLeg")
end
function t.LeftLowerLeg(p1) --[[ Line: 244 | Upvalues: t (copy) ]]
	return t.Part(p1, "LeftLowerLeg")
end
function t.Optional.LeftUpperArm(p1) --[[ Line: 249 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LeftUpperArm")
end
function t.LeftUpperArm(p1) --[[ Line: 254 | Upvalues: t (copy) ]]
	return t.Part(p1, "LeftUpperArm")
end
function t.Optional.LeftUpperLeg(p1) --[[ Line: 259 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "LeftUpperLeg")
end
function t.LeftUpperLeg(p1) --[[ Line: 264 | Upvalues: t (copy) ]]
	return t.Part(p1, "LeftUpperLeg")
end
function t.Optional.RightFoot(p1) --[[ Line: 269 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "RightFoot")
end
function t.RightFoot(p1) --[[ Line: 274 | Upvalues: t (copy) ]]
	return t.Part(p1, "RightFoot")
end
function t.Optional.RightHand(p1) --[[ Line: 279 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "RightHand")
end
function t.RightHand(p1) --[[ Line: 284 | Upvalues: t (copy) ]]
	return t.Part(p1, "RightHand")
end
function t.Optional.RightLowerArm(p1) --[[ Line: 289 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "RightLowerArm")
end
function t.RightLowerArm(p1) --[[ Line: 294 | Upvalues: t (copy) ]]
	return t.Part(p1, "RightLowerArm")
end
function t.Optional.RightLowerLeg(p1) --[[ Line: 299 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "RightLowerLeg")
end
function t.RightLowerLeg(p1) --[[ Line: 304 | Upvalues: t (copy) ]]
	return t.Part(p1, "RightLowerLeg")
end
function t.Optional.RightUpperArm(p1) --[[ Line: 309 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "RightUpperArm")
end
function t.RightUpperArm(p1) --[[ Line: 314 | Upvalues: t (copy) ]]
	return t.Part(p1, "RightUpperArm")
end
function t.Optional.RightUpperLeg(p1) --[[ Line: 319 | Upvalues: t (copy) ]]
	return t.Optional.Part(p1, "RightUpperLeg")
end
function t.RightUpperLeg(p1) --[[ Line: 324 | Upvalues: t (copy) ]]
	return t.Part(p1, "RightUpperLeg")
end
function t.Optional.Root(p1) --[[ Line: 329 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LowerTorso", "Root")
end
function t.Root(p1) --[[ Line: 334 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LowerTorso", "Root")
end
function t.Optional.Waist(p1) --[[ Line: 339 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "UpperTorso", "Waist")
end
function t.Waist(p1) --[[ Line: 344 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "UpperTorso", "Waist")
end
function t.Optional.Neck(p1) --[[ Line: 349 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "Head", "Neck")
end
function t.Neck(p1) --[[ Line: 354 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "Head", "Neck")
end
function t.Optional.LeftAnkle(p1) --[[ Line: 359 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LeftFoot", "LeftAnkle")
end
function t.LeftAnkle(p1) --[[ Line: 364 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LeftFoot", "LeftAnkle")
end
function t.Optional.LeftWrist(p1) --[[ Line: 369 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LeftHand", "LeftWrist")
end
function t.LeftWrist(p1) --[[ Line: 374 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LeftHand", "LeftWrist")
end
function t.Optional.LeftElbow(p1) --[[ Line: 379 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LeftLowerArm", "LeftElbow")
end
function t.LeftElbow(p1) --[[ Line: 384 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LeftLowerArm", "LeftElbow")
end
function t.Optional.LeftKnee(p1) --[[ Line: 389 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LeftLowerLeg", "LeftKnee")
end
function t.LeftKnee(p1) --[[ Line: 394 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LeftLowerLeg", "LeftKnee")
end
function t.Optional.LeftShoulder(p1) --[[ Line: 399 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LeftUpperArm", "LeftShoulder")
end
function t.LeftShoulder(p1) --[[ Line: 404 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LeftUpperArm", "LeftShoulder")
end
function t.Optional.LeftHip(p1) --[[ Line: 409 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "LeftUpperLeg", "LeftHip")
end
function t.LeftHip(p1) --[[ Line: 414 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "LeftUpperLeg", "LeftHip")
end
function t.Optional.RightAnkle(p1) --[[ Line: 419 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "RightFoot", "RightAnkle")
end
function t.RightAnkle(p1) --[[ Line: 424 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "RightFoot", "RightAnkle")
end
function t.Optional.RightWrist(p1) --[[ Line: 429 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "RightHand", "RightWrist")
end
function t.RightWrist(p1) --[[ Line: 434 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "RightHand", "RightWrist")
end
function t.Optional.RightElbow(p1) --[[ Line: 439 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "RightLowerArm", "RightElbow")
end
function t.RightElbow(p1) --[[ Line: 444 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "RightLowerArm", "RightElbow")
end
function t.Optional.RightKnee(p1) --[[ Line: 449 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "RightLowerLeg", "RightKnee")
end
function t.RightKnee(p1) --[[ Line: 454 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "RightLowerLeg", "RightKnee")
end
function t.Optional.RightShoulder(p1) --[[ Line: 459 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "RightUpperArm", "RightShoulder")
end
function t.RightShoulder(p1) --[[ Line: 464 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "RightUpperArm", "RightShoulder")
end
function t.Optional.RightHip(p1) --[[ Line: 469 | Upvalues: t (copy) ]]
	return t.Optional.EmbeddedMotor6D(p1, "RightUpperLeg", "RightHip")
end
function t.RightHip(p1) --[[ Line: 474 | Upvalues: t (copy) ]]
	return t.EmbeddedMotor6D(p1, "RightUpperLeg", "RightHip")
end
function t.Optional.PlayerGui(p1) --[[ Line: 478 | Upvalues: t (copy) ]]
	return t.Player(p1):FindFirstChild("PlayerGui")
end
function t.PlayerGui(p1) --[[ Line: 483 | Upvalues: t (copy) ]]
	return t.Player(p1):WaitForChild("PlayerGui", (1 / 0))
end
function t.Mouse(p1) --[[ Line: 488 | Upvalues: t (copy) ]]
	return t.Player(p1):GetMouse()
end
function t.Camera() --[[ Line: 493 ]]
	return workspace.CurrentCamera
end
function t.Name(p1) --[[ Line: 498 | Upvalues: t (copy) ]]
	return t.Player(p1).Name
end
function t.DisplayName(p1) --[[ Line: 503 | Upvalues: t (copy) ]]
	return t.Player(p1).DisplayName
end
function t.Optional.GetAppliedDescription(p1) --[[ Line: 508 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Humanoid(p1)

	return if v1 then v1:GetAppliedDescription() else v1
end
function t.GetAppliedDescription(p1) --[[ Line: 514 | Upvalues: t (copy) ]]
	return t.Humanoid(p1):GetAppliedDescription()
end
function t.Optional.Animator(p1) --[[ Line: 519 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Humanoid(p1)

	if not v1 then
		return nil
	end

	local Animator = v1:FindFirstChildOfClass("Animator")

	if Animator then
		return Animator
	end

	local AnimationController = v1:FindFirstChildOfClass("AnimationController")

	if AnimationController then
		return AnimationController
	end

	return v1
end
function t.Animator(p1) --[[ Line: 539 | Upvalues: t (copy) ]]
	local v1 = t.Humanoid(p1)
	local Animator = v1:FindFirstChildOfClass("Animator")

	if Animator then
		return Animator
	end

	local AnimationController = v1:FindFirstChildOfClass("AnimationController")

	if AnimationController then
		return AnimationController
	end

	return v1
end
function t.Optional.Part(p1, p2) --[[ Line: 555 | Upvalues: t (copy) ]]
	return t.Character(p1):FindFirstChild(p2)
end
function t.Part(p1, p2) --[[ Line: 560 | Upvalues: t (copy) ]]
	return t.Character(p1):WaitForChild(p2, (1 / 0))
end
function t.Optional.EmbeddedMotor6D(p1, p2, p3) --[[ Line: 565 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Part(p1, p2)

	return if v1 then v1:FindFirstChild(p3) else v1
end
function t.EmbeddedMotor6D(p1, p2, p3) --[[ Line: 571 | Upvalues: t (copy) ]]
	return t.Part(p1, p2):WaitForChild(p3, (1 / 0))
end
function t.Optional.PrimaryPart(p1) --[[ Line: 576 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	return if v1 then v1.PrimaryPart else v1
end
function t.PrimaryPart(p1) --[[ Line: 582 | Upvalues: t (copy) ]]
	local v1 = t.Character(p1)
	local PrimaryPart = v1.PrimaryPart

	if not PrimaryPart then
		v1:WaitForChild("HumanoidRootPart", (1 / 0))
		PrimaryPart = v1.PrimaryPart
		assert(PrimaryPart)
	end

	return PrimaryPart
end
function t.Optional.HumanoidRootPart(p1) --[[ Line: 593 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	return if v1 then v1:FindFirstChild("HumanoidRootPart") else v1
end
function t.HumanoidRootPart(p1) --[[ Line: 598 | Upvalues: t (copy) ]]
	return t.Character(p1):WaitForChild("HumanoidRootPart")
end
function t.Optional.FeetCFrame(p1) --[[ Line: 605 | Upvalues: t (copy) ]]
	local v1 = t.Optional.Character(p1)

	if not v1 then
		return nil
	end

	local PrimaryPart = v1.PrimaryPart
	local Humanoid = v1:FindFirstChildOfClass("Humanoid")

	if PrimaryPart and Humanoid then
		return PrimaryPart.CFrame - PrimaryPart.CFrame.UpVector * (Humanoid.HipHeight + PrimaryPart.Size.Y * 0.5)
	end

	return nil
end
function t.FeetCFrame(p1) --[[ Line: 623 | Upvalues: t (copy) ]]
	local v1 = t.Optional.FeetCFrame(p1)

	if v1 then
		return v1
	end

	local v2 = t.PrimaryPart(p1)

	return v2.CFrame - v2.CFrame.UpVector * (t.Humanoid(p1).HipHeight + v2.Size.Y * 0.5)
end

return t