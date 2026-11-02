-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Signal = require(script.Parent.Parent.Signal)
local Trove = require(script.Parent.Parent.Trove)
local UserInputService = game:GetService("UserInputService")
local t = {}

t.__index = t
function t.new() --[[ new | Line: 81 | Upvalues: t (copy), Trove (copy), Signal (copy), UserInputService (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2.LeftDown = v2._trove:Construct(Signal)
	v2.LeftUp = v2._trove:Construct(Signal)
	v2.RightDown = v2._trove:Construct(Signal)
	v2.RightUp = v2._trove:Construct(Signal)
	v2.MiddleDown = v2._trove:Construct(Signal)
	v2.MiddleUp = v2._trove:Construct(Signal)
	v2.Scrolled = v2._trove:Construct(Signal)
	v2.Moved = v2._trove:Construct(Signal)
	v2._trove:Connect(UserInputService.InputBegan, function(p1, p2) --[[ Line: 95 | Upvalues: v2 (copy) ]]
		if p2 then
			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			v2.LeftDown:Fire()

			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton2 then
			v2.RightDown:Fire()

			return
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseButton3 then
			return
		end

		v2.MiddleDown:Fire()
	end)
	v2._trove:Connect(UserInputService.InputEnded, function(p1, p2) --[[ Line: 108 | Upvalues: v2 (copy) ]]
		if p2 then
			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton1 then
			v2.LeftUp:Fire()

			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseButton2 then
			v2.RightUp:Fire()

			return
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseButton3 then
			return
		end

		v2.MiddleUp:Fire()
	end)
	v2._trove:Connect(UserInputService.InputChanged, function(p1, p2) --[[ Line: 121 | Upvalues: v2 (copy) ]]
		if p2 then
			return
		end

		if p1.UserInputType == Enum.UserInputType.MouseMovement then
			local Position = p1.Position

			v2.Moved:Fire(Vector2.new(Position.X, Position.Y))

			return
		end

		if p1.UserInputType ~= Enum.UserInputType.MouseWheel then
			return
		end

		v2.Scrolled:Fire(p1.Position.Z)
	end)

	return v2
end
function t.IsLeftDown(p1) --[[ IsLeftDown | Line: 139 | Upvalues: UserInputService (copy) ]]
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
end
function t.IsRightDown(p1) --[[ IsRightDown | Line: 146 | Upvalues: UserInputService (copy) ]]
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
end
function t.IsMiddleDown(p1) --[[ IsMiddleDown | Line: 153 | Upvalues: UserInputService (copy) ]]
	return UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton3)
end
function t.GetPosition(p1) --[[ GetPosition | Line: 160 | Upvalues: UserInputService (copy) ]]
	return UserInputService:GetMouseLocation()
end
function t.GetDelta(p1) --[[ GetDelta | Line: 174 | Upvalues: UserInputService (copy) ]]
	return UserInputService:GetMouseDelta()
end
function t.GetRay(p1, p2) --[[ GetRay | Line: 182 | Upvalues: UserInputService (copy) ]]
	local v1 = if p2 then p2 else UserInputService:GetMouseLocation()

	return workspace.CurrentCamera:ViewportPointToRay(v1.X, v1.Y)
end
function t.Raycast(p1, p2, p3, p4) --[[ Raycast | Line: 209 ]]
	local v1 = p1:GetRay(p4)

	return workspace:Raycast(v1.Origin, v1.Direction * (p3 or 1000), p2)
end
function t.Project(p1, p2, p3) --[[ Project | Line: 241 ]]
	local v1 = p1:GetRay(p3)

	return v1.Origin + v1.Direction.Unit * (p2 or 1000)
end
function t.Lock(p1) --[[ Lock | Line: 255 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCurrentPosition
end
function t.LockCenter(p1) --[[ LockCenter | Line: 266 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end
function t.Unlock(p1) --[[ Unlock | Line: 273 | Upvalues: UserInputService (copy) ]]
	UserInputService.MouseBehavior = Enum.MouseBehavior.Default
end
function t.Destroy(p1) --[[ Destroy | Line: 280 ]]
	p1._trove:Destroy()
end

return t