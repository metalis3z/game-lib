-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Constants = require(ReplicatedStorage.Library.Globals.Constants)
local Tween = require(ReplicatedStorage.Library.Functions.Tween)
local InteractSound = require(script.Parent.InteractSound)
local Log = require(ReplicatedStorage.Library.Modules.Packages.Log)
local Signal = require(ReplicatedStorage.Library.Signal)
local Trove = require(ReplicatedStorage.Library.Modules.Packages.Trove)
local Variables = require(ReplicatedStorage.Library.Variables)
local BUTTON_MOUSE_DOWN_SOUND = Constants.BUTTON_FX.BUTTON_MOUSE_DOWN_SOUND
local BUTTON_CLOSE_SOUND = Constants.BUTTON_FX.BUTTON_CLOSE_SOUND
local t = {}

Log.new():AtInfo():Log("Button effects initialized")

local function emptyCleanup() --[[ emptyCleanup | Line: 39 ]] end

return function(p1, p2, p3, p4) --[[ Line: 46 | Upvalues: Asserts (copy), t (copy), emptyCleanup (copy), Trove (copy), BUTTON_CLOSE_SOUND (copy), Tween (copy), Signal (copy), Variables (copy), InteractSound (copy), BUTTON_MOUSE_DOWN_SOUND (copy) ]]
	Asserts.GuiButton(p1)
	Asserts.optional.number(p2)
	Asserts.optional.func(p3)

	local v1 = false
	local v2 = false
	local v3 = p2 or 1.2
	local v4 = p4 or (if p1:GetAttribute("MuteSounds") == true then true else false)

	if t[p1] then
		return emptyCleanup
	end

	t[p1] = true

	local v5 = Trove.new()
	local v7 = nil

	if p1:IsA("ImageButton") and (if p1.Image == BUTTON_CLOSE_SOUND then true else false) then
		for v9, v10 in p1:GetChildren() do
			if v10:IsA("TextLabel") and v10.Text == "X" then
				v7 = v10

				break
			end
		end
	end

	local v11

	if v7 then
		if v7:FindFirstChildOfClass("UIScale") then
			v11 = v7:FindFirstChildOfClass("UIScale")
		else
			local ButtonUIScale = Instance.new("UIScale")

			ButtonUIScale.Name = "ButtonUIScale"
			ButtonUIScale.Parent = v7
			v11 = ButtonUIScale
		end
	else
		v11 = nil
	end

	local UIScale = p1:FindFirstChildOfClass("UIScale")
	local v12

	if UIScale then
		v12 = UIScale
	else
		local ButtonUIScale = Instance.new("UIScale")

		ButtonUIScale.Name = "ButtonUIScale"
		ButtonUIScale.Parent = p1
		v12 = ButtonUIScale
	end

	v12:SetAttribute("ButtonFXOwned", true)

	local function handlePress() --[[ handlePress | Line: 104 | Upvalues: v1 (ref), v2 (ref), Tween (ref), v12 (ref), v11 (ref), v7 (ref) ]]
		if v1 then
			return
		end

		v1 = true
		v2 = false
		Tween(v12, {
			Scale = 0.9
		}, { 0.065, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out })

		if not (v11 and v7) then
			return
		end

		Tween(v11, {
			Scale = 0.9
		}, { 0.065, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out })
		Tween(v7, {
			Position = UDim2.fromScale(0.5, 0.6)
		}, { 0.065, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out })
	end

	local function handleRelease() --[[ handleRelease | Line: 130 | Upvalues: v1 (ref), Tween (ref), v12 (ref), v11 (ref), v7 (ref) ]]
		if not v1 then
			return
		end

		v1 = false
		Tween(v12, {
			Scale = 1
		}, { 0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out })

		if not (v11 and v7) then
			return
		end

		Tween(v11, {
			Scale = 1
		}, { 0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out })
		Tween(v7, {
			Position = UDim2.fromScale(0.5, 0.5)
		}, { 0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out })
	end

	local function handleUnhover() --[[ handleUnhover | Line: 155 | Upvalues: v2 (ref), v1 (ref), v11 (ref), v7 (ref), Tween (ref), v12 (ref) ]]
		if not v2 then
			return
		end

		v2 = false

		if v1 then
			if v11 and v7 then
				Tween(v7, {
					Position = UDim2.fromScale(0.5, 0.5)
				}, { 0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out })
			end
		else
			Tween(v12, {
				Scale = 1
			}, { 0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })

			if not v11 then
				return
			end

			Tween(v11, {
				Scale = 1
			}, { 0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out })
		end
	end

	local function handleHover() --[[ handleHover | Line: 185 | Upvalues: v2 (ref), v1 (ref), Tween (ref), v12 (ref), v3 (copy), v11 (ref) ]]
		if v2 then
			return
		end

		v2 = true

		if v1 then
			return
		end

		Tween(v12, {
			Scale = v3
		}, { 0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out })

		if not v11 then
			return
		end

		Tween(v11, {
			Scale = v3
		}, { 0.7, Enum.EasingStyle.Circular, Enum.EasingDirection.Out })
	end

	if p3 then
		v5:Add(p1.Activated:Connect(p3))
		v5:Add(Signal.Fired("Console: Released Button"):Connect(function(p12) --[[ Line: 211 | Upvalues: p1 (copy), p3 (copy) ]]
			if p12 ~= p1 then
				return
			end

			p3()
		end))
	end

	v5:Add(p1.InputBegan:Connect(function(p12) --[[ Line: 218 | Upvalues: p1 (copy), handlePress (copy) ]]
		if not p1.Active then
			return
		end

		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 and (p12.UserInputType ~= Enum.UserInputType.Touch or p12.UserInputState ~= Enum.UserInputState.Begin) and p12.KeyCode ~= Enum.KeyCode.ButtonA then
			return
		end

		handlePress()
	end))
	v5:Add(p1.InputEnded:Connect(function(p12) --[[ Line: 232 | Upvalues: p1 (copy), handleRelease (copy) ]]
		if not p1.Active then
			return
		end

		if p12.UserInputType ~= Enum.UserInputType.MouseButton1 and (p12.UserInputType ~= Enum.UserInputType.Touch and p12.KeyCode ~= Enum.KeyCode.ButtonA) then
			return
		end

		handleRelease()
	end))
	v5:Add(p1.MouseEnter:Connect(function() --[[ Line: 246 | Upvalues: p1 (copy), Variables (ref), handleHover (copy) ]]
		if not p1.Active then
			return
		end

		if not Variables.Desktop then
			return
		end

		handleHover()
	end))
	v5:Add(p1.MouseLeave:Connect(function() --[[ Line: 256 | Upvalues: p1 (copy), Variables (ref), handleUnhover (copy) ]]
		if not p1.Active then
			return
		end

		if not Variables.Desktop then
			return
		end

		handleUnhover()
	end))

	local v13 = if v4 then nil else InteractSound(p1, "mousedown", BUTTON_MOUSE_DOWN_SOUND, 1.8, true)

	if v13 ~= nil then
		v5:Add(v13)
	end

	local v14 = false

	local function cleanup() --[[ cleanup | Line: 279 | Upvalues: v14 (ref), v5 (copy), v12 (ref), v11 (ref), v7 (ref), t (ref), p1 (copy) ]]
		if v14 then
			return
		end

		v14 = true
		v5:Destroy()

		if v12 and v12.Parent then
			v12.Scale = 1
		end

		if v11 and v7 then
			v7.Position = UDim2.fromScale(0.5, 0.5)
			v11.Scale = 1
		end

		t[p1] = nil
	end

	v5:Add(p1.Destroying:Connect(cleanup))

	return cleanup
end