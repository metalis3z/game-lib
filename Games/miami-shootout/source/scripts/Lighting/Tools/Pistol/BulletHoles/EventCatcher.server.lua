--> CUSTOMISATION
local BulletHoleImageID = 359667865
local BulletHoleSize = 1.5
local BulletHoleColour = Color3.new(0, 0, 0)

--> LOCAL VARIABLES
local BulletHoleEvent = script.Parent
local Pistol = BulletHoleEvent.Parent
local BulletHitSounds = BulletHoleEvent:WaitForChild("BulletHits"):GetChildren()
local DestroyBulletScript = BulletHoleEvent:WaitForChild("DestroyBulletHole")

--> FUNCTIONS
BulletHoleEvent.OnServerEvent:Connect(function(Player, MousePosition)
	local BulletHitPart = Instance.new("Part")
	local DestroyBulletScript = BulletHoleEvent:WaitForChild("DestroyBulletHole"):Clone()
	local Sound = BulletHitSounds[math.random(#BulletHitSounds)]:Clone()
	BulletHitPart.Shape = "Ball"
	BulletHitPart.Anchored = true
	BulletHitPart.CanTouch = false
	BulletHitPart.CanCollide = false
	BulletHitPart.Transparency = .5
	BulletHitPart.Color = BulletHoleColour
	BulletHitPart.Size = Vector3.new(BulletHoleSize / 10, BulletHoleSize / 10, BulletHoleSize / 10)
	BulletHitPart.Position = MousePosition
	BulletHitPart.Parent = game.Workspace
	DestroyBulletScript.Parent = BulletHitPart
	DestroyBulletScript.Disabled = false
	Sound.Parent = BulletHitPart
	Sound:Play()
end)