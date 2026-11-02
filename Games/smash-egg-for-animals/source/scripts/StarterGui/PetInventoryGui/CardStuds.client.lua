-- (plus de texture "studs" sur les cartes de l'inventaire : retirée à la demande, les cartes restent lisses)
local grid = script.Parent:WaitForChild("Main"):WaitForChild("Grid")

-- les rayons derrière chaque animal tournent lentement (seulement quand la fenêtre est ouverte)
local main = script.Parent:WaitForChild("Main")
game:GetService("RunService").RenderStepped:Connect(function()
	if not main.Visible then return end
	local angle = (os.clock() * 16) % 360
	for _, card in grid:GetChildren() do
		local clip = card:FindFirstChild("RaysClip")
		local rays = clip and clip:FindFirstChild("Rays")
		if rays then rays.Rotation = angle end
	end
end)
