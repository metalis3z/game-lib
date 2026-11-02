-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Tween = require(game.ReplicatedStorage.Library.Functions.Tween)
local Audio = require(game.ReplicatedStorage.Library.Audio)
local NotificationInstance = require(script.Parent.NotificationInstance)
local Asserts = require(ReplicatedStorage.Library.Asserts)
local Interface = require(script.Types.Interface)
local Message = game.ReplicatedStorage.Assets.UI.Notifications.Bottom.Message
local t = {
	__types = Interface,
	GetTextFromData = function(p1, p2, p3) --[[ GetTextFromData | Line: 34 | Upvalues: Asserts (copy) ]]
		Asserts.string(p1)
		Asserts.optional.Color3(p2)
		Asserts.optional.Color3(p3)

		local v1 = if p3 then p3:ToHex() or "000000" else "000000"

		if p2 then
			return ("<stroke color=\"#%s\" joins=\"bevel\" thickness=\"3\" transparency=\"0\"><font color=\"#%s\">%s</font></stroke>"):format(v1, p2:ToHex(), p1)
		end

		return ("<stroke color=\"#%s\" joins=\"bevel\" thickness=\"3\" transparency=\"0\">%s</stroke>"):format(v1, p1)
	end
}

local function prepareNotif(p1, p2) --[[ prepareNotif | Line: 45 | Upvalues: Interface (copy), Message (copy), t (copy), Audio (copy), Tween (copy) ]]
	assert(Interface.MessageDataInterface(p1))

	local v1 = Message:Clone()
	local Message2 = p1.Message
	local Shadow = v1.Shadow
	local Frame = v1.Frame
	local TextLabel = Frame.TextLabel
	local PreText = Frame:FindFirstChild("PreText")

	if not (PreText and PreText:IsA("TextLabel")) then
		PreText = TextLabel:Clone()
		PreText.Name = "PreText"
		PreText.Parent = Frame
	end

	PreText.Visible = false
	PreText.Text = ""
	PreText.TextColor3 = TextLabel.TextColor3
	PreText.LayoutOrder = math.max(TextLabel.LayoutOrder + 1, 0)
	PreText.ZIndex = TextLabel.ZIndex

	if not p1.Color then
		p1.Color = Color3.fromRGB(255, 255, 255)
	end

	local v3 = nil

	if p1.Color then
		local ok, result = pcall(function() --[[ Line: 73 | Upvalues: p1 (copy) ]]
			return p1.Color:ToHex()
		end)

		if ok then
			v3 = string.lower(result)
		end
	end

	if p1.Size then
		v1.Size = p1.Size
	end

	if p1.Gradient then
		p1.Gradient:Clone().Parent = TextLabel
	end

	if p1.ShowShadow then
		Shadow.Visible = true
	else
		Shadow.Visible = false
	end

	TextLabel.Text = t.GetTextFromData(Message2, p1.Color, p1.StrokeColor)
	TextLabel.TextColor3 = p1.Color or TextLabel.TextColor3
	PreText.Text = ""
	PreText.Visible = false
	PreText.TextColor3 = TextLabel.TextColor3

	local PreText2 = p1.PreText

	if PreText2 then
		PreText.Text = t.GetTextFromData(PreText2.Text, PreText2.Color, PreText2.StrokeColor)
		PreText.Visible = PreText.Text ~= ""
	end

	if p1.Font then
		TextLabel.FontFace = p1.Font
	end

	if p1.Image then
		local Icon = v1.Frame:FindFirstChild("Icon")

		if Icon and Icon:IsA("ImageLabel") then
			Icon.Image = p1.Image
			Icon.Visible = true
		end
	end

	return v1, function() --[[ handleNotificationEffects | Line: 121 | Upvalues: p1 (copy), v3 (ref), Audio (ref), v1 (copy), Shadow (copy), Tween (ref) ]]
		if p1.Sound or v3 ~= "ff0000" then
			if p1.Sound then
				Audio.Play(p1.Sound, script, { 0.9, 1.1 }, 1)
			else
				Audio.Play("rbxassetid://133842042346471", script, { 0.8, 1.2 }, 0.6)
			end
		else
			Audio.Play(17208372272, script, 1, 1)
		end

		task.spawn(function() --[[ Line: 134 | Upvalues: v1 (ref), Shadow (ref), Tween (ref) ]]
			task.wait(0.65)

			if v1 and Shadow then
				Tween(Shadow, {
					ImageTransparency = 1
				}, { 3.1, "Sine", "Out" })
			end
		end)
	end
end

local function applyTextDedupe(p1, p2) --[[ applyTextDedupe | Line: 154 ]]
	if not p2.PreventDuplicateText then
		return
	end

	p2.DuplicateKey = p1.Message
end

function t.Top(p1, p2) --[[ Top | Line: 160 | Upvalues: prepareNotif (copy), NotificationInstance (copy) ]]
	local v1 = if p2 then table.clone(p2) else nil
	local v2 = v1 and v1.OnAppear or nil
	local v3 = v1 and v1.OnComplete or nil
	local v4 = if v1 then v1 else {}

	v4.Time = p1.Time
	v4.DelayInRound = p1.DelayInRound

	if v4.PreventDuplicateText then
		v4.DuplicateKey = p1.Message
	end

	if v4 then
		v4.OnAppear = nil
		v4.OnComplete = nil
	end

	local v5 = v4
	local v6, v7 = prepareNotif(p1, v5)

	local function onStart(p1) --[[ onStart | Line: 181 | Upvalues: v7 (copy), v2 (copy) ]]
		v7()

		if typeof(v2) ~= "function" then
			return
		end

		v2(p1)
	end

	local function onFinish(p1) --[[ onFinish | Line: 189 | Upvalues: v3 (copy) ]]
		if typeof(v3) ~= "function" then
			return
		end

		v3(p1)
	end

	return NotificationInstance.new(NotificationInstance.Locations.Message, v6, onStart, v5, onFinish)
end
function t.Bottom(p1, p2) --[[ Bottom | Line: 204 | Upvalues: prepareNotif (copy), NotificationInstance (copy) ]]
	local v1 = if p2 then table.clone(p2) else nil
	local v2 = v1 and v1.OnAppear or nil
	local v3 = v1 and v1.OnComplete or nil
	local v4 = if v1 then v1 else {}

	v4.Time = p1.Time
	v4.DelayInRound = p1.DelayInRound

	if v4.PreventDuplicateText then
		v4.DuplicateKey = p1.Message
	end

	if v4 then
		v4.OnAppear = nil
		v4.OnComplete = nil
	end

	local v5 = v4
	local v6, v7 = prepareNotif(p1, v5)

	local function onStart(p1) --[[ onStart | Line: 225 | Upvalues: v7 (copy), v2 (copy) ]]
		v7()

		if typeof(v2) ~= "function" then
			return
		end

		v2(p1)
	end

	local function onFinish(p1) --[[ onFinish | Line: 233 | Upvalues: v3 (copy) ]]
		if typeof(v3) ~= "function" then
			return
		end

		v3(p1)
	end

	return NotificationInstance.new(NotificationInstance.Locations.Bottom, v6, onStart, v5, onFinish)
end

return t