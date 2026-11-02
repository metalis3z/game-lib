-- Affiche "Your Base" et l'icône maison uniquement au-dessus de la base du joueur local
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local bases = workspace:WaitForChild("all base")

local function update(base)
	local mine = base:GetAttribute("OwnerUserId") == player.UserId
	local display = base:FindFirstChild("BaseDisplay")
	if not display then return end
	for _, gui in display:GetChildren() do
		if gui:IsA("BillboardGui") then gui.Enabled = mine end
	end
end

local function watch(base)
	if not base:IsA("Model") then return end
	update(base)
	base:GetAttributeChangedSignal("OwnerUserId"):Connect(function() update(base) end)
	base.ChildAdded:Connect(function(child)
		if child.Name == "BaseDisplay" then update(base) end
	end)
end

for _, base in bases:GetChildren() do watch(base) end
bases.ChildAdded:Connect(watch)
