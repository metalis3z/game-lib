-- BridgeFadeClient (Client)
-- Handles the visual fade of Bridge1 entirely on the client.
-- Reads 'FadePhase' and 'BridgeDie' attributes from the server to stay in sync.
-- No property changes are replicated - all visual changes are local only.

local RunService = game:GetService("RunService")

local bridge = workspace:WaitForChild("Bridge1", 10)
if not bridge then return end

-- Collect all parts and text labels, store original transparency
local parts = {}
local textLabels = {}
local originalTransparency = {}
local originalTextTransparency = {}
local originalStrokeTransparency = {}

for _, desc in ipairs(bridge:GetDescendants()) do
	if desc:IsA("BasePart") then
		table.insert(parts, desc)
		originalTransparency[desc] = desc.Transparency
	elseif desc:IsA("TextLabel") or desc:IsA("TextButton") then
		table.insert(textLabels, desc)
		originalTextTransparency[desc] = desc.TextTransparency
		local stroke = desc:FindFirstChildOfClass("UIStroke")
		if stroke then
			originalStrokeTransparency[desc] = stroke.Transparency
		end
	end
end

local FADE_STEPS = 20
local currentPhase = "visible"
local fadeAlpha = 0 -- 0 = fully visible, 1 = fully invisible

local function setVisualAlpha(alpha)
	for _, part in ipairs(parts) do
		local orig = originalTransparency[part] or 0
		part.Transparency = orig + (1 - orig) * alpha
	end
	for _, label in ipairs(textLabels) do
		local orig = originalTextTransparency[label] or 0
		label.TextTransparency = orig + (1 - orig) * alpha
		local stroke = label:FindFirstChildOfClass("UIStroke")
		if stroke then
			local sOrig = originalStrokeTransparency[label] or 0
			stroke.Transparency = sOrig + (1 - sOrig) * alpha
		end
	end
end

-- Smoothly interpolate fade alpha towards target each frame
local targetAlpha = 0

RunService.RenderStepped:Connect(function(dt)
	local phase = bridge:GetAttribute("FadePhase")
	if phase ~= currentPhase then
		currentPhase = phase
		if phase == "fading" then
			targetAlpha = 1
		elseif phase == "invisible" then
			targetAlpha = 1
		elseif phase == "visible" then
			targetAlpha = 0
		end
	end

	-- Smooth interpolation towards target alpha
	if fadeAlpha ~= targetAlpha then
		local fadeDuration = bridge:GetAttribute("BridgeDie") or 3
		local speed = 1 / fadeDuration
		if targetAlpha > fadeAlpha then
			fadeAlpha = math.min(fadeAlpha + speed * dt, targetAlpha)
		else
			fadeAlpha = math.max(fadeAlpha - 100 * dt, targetAlpha) -- instant restore
		end
		setVisualAlpha(fadeAlpha)
	end
end)

-- Set initial state
setVisualAlpha(0)