-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
debug.profilebegin("ActiveAssetsController.CashCollected")

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Camera = workspace.Camera
local v1 = game.Players.LocalPlayer:GetMouse()
local t = {}

t.__index = t
function t.new() --[[ new | Line: 10 | Upvalues: t (copy), RunService (copy) ]]
	local t2 = {
		filterType = nil,
		collisionGroup = "Default",
		rayLength = 150,
		ticks = 1,
		filterDescendants = {},
		currentPosition = Vector2.new(0, 0),
		previousPosition = Vector2.new(0, 0)
	}

	setmetatable(t2, t)
	RunService:BindToRenderStep("MeasureMouseMovement", Enum.RenderPriority.Input.Value, function(p1) --[[ Line: 22 | Upvalues: t2 (copy) ]]
		if t2.ticks % 2 == 0 then
			t2.currentPosition = t2:GetPosition()
		else
			t2.previousPosition = t2:GetPosition()
		end

		t2.ticks = t2.ticks % 10 + 1
	end)

	return t2
end
function t.GetViewSize(p1) --[[ GetViewSize | Line: 34 | Upvalues: Camera (copy) ]]
	return Camera.ViewportSize
end
function t.GetPosition(p1) --[[ GetPosition | Line: 38 | Upvalues: UserInputService (copy) ]]
	return UserInputService:GetMouseLocation()
end
function t.GetUnitRay(p1) --[[ GetUnitRay | Line: 42 | Upvalues: Camera (copy) ]]
	local v1 = p1:GetPosition()

	return Camera:ViewportPointToRay(v1.x, v1.y)
end
function t.GetOrigin(p1) --[[ GetOrigin | Line: 47 ]]
	return p1:GetUnitRay().Origin
end
function t.GetDelta(p1) --[[ GetDelta | Line: 51 ]]
	return p1.currentPosition - p1.previousPosition
end
function t.ScreenPointToRay(p1) --[[ ScreenPointToRay | Line: 55 ]]
	local v1 = RaycastParams.new()

	v1.FilterDescendantsInstances = p1.filterDescendants
	v1.FilterType = p1.filterType
	v1.CollisionGroup = p1.collisionGroup

	return v1
end
function t.CastRay(p1) --[[ CastRay | Line: 63 ]]
	local v1 = p1:ScreenPointToRay()

	return workspace:Raycast(p1:GetOrigin(), p1:GetUnitRay().Direction * p1.rayLength, v1)
end
function t.GetHit(p1) --[[ GetHit | Line: 68 ]]
	local v1 = p1:CastRay()

	return if v1 then v1.Position or nil else nil
end
function t.GetTarget(p1) --[[ GetTarget | Line: 73 ]]
	local v1 = p1:CastRay()

	return if v1 then v1.Instance or nil else nil
end
function t.GetTargetFilter(p1) --[[ GetTargetFilter | Line: 78 ]]
	return p1.filterDescendants
end
function t.SetTargetFilter(p1, p2) --[[ SetTargetFilter | Line: 82 ]]
	local v1 = typeof(p2)

	if v1 == "Instance" then
		p1.filterDescendants = { p2 }

		return
	end

	if v1 == "table" then
		p1.filterDescendants = p2
	else
		error("object expected an instance or a table of instances, received: " .. v1)
	end
end
function t.SetCollisionGroup(p1, p2) --[[ SetCollisionGroup | Line: 95 ]]
	p1.collisionGroup = p2
end
function t.GetRayLength(p1) --[[ GetRayLength | Line: 99 ]]
	return p1.rayLength
end
function t.SetRayLength(p1, p2) --[[ SetRayLength | Line: 103 ]]
	local v1 = typeof(p2)

	assert(if v1 == "number" then if p2 >= 0 then true else false else false, "length expected a number, received: " .. v1)
	p1.rayLength = p2
end
function t.GetFilterType(p1) --[[ GetFilterType | Line: 113 ]]
	return p1.filterType
end
function t.SetFilterType(p1, p2) --[[ SetFilterType | Line: 117 ]]
	if table.find(Enum.RaycastFilterType:GetEnumItems(), p2) then
		p1.filterType = p2
	else
		error("Invalid raycast filter type provided")
	end
end
function t.EnableIcon() --[[ EnableIcon | Line: 127 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseIconEnabled = true
end
function t.DisableIcon() --[[ DisableIcon | Line: 131 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseIconEnabled = false
end
function t.ChangeIcon(p1, p2) --[[ ChangeIcon | Line: 135 | Upvalues: v1 (copy) ]]
	v1.Icon = p2
end

return t