local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local FrameAnimator = require(ReplicatedStorage.Source.Modules.FrameAnimator)

local ShopProximityController = {}

local ZONE_MARGIN = 4 -- studs of slack around the InteractiblePart bounds
local HUD_KEEP = "LeftDownSide"

local SHOPS = {
	{
		ShopName = "DrillShop",
		UiName = "ItemShop",
	},
	{
		ShopName = "UpgradeShop",
		UiName = "UpgradeShop",
	},
	{
		ShopName = "SellShop",
		UiName = "SellFrame",
	},
	{
		ShopName = "TrailShop",
		UiName = "TrailShop",
	},
}

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function waitForUi(uiName)
	local gui = playerGui:WaitForChild("GUI", 30)
	if not gui then
		return nil
	end
	local folder = gui:WaitForChild("Folder", 30)
	if not folder then
		return nil
	end
	return folder:WaitForChild(uiName, 30)
end

local function openUi(uiName)
	local ui = waitForUi(uiName)
	if not ui then
		warn(string.format("ShopProximityController: UI %q not found under PlayerGui.GUI.Folder", uiName))
		return
	end
	if ui:IsA("GuiObject") then
		FrameAnimator:Open(ui)
	elseif ui:IsA("ScreenGui") then
		ui.Enabled = true
	end
end

-- Two opening styles per booth:
--   * A ProximityPrompt anywhere under the booth model -> press-E-to-open.
--     The prompt is left alone and the walk-in zone is NOT wired, so the
--     frame only opens on an explicit interaction (DrillShop).
--   * No prompt -> walk INTO the model's "InteractiblePart" zone; any
--     prompt / click detector added later is stripped (legacy behavior).
local function stripInteractors(model)
	for _, d in ipairs(model:GetDescendants()) do
		if d:IsA("ProximityPrompt") or d:IsA("ClickDetector") then
			d:Destroy()
		end
	end
end

local function setupShop(shopModel, uiName)
	-- Other systems add their own prompts to booth models at runtime (e.g. the
	-- sell-loot arrow prompt on SellShop.ArrowPart), so a blind descendant
	-- search can wire the wrong prompt and leave the booth's visible one dead.
	-- The booth's own open prompt lives under its "Prox" part.
	local proxPart = shopModel:FindFirstChild("Prox") or shopModel:WaitForChild("Prox", 10)
	local prompt = proxPart and proxPart:FindFirstChildWhichIsA("ProximityPrompt")
		or shopModel:FindFirstChildWhichIsA("ProximityPrompt", true)
	if prompt then
		prompt.Triggered:Connect(function(triggeredBy)
			if triggeredBy == player then
				openUi(uiName)
			end
		end)
		return
	end

	stripInteractors(shopModel)
	shopModel.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("ProximityPrompt") or descendant:IsA("ClickDetector") then
			descendant:Destroy()
		end
	end)

	local zone = shopModel:FindFirstChild("InteractiblePart", true)
	if not zone then
		warn(string.format("ShopProximityController: %q has no InteractiblePart", shopModel.Name))
		return
	end

	local inZone = false

	zone.Touched:Connect(function(hit)
		local character = player.Character
		if not character or not hit:IsDescendantOf(character) then
			return
		end
		if inZone then
			return
		end
		inZone = true
		openUi(uiName)
	end)

	-- Touched never tells us when they leave, so latch off once the player
	-- walks back out of the zone -- lets re-entry re-open it.
	RunService.Heartbeat:Connect(function()
		if not inZone then
			return
		end
		local character = player.Character
		local hrp = character and character:FindFirstChild("HumanoidRootPart")
		if not hrp then
			inZone = false
			return
		end
		local lp = zone.CFrame:PointToObjectSpace(hrp.Position)
		local half = zone.Size / 2
		if math.abs(lp.X) > half.X + ZONE_MARGIN
			or math.abs(lp.Y) > half.Y + ZONE_MARGIN
			or math.abs(lp.Z) > half.Z + ZONE_MARGIN then
			inZone = false
		end
	end)
end

function ShopProximityController.Init()
	local assets = Workspace:WaitForChild("Assets")
	local map = assets:WaitForChild("Map")

	for _, entry in ipairs(SHOPS) do
		task.spawn(function()
			local ui = waitForUi(entry.UiName)
			if ui then
				ui:SetAttribute("HudKeep", HUD_KEEP)
			end

			local shopModel = map:WaitForChild(entry.ShopName, 30)
			if not shopModel then
				warn(string.format("ShopProximityController: %q not found under Workspace.Assets.Map", entry.ShopName))
				return
			end
			setupShop(shopModel, entry.UiName)
		end)
	end
end

return ShopProximityController
