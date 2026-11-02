-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Trove = require(script.Parent.Parent.Trove)
local Signal = require(script.Parent.Parent.Signal)
local UserInputService = game:GetService("UserInputService")
local t = {}

t.__index = t
function t.new() --[[ new | Line: 87 | Upvalues: t (copy), Trove (copy), Signal (copy), UserInputService (copy) ]]
	local v2 = setmetatable({}, t)

	v2._trove = Trove.new()
	v2.TouchTap = v2._trove:Construct(Signal.Wrap, UserInputService.TouchTap)
	v2.TouchTapInWorld = v2._trove:Construct(Signal.Wrap, UserInputService.TouchTapInWorld)
	v2.TouchMoved = v2._trove:Construct(Signal.Wrap, UserInputService.TouchMoved)
	v2.TouchLongPress = v2._trove:Construct(Signal.Wrap, UserInputService.TouchLongPress)
	v2.TouchPan = v2._trove:Construct(Signal.Wrap, UserInputService.TouchPan)
	v2.TouchPinch = v2._trove:Construct(Signal.Wrap, UserInputService.TouchPinch)
	v2.TouchRotate = v2._trove:Construct(Signal.Wrap, UserInputService.TouchRotate)
	v2.TouchSwipe = v2._trove:Construct(Signal.Wrap, UserInputService.TouchSwipe)
	v2.TouchStarted = v2._trove:Construct(Signal.Wrap, UserInputService.TouchStarted)
	v2.TouchEnded = v2._trove:Construct(Signal.Wrap, UserInputService.TouchEnded)

	return v2
end
function t.IsTouchEnabled(p1) --[[ IsTouchEnabled | Line: 109 | Upvalues: UserInputService (copy) ]]
	return UserInputService.TouchEnabled
end
function t.Destroy(p1) --[[ Destroy | Line: 116 ]]
	p1._trove:Destroy()
end

return t