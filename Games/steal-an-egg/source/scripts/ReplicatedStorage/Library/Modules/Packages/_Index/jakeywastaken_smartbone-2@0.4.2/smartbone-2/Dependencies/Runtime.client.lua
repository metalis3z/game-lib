-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = script.Parent
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = false
local t = {}

local function c(p1) --[[ c | Line: 11 | Upvalues: t (copy) ]]
	table.insert(t, p1)
end

local function cleanup() --[[ cleanup | Line: 15 | Upvalues: t (copy) ]]
	for v1, v2 in t do
		v2:Disconnect()
	end
end

local v7 = nil

v7 = v1:BindToMessage("Setup", function(p1, p2, p3) --[[ Line: 22 | Upvalues: v2 (ref), v3 (ref), v4 (ref), v5 (ref), v6 (ref), v7 (ref) ]]
	v2 = p1
	v3 = p2
	v4 = p3
	v5 = require(p3)
	v6 = true
	v7:Disconnect()
end)

repeat
	task.wait()
until v6

local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local v8 = v5.new()
local Dependencies = v4.Dependencies
local DebugUi = require(Dependencies.DebugUi)
local v9 = nil
local Config = require(Dependencies.Config)
local Utilities = require(Dependencies.Utilities)
local v10 = RunService:IsStudio() or Config.ALLOW_LIVE_GAME_DEBUG
local OverlayEvent = v4:WaitForChild("OverlayEvent")
local v11 = false
local t2 = {
	Begin = function(...) --[[ Begin | Line: 52 | Upvalues: OverlayEvent (copy) ]]
		OverlayEvent:Fire("Begin", ...)
	end,
	End = function(...) --[[ End | Line: 55 | Upvalues: OverlayEvent (copy) ]]
		OverlayEvent:Fire("End", ...)
	end,
	Text = function(...) --[[ Text | Line: 58 | Upvalues: OverlayEvent (copy) ]]
		OverlayEvent:Fire("Text", ...)
	end
}

shared.FrameCounter = 0

if v10 then
	v9 = require(Dependencies.Iris)

	if not v9.HasInit() then
		v9 = v9.Init()
	end
end

v1.Name = ("%* - %*"):format(v2.Name, v8.ID)
v8:LoadObject(v2)

for v12, v13 in v3 do
	v8:LoadRawCollider(v13[1], v13[2])
end

local v14 = if v10 then {
	DRAW_BONE = v9.State(false),
	DRAW_PHYSICAL_BONE = v9.State(false),
	DRAW_ROOT_PART = v9.State(false),
	DRAW_BOUNDING_BOX = v9.State(false),
	DRAW_AXIS_LIMITS = v9.State(false),
	DRAW_COLLIDERS = v9.State(false),
	DRAW_COLLIDER_INFLUENCE = v9.State(false),
	DRAW_COLLIDER_AWAKE = v9.State(false),
	DRAW_COLLIDER_BROADPHASE = v9.State(false),
	DRAW_FILL_COLLIDERS = v9.State(false),
	DRAW_CONTACTS = v9.State(false),
	DRAW_ROTATION_LIMITS = v9.State(false),
	DRAW_ACCELERATION_INFO = v9.State(false)
} else nil

if v10 then
	v9:Connect(function() --[[ Line: 104 | Upvalues: v2 (ref), DebugUi (copy), v9 (ref), v8 (copy), v14 (ref) ]]
		if v2:GetAttribute("Debug") == nil then
			return
		end

		DebugUi(v9, v8, v14)
	end)
end

local v15 = CollectionService:GetInstanceAddedSignal("SmartCollider"):Connect(function(p1) --[[ Line: 111 | Upvalues: v2 (ref), Utilities (copy), v8 (copy) ]]
	if not p1:IsA("BasePart") then
		return
	end

	local v1 = p1:GetAttribute("ColliderKey")
	local v22 = v2:GetAttribute("ColliderKey")

	if tostring(v1) == tostring(v22) then
		v8:LoadRawCollider(Utilities.GetCollider(p1), p1)
	end
end)

table.insert(t, v15)

local v16 = v1:BindToMessage("Destroy", function() --[[ Line: 128 | Upvalues: v11 (ref) ]]
	v11 = true
end)

table.insert(t, v16)

local v17 = RunService.Heartbeat:ConnectParallel(function(p1) --[[ Line: 132 | Upvalues: v8 (copy), v11 (ref), t (copy), v1 (copy), v10 (copy), v2 (ref), v14 (ref), t2 (copy) ]]
	local v12 = shared

	v12.FrameCounter = v12.FrameCounter + 1

	if shared.FrameCounter > 131072 then
		shared.FrameCounter = 0
	end

	v8:StepBoneTrees(p1)

	if v8.ShouldDestroy or v11 then
		v8:Destroy()
		task.synchronize()

		for v22, v3 in t do
			v3:Disconnect()
		end

		v1:Destroy()
	else
		if not v10 or v2:GetAttribute("Debug") == nil then
			return
		end

		task.synchronize()
		v8:DrawDebug(v14.DRAW_COLLIDERS:get(), v14.DRAW_CONTACTS:get(), v14.DRAW_PHYSICAL_BONE:get(), v14.DRAW_BONE:get(), v14.DRAW_AXIS_LIMITS:get(), v14.DRAW_ROOT_PART:get(), v14.DRAW_FILL_COLLIDERS:get(), v14.DRAW_COLLIDER_INFLUENCE:get(), v14.DRAW_COLLIDER_AWAKE:get(), v14.DRAW_COLLIDER_BROADPHASE:get(), v14.DRAW_BOUNDING_BOX:get(), v14.DRAW_ROTATION_LIMITS:get(), v14.DRAW_ACCELERATION_INFO:get())
		v8:DrawOverlay(t2)
	end
end)

table.insert(t, v17)