--credit to prince games studio
local t = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local v1 = LocalPlayer:GetMouse()
local TextTooltip = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Tooltip"):WaitForChild("TextTooltip")
local v2 = nil
local v3 = false
local v4 = nil
local HoverSFX = game.SoundService.SFX.HoverSFX
local v5 = nil

local function resolveTextLabel(p1) --[[ resolveTextLabel | Line: 18 ]]
	if p1:IsA("TextLabel") or p1:IsA("TextButton") then
		return p1
	end

	for v1, v2 in { "Text", "TextLabel", "Label", "Title", "Desc", "Description" } do
		local v3 = p1:FindFirstChild(v2)

		if v3 and (v3:IsA("TextLabel") or v3:IsA("TextButton")) then
			return v3
		end
	end

	return p1:FindFirstChildWhichIsA("TextLabel", true) or p1:FindFirstChildWhichIsA("TextButton", true)
end

local function isElementVisible(p1) --[[ isElementVisible | Line: 31 ]]
	local v1 = p1

	while v1 do
		if v1:IsA("GuiObject") and not v1.Visible then
			return false
		end

		if v1:IsA("ScreenGui") and not v1.Enabled then
			return false
		end

		v1 = v1.Parent
	end

	return true
end

local function Update(p1) --[[ Update | Line: 45 | Upvalues: v4 (ref), HoverSFX (copy), v5 (ref) ]]
	if v4 == p1 then
		return
	end

	HoverSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
	HoverSFX.TimePosition = 0
	HoverSFX.Playing = true
	v4 = p1

	if not v5 then
		return
	end

	v5.Text = p1
end

function t.TrackUI(p1, p2) --[[ TrackUI | Line: 57 | Upvalues: v2 (ref), v3 (ref), v4 (ref) ]]
	p2.MouseEnter:Connect(function() --[[ Line: 58 | Upvalues: v2 (ref), p2 (copy), v3 (ref) ]]
		v2 = p2
		v3 = true
	end)
	p2.MouseLeave:Connect(function() --[[ Line: 62 | Upvalues: v2 (ref), p2 (copy), v3 (ref), v4 (ref) ]]
		if v2 ~= p2 then
			return
		end

		v3 = false
		v2 = nil
		v4 = nil
	end)
	p2:GetAttributeChangedSignal("TextToolTip"):Connect(function() --[[ Line: 70 | Upvalues: p2 (copy), v2 (ref), v3 (ref) ]]
		if p2:GetAttribute("TextToolTip") or v2 ~= p2 then
			return
		end

		v3 = false
		v2 = nil
	end)
	p2.Destroying:Connect(function() --[[ Line: 79 | Upvalues: v2 (ref), p2 (copy), v3 (ref) ]]
		if v2 ~= p2 then
			return
		end

		v3 = false
		v2 = nil
	end)
end
function t.Start(p1) --[[ Start | Line: 87 | Upvalues: LocalPlayer (copy), v5 (ref), resolveTextLabel (copy), TextTooltip (copy), RunService (copy), v3 (ref), v2 (ref), isElementVisible (copy), v4 (ref), HoverSFX (copy), v1 (copy) ]]
	local PlayerGui = LocalPlayer.PlayerGui

	v5 = resolveTextLabel(TextTooltip)

	local function shouldTrack(p1) --[[ shouldTrack | Line: 92 ]]
		return p1:IsA("GuiObject") and p1:GetAttribute("TextToolTip") ~= nil
	end

	for v12, v22 in PlayerGui:GetDescendants() do
		if v22:IsA("GuiObject") and (if v22:GetAttribute("TextToolTip") == nil then false else true) then
			p1:TrackUI(v22)
		end
	end

	PlayerGui.DescendantAdded:Connect(function(p12) --[[ Line: 101 | Upvalues: p1 (copy) ]]
		if not (p12:IsA("GuiObject") and (if p12:GetAttribute("TextToolTip") == nil then false else true)) then
			return
		end

		p1:TrackUI(p12)
	end)
	TextTooltip.Visible = false
	RunService.Heartbeat:Connect(function() --[[ Line: 108 | Upvalues: v3 (ref), v2 (ref), isElementVisible (ref), TextTooltip (ref), v4 (ref), HoverSFX (ref), v5 (ref), v1 (ref) ]]
		if not (v3 and v2) then
			TextTooltip.Visible = false

			return
		end

		if not isElementVisible(v2) then
			TextTooltip.Visible = false
			v3 = false
			v2 = nil
			v4 = nil

			return
		end

		local v12 = v2:GetAttribute("TextToolTip")

		if type(v12) ~= "string" then
			TextTooltip.Visible = false

			return
		end

		if v4 ~= v12 then
			HoverSFX.PlaybackSpeed = 1 + math.random(-15, 15) / 100
			HoverSFX.TimePosition = 0
			HoverSFX.Playing = true
			v4 = v12

			if v5 then
				v5.Text = v12
			end
		end

		TextTooltip.AnchorPoint = Vector2.new(0, 0)
		TextTooltip.Position = UDim2.new(0, v1.X, 0, v1.Y - TextTooltip.AbsoluteSize.Y - 8)
		TextTooltip.Visible = true
	end)
end
function t.Init(p1) --[[ Init | Line: 135 ]] end

return t