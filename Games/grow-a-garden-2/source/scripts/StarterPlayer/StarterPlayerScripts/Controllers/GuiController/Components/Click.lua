--credit to prince games studio
game:GetService("UserInputService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Signal = require(ReplicatedStorage.ClientModules.Signal)
local Trove = require(ReplicatedStorage.ClientModules.Trove)
local t = {}

t.__index = t
function t.new(p1, p2, p3, p4) --[[ new | Line: 11 | Upvalues: t (copy), Trove (copy), Signal (copy) ]]
	local v2 = setmetatable({}, t)

	v2.Cleaner = if p3 then p3 else Trove.new()
	v2.Clicked = Signal.new()

	if p4 then
		v2.MouseDown = Signal.new()
		v2.MouseUp = Signal.new()
	end

	v2.Button = p1
	v2._ClickedState = false
	v2:Init()

	return v2
end
function t.Init(p1) --[[ Init | Line: 30 ]]
	p1.Cleaner:Add(p1.Button.InputBegan:Connect(function(p12) --[[ Line: 31 | Upvalues: p1 (copy) ]]
		if not (if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch and p12.UserInputState == Enum.UserInputState.Begin then true else p12.KeyCode == Enum.KeyCode.ButtonA) then
			return
		end

		if not p1.MouseDown then
			p1._ClickedState = true

			return
		end

		p1.MouseDown:Fire()
		p1._ClickedState = true
	end))
	p1.Cleaner:Add(p1.Button.InputEnded:Connect(function(p12) --[[ Line: 45 | Upvalues: p1 (copy) ]]
		if not (if p12.UserInputType == Enum.UserInputType.MouseButton1 or p12.UserInputType == Enum.UserInputType.Touch then true else p12.KeyCode == Enum.KeyCode.ButtonA) then
			return
		end

		if p1.MouseUp then
			p1.MouseUp:Fire()
		end

		local v2 = p1:GetClickedState()

		p1._ClickedState = false

		if not v2 then
			return
		end

		p1.Clicked:Fire()
	end))
	p1.Cleaner:Add(p1.Button.Destroying:Once(function() --[[ Line: 64 | Upvalues: p1 (copy) ]]
		p1:Destroy()
	end))
end
function t.Destroy(p1) --[[ Destroy | Line: 69 ]]
	if p1.MouseDown then
		p1.MouseDown:DisconnectAll()
		p1.MouseDown:Destroy()
	end

	if p1.MouseUp then
		p1.MouseUp:DisconnectAll()
		p1.MouseUp:Destroy()
	end

	p1.Clicked:DisconnectAll()
	p1.Clicked:Destroy()
	p1.Cleaner:Destroy()
end
function t.GetClickedState(p1) --[[ GetClickedState | Line: 85 ]]
	return p1._ClickedState
end

return t