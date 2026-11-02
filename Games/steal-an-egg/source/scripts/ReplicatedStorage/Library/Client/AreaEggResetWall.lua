-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Easing = require(ReplicatedStorage.Library.Functions.Easing)
local RenderStepped = require(ReplicatedStorage.Library.Functions.RenderStepped)
local Signal = require(ReplicatedStorage.Library.Modules.Packages.Signal)
local __OBJECTS = Workspace.__OBJECTS

assert(__OBJECTS:IsA("Folder"), "Workspace.__OBJECTS must be a Folder")

local Areas = __OBJECTS.Areas

assert(Areas:IsA("Folder"), "Workspace.__OBJECTS.Areas must be a Folder")

local WallStartVisual = Areas.WallStartVisual

assert(WallStartVisual:IsA("BasePart"), "Workspace.__OBJECTS.Areas.WallStartVisual must be a BasePart")

local WallStartCollision = Areas.WallStartCollision
local Size = WallStartVisual.Size
local v4 = WallStartVisual.CFrame * CFrame.new(0, -Size.Y * 0.5, 0)
local v5 = nil
local v6 = false

WallStartVisual.CanCollide = false

local t = {
	Changed = Signal.new()
}

local function wallHeight(p1) --[[ wallHeight | Line: 39 | Upvalues: Size (copy), WallStartVisual (copy), v4 (copy) ]]
	local v1 = math.clamp(p1, 0, Size.Y)

	WallStartVisual.Size = Vector3.new(Size.X, v1, Size.Z)
	WallStartVisual.CFrame = v4 * CFrame.new(0, v1 * 0.5, 0)
end

local function collisionState(p1) --[[ collisionState | Line: 45 | Upvalues: WallStartCollision (copy) ]]
	if WallStartCollision:IsA("BasePart") then
		WallStartCollision.CanCollide = p1
	end

	for i, v in ipairs(WallStartCollision:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = p1
		end
	end
end

local function publishClosed(p1) --[[ publishClosed | Line: 56 | Upvalues: v6 (ref), t (copy) ]]
	if v6 ~= p1 then
		v6 = p1
		t.Changed:Fire(p1)
	end
end

local function interruptAnimation() --[[ interruptAnimation | Line: 64 | Upvalues: v5 (ref) ]]
	if v5 == nil then
		return
	end

	v5:Disconnect()
	v5 = nil
end

local function animateHeight(p1, p2, p3, p4, p5) --[[ animateHeight | Line: 71 | Upvalues: v5 (ref), Size (copy), WallStartVisual (copy), v4 (copy), RenderStepped (copy), Easing (copy) ]]
	if v5 ~= nil then
		v5:Disconnect()
		v5 = nil
	end

	local Y = Size.Y
	local v1 = math.clamp(p1, 0, Y)
	local v2 = WallStartVisual
	local X = Size.X
	local Z = Size.Z

	v2.Size = Vector3.new(X, v1, Z)
	WallStartVisual.CFrame = v4 * CFrame.new(0, v1 * 0.5, 0)

	local v3 = RenderStepped(function(p12, p22) --[[ Line: 80 | Upvalues: Easing (ref), p4 (copy), p5 (copy), p1 (copy), p2 (copy), Size (ref), WallStartVisual (ref), v4 (ref) ]]
		local v2 = math.clamp(p1 + (p2 - p1) * Easing(p22, p4, p5), 0, Size.Y)

		WallStartVisual.Size = Vector3.new(Size.X, v2, Size.Z)
		WallStartVisual.CFrame = v4 * CFrame.new(0, v2 * 0.5, 0)

		return false
	end, p3, true)

	v5 = v3
	v3:Wait()

	if v3 ~= v3 then
		return
	end

	v5 = nil

	local Y2 = Size.Y
	local v42 = math.clamp(p2, 0, Y2)
	local v52 = WallStartVisual
	local X2 = Size.X
	local Z2 = Size.Z

	v52.Size = Vector3.new(X2, v42, Z2)
	WallStartVisual.CFrame = v4 * CFrame.new(0, v42 * 0.5, 0)
end

function t.GetVisualWallPart() --[[ GetVisualWallPart | Line: 97 | Upvalues: WallStartVisual (copy) ]]
	return WallStartVisual
end
function t.SetCollisionEnabled(p1)
	collisionState(p1)
end
function t.IsClosed() --[[ IsClosed | Line: 101 | Upvalues: v6 (ref) ]]
	return v6
end
function t.PrepareReveal() --[[ PrepareReveal | Line: 105 | Upvalues: v5 (ref), collisionState (copy), v6 (ref), t (copy), Size (copy), WallStartVisual (copy), v4 (copy) ]]
	if v5 ~= nil then
		v5:Disconnect()
		v5 = nil
	end

	collisionState(true)

	local v1, v2, v42, v52

	if v6 == true then
		local v3

		v1 = Size.Y
		v2 = math.clamp(0, 0, v1)
		v3 = WallStartVisual
		v42 = Size.X
		v52 = Size.Z
		WallStartVisual.Size = Vector3.new(v42, v2, v52)
		WallStartVisual.CFrame = v4 * CFrame.new(0, v2 * 0.5, 0)

		return
	end

	v6 = true
	t.Changed:Fire(v6)
	v1 = Size.Y
	v2 = math.clamp(0, 0, v1)
	v42 = Size.X
	v52 = Size.Z
	WallStartVisual.Size = Vector3.new(v42, v2, v52)
	WallStartVisual.CFrame = v4 * CFrame.new(0, v2 * 0.5, 0)
end
function t.Reveal() --[[ Reveal | Line: 112 | Upvalues: animateHeight (copy), Size (copy) ]]
	animateHeight(0, Size.Y, 1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out)
end
function t.GetVisualWall() --[[ GetVisualWall | Line: 116 | Upvalues: WallStartVisual (copy) ]]
	return WallStartVisual
end
function t.Collapse() --[[ Collapse | Line: 120 | Upvalues: collisionState (copy), v6 (ref), t (copy), animateHeight (copy), WallStartVisual (copy) ]]
	collisionState(false)

	if v6 == false then
		animateHeight(WallStartVisual.Size.Y, 0, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		return
	end

	v6 = false
	t.Changed:Fire(v6)
	animateHeight(WallStartVisual.Size.Y, 0, 0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
end
function t.Reset() --[[ Reset | Line: 126 | Upvalues: v5 (ref), collisionState (copy), v6 (ref), t (copy), Size (copy), WallStartVisual (copy), v4 (copy) ]]
	if v5 ~= nil then
		v5:Disconnect()
		v5 = nil
	end

	collisionState(false)

	local v1, v2, v42, v52

	if v6 == false then
		local v3

		v1 = Size.Y
		v2 = math.clamp(0, 0, v1)
		v3 = WallStartVisual
		v42 = Size.X
		v52 = Size.Z
		WallStartVisual.Size = Vector3.new(v42, v2, v52)
		WallStartVisual.CFrame = v4 * CFrame.new(0, v2 * 0.5, 0)

		return
	end

	v6 = false
	t.Changed:Fire(v6)
	v1 = Size.Y
	v2 = math.clamp(0, 0, v1)
	v42 = Size.X
	v52 = Size.Z
	WallStartVisual.Size = Vector3.new(v42, v2, v52)
	WallStartVisual.CFrame = v4 * CFrame.new(0, v2 * 0.5, 0)
end

return t