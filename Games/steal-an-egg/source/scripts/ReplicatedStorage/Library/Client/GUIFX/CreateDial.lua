-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local GamepadService = game:GetService("GamepadService")
local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Library = ReplicatedStorage:WaitForChild("Library")
local Client = Library:WaitForChild("Client")
local Assets = ReplicatedStorage:WaitForChild("Assets")
local CircularBar = require(Client.GUIFX.CircularBar)
local Functions = require(Library.Functions)
local Audio = require(Library.Audio)
local Variables = require(Library.Variables)
local v1 = game.Players.LocalPlayer:GetMouse()
local ImageColor3 = Assets.UI.Items.Dial.Left.ImageColor3
local t = { 0.15, "Expo", "Out" }
local t2 = { 0.2, "Expo", "Out" }

local function cloneDial() --[[ cloneDial | Line: 42 | Upvalues: Assets (copy) ]]
	return Assets.UI.Items.Dial:Clone()
end

local function getScrollingFrame(p1) --[[ getScrollingFrame | Line: 46 ]]
	return p1:FindFirstAncestorOfClass("ScrollingFrame")
end

local function setScrollingEnabledIfNeeded(p1, p2) --[[ setScrollingEnabledIfNeeded | Line: 50 | Upvalues: Variables (copy) ]]
	if not Variables.Mobile then
		return
	end

	local v1 = p1:FindFirstAncestorOfClass("ScrollingFrame")

	if not v1 then
		return
	end

	v1.ScrollingEnabled = p2
end

return function(p1, p2, p3) --[[ CreateDial | Line: 61 | Upvalues: Assets (copy), Variables (copy), ImageColor3 (copy), Audio (copy), GamepadService (copy), Functions (copy), t (copy), v1 (copy), UserInputService (copy), RunService (copy), GuiService (copy), t2 (copy), CircularBar (copy) ]]
	local v12 = Assets.UI.Items.Dial:Clone()

	v12.Parent = p1

	local v2 = false
	local v3 = false
	local v4 = false
	local t3 = {}
	local v5 = 1
	local v6 = p2
	local v7 = nil
	local v8 = p3 or 1

	local function destroyDial() --[[ destroyDial | Line: 78 | Upvalues: t3 (copy), v12 (copy), v2 (ref), p1 (copy), Variables (ref) ]]
		for i, v in ipairs(t3) do
			v:Disconnect()
		end

		v12:Destroy()
		v2 = false

		if not Variables.Mobile then
			return
		end

		local v22 = p1:FindFirstAncestorOfClass("ScrollingFrame")

		if not v22 then
			return
		end

		v22.ScrollingEnabled = true
	end

	local function updateDial() --[[ updateDial | Line: 88 | Upvalues: v12 (copy), v8 (copy), v6 (ref), ImageColor3 (ref), p2 (copy), v7 (ref), Audio (ref), v5 (ref) ]]
		if v12:GetAttribute("IsLocked") then
			return
		end

		local v1 = v8 > 1
		local v2 = v1 and (if v6 % v8 == 0 then true else v6 > 100)
		local v4 = if v8 <= v6 then true else false

		v12.Quantity.Text = tostring(v6)

		if v1 then
			v12.Quantity.TextColor3 = v6 > 0 and (v2 and Color3.new(255/255, 255/255, 255/255) or Color3.fromRGB(181, 181, 181)) or Color3.fromRGB(255, 205, 205)
		else
			v12.Quantity.TextColor3 = v6 > 0 and Color3.new(255/255, 255/255, 255/255) or Color3.fromRGB(255, 205, 205)
		end

		if v1 then
			v12.Left.ImageColor3 = v2 and ImageColor3 or (v4 and Color3.fromRGB(255, 233, 65) or Color3.fromRGB(85, 85, 85))
			v12.Right.ImageColor3 = v2 and ImageColor3 or (v4 and Color3.fromRGB(255, 233, 65) or Color3.fromRGB(85, 85, 85))
		end

		v12:SetAttribute("Progress", (math.clamp(v6 / p2, 0.001, 0.999)))
		v12:SetAttribute("Quantity", v6)

		if v7 == v6 then
			return
		end

		v7 = v6
		Audio.Play("rbxassetid://96979035335854", script, v5 + 1, 0.1)
	end

	local function startTracking(p12) --[[ startTracking | Line: 130 | Upvalues: v12 (copy), v2 (ref), Variables (ref), GamepadService (ref), p1 (copy), Functions (ref), t (ref), v1 (ref), UserInputService (ref), p2 (copy), v6 (ref), v8 (copy), v5 (ref), updateDial (copy), RunService (ref), GuiService (ref) ]]
		if v12:GetAttribute("IsLocked") then
			return
		end

		if v2 then
			return
		end

		Variables.DisableInfoOverlay = true
		v2 = true
		v12:SetAttribute("Tracking", true)

		if Variables.Console then
			GamepadService:EnableGamepadCursor(p1)

			local v13 = p1:FindFirstAncestorOfClass("ScrollingFrame")

			if v13 then
				v13.ScrollingEnabled = false
			end
		end

		local v22 = p1

		if Variables.Mobile then
			local v3 = v22:FindFirstAncestorOfClass("ScrollingFrame")

			if v3 then
				v3.ScrollingEnabled = false
			end
		end

		Functions.Tween(v12, {
			Size = UDim2.fromScale(0.75, 1)
		}, t)
		Functions.Tween(v12.Deadzone, {
			BackgroundTransparency = 0
		}, t)
		Functions.Tween(v12.Deadzone.zero, {
			TextTransparency = 0
		}, t)

		local v4 = 0

		task.spawn(function() --[[ Line: 166 | Upvalues: v2 (ref), v12 (ref), v1 (ref), v4 (ref), UserInputService (ref), p12 (ref), p2 (ref), v6 (ref), v8 (ref), v5 (ref), updateDial (ref), RunService (ref), Variables (ref), GamepadService (ref), p1 (ref), GuiService (ref) ]]
			while v2 do
				local v22 = Vector2.new(v1.X, v1.Y) - (v12.AbsolutePosition + v12.AbsoluteSize / 2)
				local v42 = (math.deg((math.atan2(v22.Y, v22.X))) + 90) % 360
				local v62 = (if v42 <= 6 or v42 >= 354 then 0 else (v42 - 6) / 348 * 360) / 360

				if (v62 >= 1 or v62 <= 0.25) and v4 > 0.75 then
					v62 = 1
				elseif (v62 <= 0 or v62 >= 0.75) and v4 < 0.25 then
					v62 = 0
				else
					v4 = v62
				end

				local v7 = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift)
				local v82 = UserInputService:IsKeyDown(Enum.KeyCode.LeftControl)

				if not v7 and p12 and (if v62 <= 0 then true else false) then
					v62 = 1
					v4 = 1
				else
					p12 = false
				end

				v6 = if p2 >= 100000 then math.round(math.floor(p2 * v62 / 100 + 0.5) * 100) elseif p2 >= 10000 then math.round(math.floor(p2 * v62 / 25 + 0.5) * 25) elseif p2 >= 1000 then math.round(math.floor(p2 * v62 / 5 + 0.5) * 5) else math.round(p2 * v62)

				if v8 * 5 <= p2 then
					local v17 = v6 % v8

					v6 = if v8 / 2 <= v17 then v6 + v8 - v17 else v6 - v17
				end

				v6 = math.clamp(v6, 0, p2)

				if v82 then
					v6 = 1
				end

				v5 = v62
				updateDial()
				RunService.RenderStepped:Wait()
			end

			v12:SetAttribute("Tracking", false)

			if Variables.Console then
				GamepadService:DisableGamepadCursor()

				local v20 = p1:FindFirstAncestorOfClass("ScrollingFrame")

				if v20 then
					v20.ScrollingEnabled = true
				end

				GuiService.SelectedObject = p1

				if not GuiService.GuiNavigationEnabled then
					GuiService.GuiNavigationEnabled = true
				end
			end

			Variables.DisableInfoOverlay = false
		end)
	end

	local function stopTracking() --[[ stopTracking | Line: 246 | Upvalues: v2 (ref), Variables (ref), p1 (copy), v6 (ref), destroyDial (copy), Functions (ref), v12 (copy), t2 (ref), t (ref) ]]
		if not v2 then
			return
		end

		Variables.DisableInfoOverlay = false

		local v1 = p1

		if Variables.Mobile then
			local v22 = v1:FindFirstAncestorOfClass("ScrollingFrame")

			if v22 then
				v22.ScrollingEnabled = true
			end
		end

		v2 = false

		if v6 == 0 then
			destroyDial()
		else
			local v3 = Functions.Tween(v12, {
				Size = UDim2.fromScale(0.35, 1)
			}, t2)

			Functions.Tween(v12.Deadzone, {
				BackgroundTransparency = 1
			}, t2)
			Functions.Tween(v12.Deadzone.zero, {
				TextTransparency = 1
			}, t)
			v3.Completed:Wait()
		end
	end

	local function initializeDial() --[[ initializeDial | Line: 272 | Upvalues: p2 (copy), v8 (copy), startTracking (copy), t3 (copy), p1 (copy), Variables (ref), v3 (ref), UserInputService (ref), v4 (ref), stopTracking (copy), updateDial (copy) ]]
		if not (p2 < v8) then
			startTracking(true)
			t3[#t3 + 1] = p1.MouseButton1Down:Connect(function() --[[ Line: 279 | Upvalues: p1 (ref), Variables (ref), v3 (ref), startTracking (ref) ]]
				local v1 = p1

				if Variables.Mobile then
					local v2 = v1:FindFirstAncestorOfClass("ScrollingFrame")

					if v2 then
						v2.ScrollingEnabled = false
					end
				end

				if not v3 then
					v3 = true
					startTracking(false)
					v3 = false
				end
			end)
			t3[#t3 + 1] = UserInputService.InputEnded:Connect(function(p1, p2) --[[ Line: 291 | Upvalues: v4 (ref), stopTracking (ref) ]]
				local v1 = if p1.UserInputType == Enum.UserInputType.MouseButton1 then true elseif p1.UserInputType == Enum.UserInputType.Touch then true else false

				if v4 or not (v1 or (if p1.UserInputType == Enum.UserInputType.Gamepad1 then p1.KeyCode == Enum.KeyCode.ButtonA else false)) then
					return
				end

				v4 = true
				stopTracking()
				v4 = false
			end)
			updateDial()
		end
	end

	local function setValue(p1) --[[ setValue | Line: 307 | Upvalues: stopTracking (copy), v6 (ref), p2 (copy), updateDial (copy) ]]
		stopTracking()
		v6 = math.clamp(p1, 0, p2)
		updateDial()
	end

	v12:GetAttributeChangedSignal("IsLocked"):Connect(function() --[[ Line: 313 | Upvalues: v12 (copy), stopTracking (copy) ]]
		if not v12:GetAttribute("IsLocked") then
			return
		end

		stopTracking()
	end)
	CircularBar(v12)
	initializeDial()

	return v12, destroyDial, setValue
end