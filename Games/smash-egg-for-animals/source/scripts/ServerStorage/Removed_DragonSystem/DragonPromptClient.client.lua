-- Le bouton « Ride » d'un dragon n'apparaît que pour son propriétaire : on ne voit plus le ProximityPrompt des dragons des autres.
-- (Le serveur refusait déjà la montée ; ici on cache seulement le bouton, chez chaque joueur.)
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local TAG = "RideDragon"

local function track(dragon)
	local function mine()
		local owner = dragon:GetAttribute("Owner")
		return owner == nil or owner == player.UserId
	end
	local function hook(prompt)
		local function update() if not mine() and prompt.Enabled then prompt.Enabled = false end end
		update()
		prompt:GetPropertyChangedSignal("Enabled"):Connect(update) -- le serveur le rallume quand le cavalier descend
		dragon:GetAttributeChangedSignal("Owner"):Connect(update)
	end
	for _, d in dragon:GetDescendants() do if d:IsA("ProximityPrompt") and d.Name == "RidePrompt" then hook(d) end end
	dragon.DescendantAdded:Connect(function(d) if d:IsA("ProximityPrompt") and d.Name == "RidePrompt" then hook(d) end end)
end

for _, dragon in CollectionService:GetTagged(TAG) do track(dragon) end
CollectionService:GetInstanceAddedSignal(TAG):Connect(track)
