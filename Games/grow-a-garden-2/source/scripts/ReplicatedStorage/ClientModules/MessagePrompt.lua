--credit to leon games studio
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local v1 = Color3.fromRGB(40, 40, 40)
local v2 = Color3.fromRGB(255, 255, 255)
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Message = PlayerGui:WaitForChild("Message")
local MainPage = Message:WaitForChild("MainPage")
local Header = MainPage:WaitForChild("Header")
local Title = Header:WaitForChild("Title")
local TextLabel = Title:WaitForChild("TextLabel")
local ExitButton = Header:WaitForChild("ExitButton")
local TextLabel2 = MainPage:WaitForChild("Content"):WaitForChild("Message"):WaitForChild("TextLabel")
local TextLabel3 = TextLabel2:WaitForChild("TextLabel")
local Options = MainPage:WaitForChild("Options")
local Template = Options:WaitForChild("Template")
local Controllers = LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("Controllers")
local GuiController = require(Controllers:WaitForChild("GuiController"))

Message.Enabled = false

local v3 = nil
local t = {}
local v4 = false
local v5 = nil
local v6 = nil
local v7 = false

local function StripFontColors(p1) --[[ StripFontColors | Line: 115 ]]
	return string.gsub(p1, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
		return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
	end)
end

local function SetTitle(p1) --[[ SetTitle | Line: 123 | Upvalues: TextLabel (copy), Title (copy) ]]
	TextLabel.Text = p1
	Title.Text = string.gsub(p1, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
		return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
	end)
end

local function SetMessage(p1) --[[ SetMessage | Line: 128 | Upvalues: TextLabel3 (copy), TextLabel2 (copy) ]]
	TextLabel3.Text = p1
	TextLabel2.Text = string.gsub(p1, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
		return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
	end)
end

local function DarkenColorSequence(p1) --[[ DarkenColorSequence | Line: 133 ]]
	local v1 = table.create(#p1.Keypoints)

	for v2, v3 in p1.Keypoints do
		local v4 = v3.Value

		v1[v2] = ColorSequenceKeypoint.new(v3.Time, Color3.new(v4.R * 0.6, v4.G * 0.6, v4.B * 0.6))
	end

	return ColorSequence.new(v1)
end

local function CreateDelayRing(p1) --[[ CreateDelayRing | Line: 148 | Upvalues: v1 (copy), v2 (copy) ]]
	local DelayRing = Instance.new("Frame")

	DelayRing.Name = "DelayRing"
	DelayRing.AnchorPoint = Vector2.new(1, 0)
	DelayRing.Position = UDim2.new(1, -4, 0, 4)
	DelayRing.Size = UDim2.fromScale(0.25, 0.55)
	DelayRing.BackgroundTransparency = 1
	DelayRing.ZIndex = 5

	local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")

	UIAspectRatioConstraint.AspectRatio = 1
	UIAspectRatioConstraint.Parent = DelayRing

	local Background = Instance.new("ImageLabel")

	Background.Name = "Background"
	Background.Size = UDim2.fromScale(1, 1)
	Background.BackgroundTransparency = 1
	Background.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
	Background.ImageColor3 = v1
	Background.ImageTransparency = 0.45
	Background.ZIndex = DelayRing.ZIndex
	Background.Parent = DelayRing

	local function MakeHalf(p1, p2) --[[ MakeHalf | Line: 171 | Upvalues: DelayRing (copy), v2 (ref) ]]
		local Frame = Instance.new("Frame")

		Frame.Name = p1
		Frame.Size = UDim2.fromScale(0.5, 1)
		Frame.Position = if p2 then UDim2.fromScale(0.5, 0) else UDim2.new()
		Frame.BackgroundTransparency = 1
		Frame.ClipsDescendants = true
		Frame.ZIndex = DelayRing.ZIndex + 1
		Frame.Parent = DelayRing

		local ProgressBarImage = Instance.new("ImageLabel")

		ProgressBarImage.Name = "ProgressBarImage"
		ProgressBarImage.Size = UDim2.fromScale(2, 1)
		ProgressBarImage.Position = if p2 then UDim2.fromScale(-1, 0) else UDim2.new()
		ProgressBarImage.BackgroundTransparency = 1
		ProgressBarImage.Image = "rbxasset://textures/ui/Controls/RadialFill.png"
		ProgressBarImage.ImageColor3 = v2
		ProgressBarImage.ZIndex = Frame.ZIndex
		ProgressBarImage.Parent = Frame

		local UIGradient = Instance.new("UIGradient")

		UIGradient.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.499, 0),
			NumberSequenceKeypoint.new(0.5, 1),
			NumberSequenceKeypoint.new(1, 1)
		})
		UIGradient.Parent = ProgressBarImage

		return UIGradient
	end

	local v12 = MakeHalf("RightHalf", true)
	local v22 = MakeHalf("LeftHalf", false)

	v12.Rotation = 180
	v22.Rotation = 360
	DelayRing.Parent = p1

	return {
		Frame = DelayRing,
		RightGradient = v12,
		LeftGradient = v22
	}
end

local function ResolveOptions(p1) --[[ ResolveOptions | Line: 218 ]]
	local v1 = if p1.options then p1.options elseif p1.yield == true then { "Yes", "No" } else { "Ok" }

	if #v1 > 2 then
		error("MessagePrompt.Prompt only supports 1 or 2 options", 3)
	end

	if #v1 == 0 then
		error("MessagePrompt.Prompt requires at least 1 option", 3)
	end

	local optionDelays = p1.optionDelays

	if optionDelays and #optionDelays ~= #v1 then
		error("MessagePrompt.Prompt optionDelays length must match options length", 3)
	end

	local v2 = table.create(#v1)

	for i = 1, #v1 do
		v2[i] = if optionDelays then optionDelays[i] else nil
	end

	return v1, v2
end

local function BeginSession() --[[ BeginSession | Line: 246 | Upvalues: v4 (ref), v6 (ref), GuiController (copy), Message (copy), v5 (ref) ]]
	if v4 then
		return
	end

	v4 = true
	v6 = GuiController:SnapshotHudStates()

	local Gui = GuiController.Gui

	v5 = if Gui and Gui ~= Message then Gui.Name else nil
	GuiController:Open("Message", true)
end

local function EndSession(p1) --[[ EndSession | Line: 270 | Upvalues: v4 (ref), v5 (ref), v6 (ref), GuiController (copy), Message (copy), PlayerGui (copy) ]]
	if not v4 then
		return
	end

	v4 = false

	local v1 = v5
	local v2 = v6

	v5 = nil
	v6 = nil

	if GuiController.Gui ~= Message then
		return
	end

	if p1 then
		GuiController:Close(true)
	elseif v1 and PlayerGui:FindFirstChild(v1) then
		GuiController:Open(v1, true)
	else
		GuiController:Close(true)
	end

	if not v2 then
		return
	end

	GuiController:RestoreHudStates(v2)
end

local v8 = nil

local function DrainQueue() --[[ DrainQueue | Line: 310 | Upvalues: v3 (ref), t (copy), v8 (ref) ]]
	if v3 then
		return
	end

	if #t ~= 0 then
		local v1 = table.remove(t, 1)

		v8(v1.Config, v1.Resume)
	end
end

v8 = function(p1, p2) --[[ Line: 317 | Upvalues: ResolveOptions (copy), ExitButton (copy), TextLabel (copy), Title (copy), Message (copy), v3 (ref), t (copy), v8 (ref), v7 (ref), EndSession (copy), TextLabel3 (copy), TextLabel2 (copy), Template (copy), Options (copy), DarkenColorSequence (copy), CreateDelayRing (copy), RunService (copy) ]]
	local v1, v2 = ResolveOptions(p1)
	local v32 = if #v1 == 1 then 1 else 2
	local v4 = if p1.hideClose == true then true else false
	local v5 = p1.titleOverride or "Alert"
	local v6 = false
	local t2 = {}
	local t3 = {}

	local function Respond(p12) --[[ Respond | Line: 328 | Upvalues: v6 (ref), t2 (copy), t3 (copy), ExitButton (ref), v5 (copy), TextLabel (ref), Title (ref), Message (ref), v3 (ref), p2 (copy), t (ref), v8 (ref), v7 (ref), p1 (copy), EndSession (ref) ]]
		if v6 then
			return
		end

		v6 = true

		for v1, v2 in t2 do
			v2:Disconnect()
		end

		table.clear(t2)

		for v32, v4 in t3 do
			v4:Destroy()
		end

		table.clear(t3)
		ExitButton.Visible = true
		ExitButton.Active = true

		local v52 = v5

		TextLabel.Text = v52
		Title.Text = string.gsub(v52, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
			return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
		end)
		Message.Enabled = false
		v3 = nil

		if p2 then
			task.spawn(p2, p12)
		end

		if not v3 and #t ~= 0 then
			local v62 = table.remove(t, 1)

			v8(v62.Config, v62.Resume)
		end

		if v3 or v7 then
			return
		end

		local v72 = p12 == 1

		EndSession(if p1.dontRestore == true or v72 and p1.dontRestoreOnSuccess == true then true else not v72 and p1.dontRestoreOnFail == true)
	end

	v3 = {
		Respond = Respond
	}
	TextLabel.Text = v5
	Title.Text = string.gsub(v5, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
		return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
	end)

	local message = p1.message

	TextLabel3.Text = message
	TextLabel2.Text = string.gsub(message, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
		return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
	end)
	ExitButton.Visible = not v4
	ExitButton.Active = not v4

	if not v4 then
		table.insert(t2, (ExitButton.Activated:Connect(function() --[[ Line: 376 | Upvalues: Respond (copy), v32 (copy) ]]
			Respond(v32)
		end)))
	end

	local function WireOptionClick(p1, p2) --[[ WireOptionClick | Line: 382 | Upvalues: Respond (copy), t2 (copy) ]]
		local v1 = p1.Activated:Connect(function() --[[ Line: 383 | Upvalues: Respond (ref), p2 (copy) ]]
			Respond(p2)
		end)

		table.insert(t2, v1)
	end

	for v82, v9 in v1 do
		local v10 = Template:Clone()

		v10.Name = ("Option%*"):format(v82)
		v10.Visible = true
		v10.LayoutOrder = v82

		local TextLabel4 = v10:WaitForChild("TextLabel")
		local TextLabel5 = TextLabel4:WaitForChild("TextLabel")

		TextLabel4.Text = v9
		TextLabel5.Text = v9

		local v12 = v10:WaitForChild(if v82 == 1 then "GreenGradient" else "RedGradient")

		v12.Enabled = true
		v10.Parent = Options
		table.insert(t3, v10)

		local v13 = v2[v82]

		if v13 and v13 > 0 then
			local Color = v12.Color

			v12.Color = DarkenColorSequence(Color)
			v10.Active = false
			v10.AutoButtonColor = false

			local v14 = CreateDelayRing(v10)
			local v15 = os.clock()
			local v16 = nil

			v16 = RunService.Heartbeat:Connect(function() --[[ Line: 417 | Upvalues: v6 (ref), v15 (copy), v13 (copy), v14 (copy), v16 (ref), v12 (copy), Color (copy), v10 (copy), v82 (copy), Respond (copy), t2 (copy) ]]
				if v6 then
					return
				end

				local v2 = math.max(0, 1 - (os.clock() - v15) / v13)
				local v3 = math.clamp(v2 * 360, 0, 360)

				v14.RightGradient.Rotation = math.clamp(v3, 0, 180)
				v14.LeftGradient.Rotation = math.clamp(v3, 180, 360)

				if not (v2 <= 0) then
					return
				end

				v16:Disconnect()

				if v6 then
					return
				end

				v14.Frame:Destroy()
				v12.Color = Color
				v10.Active = true
				v10.AutoButtonColor = true

				local v4 = v82
				local v5 = v10.Activated:Connect(function() --[[ Line: 383 | Upvalues: Respond (ref), v4 (copy) ]]
					Respond(v4)
				end)

				table.insert(t2, v5)
			end)

			local v17 = v16

			table.insert(t2, v17)

			continue
		end

		table.insert(t2, (v10.Activated:Connect(function() --[[ Line: 383 | Upvalues: Respond (copy), v82 (copy) ]]
			Respond(v82)
		end)))
	end

	local duration = p1.duration

	if not (duration and duration > 0) then
		Message.Enabled = true

		return
	end

	local v19 = os.clock()
	local v20 = nil

	v20 = RunService.Heartbeat:Connect(function() --[[ Line: 443 | Upvalues: v6 (ref), duration (copy), v19 (copy), v20 (ref), Respond (copy), v32 (copy), v5 (copy), TextLabel (ref), Title (ref) ]]
		if v6 then
			return
		end

		local v1 = duration - (os.clock() - v19)

		if v1 <= 0 then
			v20:Disconnect()
			Respond(v32)
		else
			local v3 = ("%* (%*s)"):format(v5, (math.max(1, (math.ceil(v1)))))

			TextLabel.Text = v3
			Title.Text = string.gsub(v3, "<font([^>]*)>", function(p1) --[[ Line: 116 ]]
				return "<font" .. string.gsub(string.gsub(p1, "%s*color%s*=%s*\"[^\"]*\"", ""), "%s*color%s*=%s*\'[^\']*\'", "") .. ">"
			end)
		end
	end)

	local v21 = v20

	table.insert(t2, v21)
	Message.Enabled = true
end

local function ForceResolveAll() --[[ ForceResolveAll | Line: 466 | Upvalues: v7 (ref), t (copy), v3 (ref) ]]
	v7 = true

	for v1, v2 in t do
		if v2.Resume then
			task.spawn(v2.Resume, 0)
		end
	end

	table.clear(t)

	if not v3 then
		v7 = false

		return
	end

	v3.Respond(0)
	v7 = false
end

local t2 = {
	Choices = table.freeze({
		Ok = table.freeze({ "Ok" }),
		YesNo = table.freeze({ "Yes", "No" }),
		ConfirmDeny = table.freeze({ "Confirm", "Deny" })
	}),
	Prompt = function(p1) --[[ Prompt | Line: 490 | Upvalues: ResolveOptions (copy), ForceResolveAll (copy), v4 (ref), v6 (ref), GuiController (copy), Message (copy), v5 (ref), v8 (ref), v3 (ref), t (copy) ]]
		ResolveOptions(p1)

		local isYield = p1.yield == true
		local v1 = if isYield then coroutine.running() else nil

		if p1.force then
			ForceResolveAll()

			if not v4 then
				v4 = true
				v6 = GuiController:SnapshotHudStates()

				local Gui = GuiController.Gui

				v5 = if Gui and Gui ~= Message then Gui.Name else nil
				GuiController:Open("Message", true)
			end

			v8(p1, v1)
		elseif v3 then
			table.insert(t, {
				Config = p1,
				Resume = v1
			})
		else
			if not v4 then
				v4 = true
				v6 = GuiController:SnapshotHudStates()

				local Gui = GuiController.Gui

				v5 = if Gui and Gui ~= Message then Gui.Name else nil
				GuiController:Open("Message", true)
			end

			v8(p1, v1)
		end

		if not isYield then
			return nil
		end

		return coroutine.yield() == 1
	end
}

return table.freeze(t2)