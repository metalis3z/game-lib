-- Texture "studs" bien visible dans les GUI : chaque image de studs est teintée comme le fond qu'elle recouvre
-- (couleur unie ou dégradé), et suit les changements de couleur faits par les autres scripts.
local playerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
local STUD_ID = "7447638591"
local VISIBLE = 0.2
local done = setmetatable({}, {__mode = "k"})
-- fenêtres sans texture studs du tout (le créateur les préfère lisses)
local NO_STUDS = {PetInventoryGui = true, ShopGui = true, ShopCardsGui = true, IndexGui = true, SettingsGui = true, OfflineGui = true, CodeGui = true, CodeRedeemGui = true, GardenPanelGui = true, TreadmillUpgrade = true, UpdateGui = true, GlobalPollGui = true}

local function setup(studs)
	if done[studs] or not studs:IsA("ImageLabel") or not studs.Image:find(STUD_ID, 1, true) then return end
	local parent = studs.Parent
	if not parent or not parent:IsA("GuiObject") then return end
	done[studs] = true
	local layer = studs:FindFirstAncestorWhichIsA("LayerCollector")
	if layer and (NO_STUDS[layer.Name] or layer:IsA("ScreenGui")) then -- plus de studs dans aucune interface à l'écran (demande du créateur)
		studs.Visible = false
		return
	end
	if parent:IsA("GuiButton") or parent:FindFirstAncestorWhichIsA("GuiButton") then
		studs.ImageTransparency = math.max(studs.ImageTransparency, 0.7) -- sur un bouton : studs discrets
	else
		studs.ImageTransparency = math.min(studs.ImageTransparency, VISIBLE)
	end
	local tint = studs:FindFirstChild("Tint")
	local function source()
		for _, c in parent:GetChildren() do
			if c:IsA("UIGradient") then return c end
		end
	end
	local watched
	local function apply()
		local g = source()
		if g and g.Enabled then
			if not tint then
				tint = Instance.new("UIGradient")
				tint.Name = "Tint"
				tint.Parent = studs
			end
			tint.Enabled = true
			tint.Color, tint.Rotation, tint.Offset = g.Color, g.Rotation, g.Offset
			studs.ImageColor3 = parent.BackgroundColor3
			if watched ~= g then
				watched = g
				g.Changed:Connect(function() if watched == g then apply() end end)
			end
		else
			if tint then tint.Enabled = false end
			studs.ImageColor3 = parent.BackgroundColor3
		end
	end
	parent:GetPropertyChangedSignal("BackgroundColor3"):Connect(apply)
	parent.ChildAdded:Connect(function(c) if c:IsA("UIGradient") then apply() end end)
	apply()
end

for _, d in playerGui:GetDescendants() do setup(d) end
playerGui.DescendantAdded:Connect(function(d) task.defer(setup, d) end)
