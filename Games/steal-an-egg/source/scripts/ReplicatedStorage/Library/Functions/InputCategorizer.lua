-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local UserInputService = game:GetService("UserInputService")
local v1 = Instance.new("BindableEvent")
local t = {
	KeyboardAndMouse = "KeyboardAndMouse",
	Gamepad = "Gamepad",
	Touch = "Touch",
	Unknown = "Unknown"
}
local t2 = {
	_initialized = false,
	InputCategory = t,
	lastInputCategoryChanged = v1.Event,
	_lastInputCategory = t.Unknown
}

function t2.getLastInputCategory() --[[ getLastInputCategory | Line: 37 | Upvalues: t2 (copy) ]]
	return t2._lastInputCategory
end
function t2._setLastInputCategory(p1) --[[ _setLastInputCategory | Line: 42 | Upvalues: t2 (copy), v1 (copy) ]]
	if t2._lastInputCategory == p1 then
		return
	end

	t2._lastInputCategory = p1
	v1:Fire(p1)
end
function t2._getCategoryOfInputType(p1) --[[ _getCategoryOfInputType | Line: 50 | Upvalues: t (copy) ]]
	if string.find(p1.Name, "Gamepad") then
		return t.Gamepad
	end

	if p1 == Enum.UserInputType.Keyboard or string.find(p1.Name, "Mouse") then
		return t.KeyboardAndMouse
	end

	if p1 == Enum.UserInputType.Touch then
		return t.Touch
	end

	return t.Unknown
end
function t2._onInputTypeChanged(p1) --[[ _onInputTypeChanged | Line: 62 | Upvalues: t2 (copy), t (copy) ]]
	local v1 = t2._getCategoryOfInputType(p1)

	if v1 == t.Unknown then
		return
	end

	t2._setLastInputCategory(v1)
end
function t2._getDefaultInputCategory() --[[ _getDefaultInputCategory | Line: 70 | Upvalues: UserInputService (copy), t2 (copy), t (copy) ]]
	local v2 = t2._getCategoryOfInputType((UserInputService:GetLastInputType()))

	if v2 ~= t.Unknown then
		return v2
	end

	if UserInputService.KeyboardEnabled and UserInputService.MouseEnabled then
		return t.KeyboardAndMouse
	end

	if UserInputService.TouchEnabled then
		return t.Touch
	end

	if UserInputService.GamepadEnabled then
		return t.Gamepad
	end

	warn("No input devices detected!")

	return t.Unknown
end
function t2._initialize() --[[ _initialize | Line: 90 | Upvalues: t2 (copy), UserInputService (copy) ]]
	assert(not t2._initialized, "InputCategorizer already initialized!")
	UserInputService.LastInputTypeChanged:Connect(t2._onInputTypeChanged)
	t2._setLastInputCategory((t2._getDefaultInputCategory()))
	t2._initialized = true
end
t2._initialize()

return t2