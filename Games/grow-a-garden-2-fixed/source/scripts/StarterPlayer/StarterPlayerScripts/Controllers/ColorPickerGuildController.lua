--credit to leon games studio
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local GuiController = require(LocalPlayer.PlayerScripts.Controllers.GuiController)
local v1 = Color3.fromRGB(255, 224, 0)
local t = {
	StartOrder = 6
}
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = false

local function FinishSession(p1) --[[ FinishSession | Line: 28 | Upvalues: v6 (ref), v7 (ref), v2 (ref), GuiController (copy) ]]
	local v1 = v6

	v6 = nil
	v7 = false

	if v2 and GuiController:IsOpen("ColorPickerGuild") then
		GuiController:Close()
	end

	if not v1 then
		return
	end

	local _, _2 = pcall(v1, p1)
end

local function ResolveRefs(p1) --[[ ResolveRefs | Line: 44 | Upvalues: v3 (ref), v4 (ref), v5 (ref) ]]
	local Backdrop = p1:FindFirstChild("Backdrop")
	local v1 = if Backdrop then Backdrop:FindFirstChild("ColorPicker") else Backdrop

	if not v1 then
		return
	end

	local CurrentColorValue = v1:FindFirstChild("CurrentColorValue")

	if CurrentColorValue and CurrentColorValue:IsA("Color3Value") then
		v3 = CurrentColorValue
	end

	local Buttons = v1:FindFirstChild("Buttons")

	if not Buttons then
		return
	end

	local ConfirmButton = Buttons:FindFirstChild("ConfirmButton")
	local CancelButton = Buttons:FindFirstChild("CancelButton")

	if ConfirmButton and ConfirmButton:IsA("GuiButton") then
		v4 = ConfirmButton
	end

	if not (CancelButton and CancelButton:IsA("GuiButton")) then
		return
	end

	v5 = CancelButton
end

local function BindButtons() --[[ BindButtons | Line: 67 | Upvalues: v4 (ref), v7 (ref), v3 (ref), v6 (ref), v2 (ref), GuiController (copy), v5 (ref) ]]
	if v4 then
		v4.MouseButton1Click:Connect(function() --[[ Line: 69 | Upvalues: v7 (ref), v3 (ref), v6 (ref), v2 (ref), GuiController (ref) ]]
			if not v7 then
				return
			end

			local v1 = if v3 then v3.Value else nil
			local v22 = v6

			v6 = nil
			v7 = false

			if v2 and GuiController:IsOpen("ColorPickerGuild") then
				GuiController:Close()
			end

			if not v22 then
				return
			end

			local _, _2 = pcall(v22, v1)
		end)
	end

	if not v5 then
		return
	end

	v5.MouseButton1Click:Connect(function() --[[ Line: 76 | Upvalues: v7 (ref), v6 (ref), v2 (ref), GuiController (ref) ]]
		if not v7 then
			return
		end

		local v1 = v6

		v6 = nil
		v7 = false

		if v2 and GuiController:IsOpen("ColorPickerGuild") then
			GuiController:Close()
		end

		if not v1 then
			return
		end

		local _, _2 = pcall(v1, nil)
	end)
end

function t.Init(p1) --[[ Init | Line: 84 ]] end
function t.Start(p1) --[[ Start | Line: 86 | Upvalues: PlayerGui (copy), v2 (ref), ResolveRefs (copy), BindButtons (copy), GuiController (copy), v7 (ref), v6 (ref) ]]
	task.spawn(function() --[[ Line: 87 | Upvalues: PlayerGui (ref), v2 (ref), ResolveRefs (ref), BindButtons (ref), GuiController (ref), v7 (ref), v6 (ref) ]]
		local ColorPickerGuild = PlayerGui:WaitForChild("ColorPickerGuild", 30)

		if ColorPickerGuild and ColorPickerGuild:IsA("ScreenGui") then
			v2 = ColorPickerGuild
			ColorPickerGuild.Enabled = false
			ResolveRefs(ColorPickerGuild)
			BindButtons()
			GuiController.GuiUnfocusedSignal:Connect(function(p1) --[[ Line: 97 | Upvalues: ColorPickerGuild (copy), v7 (ref), v6 (ref), v2 (ref), GuiController (ref) ]]
				if p1 ~= ColorPickerGuild or not v7 then
					return
				end

				local v1 = v6

				v6 = nil
				v7 = false

				if v2 and GuiController:IsOpen("ColorPickerGuild") then
					GuiController:Close()
				end

				if not v1 then
					return
				end

				local _, _2 = pcall(v1, nil)
			end)
		end
	end)
end
function t.RequestColor(p1, p2, p3) --[[ RequestColor | Line: 126 | Upvalues: v7 (ref), v6 (ref), v2 (ref), GuiController (copy), v3 (ref), v1 (copy) ]]
	if v7 then
		local v12 = v6

		v6 = nil
		v7 = false

		if v2 and GuiController:IsOpen("ColorPickerGuild") then
			GuiController:Close()
		end

		if v12 then
			local _, _2 = pcall(v12, nil)
		end
	end

	if not v2 then
		p3(nil)

		return
	end

	if v3 and v3.Value == Color3.new(0/255, 0/255, 0/255) then
		v3.Value = if p2 then p2 else v1
	end

	v6 = p3
	v7 = true
	GuiController:Open("ColorPickerGuild", nil, { "HUD" })
end
function t.GetCurrentColor(p1) --[[ GetCurrentColor | Line: 154 | Upvalues: v3 (ref) ]]
	if v3 then
		return v3.Value
	end

	return nil
end

return t