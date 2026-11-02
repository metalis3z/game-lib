-- ShopSunburstSpinClient: spins the sunburst backdrop behind the Robux
-- store offer icons -- every ImageLabel named "Sunburst" in the Shop
-- frame. Ported from "+1 Kick Door Per Click" 2026-07-21.
--
-- Rotated GuiObjects ESCAPE ClipsDescendants (engine limitation), and the
-- authored bursts fill (or overflow) their cards, so a naked Rotation
-- would spill rays over the neighbouring cards. Each burst is therefore
-- wrapped in a card-sized CanvasGroup: the canvas buffer DOES clip rotated
-- content, reproducing exactly the crop the card's own ClipsDescendants
-- gave the unrotated image. Spins only while the Shop frame is visible.
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local SPIN_SPEED = 25 -- degrees per second

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local gui = playerGui:WaitForChild("GUI")
local folder = gui:WaitForChild("Folder")
local shopFrame = folder:WaitForChild("Shop")

local spinners = {}

local function wrap(sunburst)
	local card = sunburst.Parent
	if not card or sunburst:FindFirstAncestorWhichIsA("CanvasGroup") then return end
	local canvas = Instance.new("CanvasGroup")
	canvas.Name = "SunburstSpin"
	canvas.BackgroundTransparency = 1
	canvas.BorderSizePixel = 0
	canvas.Size = UDim2.fromScale(1, 1)
	canvas.Position = UDim2.fromScale(0, 0)
	canvas.ZIndex = sunburst.ZIndex
	canvas.ClipsDescendants = true
	canvas.Parent = card
	-- geometry preserved: the canvas fills the card, so the burst's own
	-- card-relative Size/Position/AnchorPoint mean the same inside it
	sunburst.Parent = canvas
	table.insert(spinners, sunburst)
end

for _, d in ipairs(shopFrame:GetDescendants()) do
	if d:IsA("ImageLabel") and d.Name == "Sunburst" then
		wrap(d)
	end
end

-- 30Hz: every Rotation write re-rasterizes that burst's CanvasGroup, and
-- the UI perf pass precedent (HoverController's decorative rotation) is
-- 30Hz -- visually identical for a slow spin, half the raster work
local ROT_HZ = 30
local rotAccum = 0
RunService.RenderStepped:Connect(function(dt)
	if not shopFrame.Visible then return end
	rotAccum += dt
	if rotAccum < 1 / ROT_HZ then return end
	rotAccum = 0
	local rot = (os.clock() * SPIN_SPEED) % 360
	for _, burst in ipairs(spinners) do
		burst.Rotation = rot
	end
end)
