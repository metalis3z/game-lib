-- Animal tenu en main : un clic (ou un appui) sur le sol de son jardin le pose à cet endroit.
-- Ailleurs, le serveur répond qu'il faut aller dans le jardin : on peut seulement le garder en main.
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local remotes = game:GetService("ReplicatedStorage"):WaitForChild("EggSystem"):WaitForChild("Remotes")

local function heldPet()
	local character = player.Character
	local tool = character and character:FindFirstChildOfClass("Tool")
	return tool and tool:GetAttribute("PetId"), tool
end

local lastClick = 0
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end
	if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
	local id = heldPet()
	if not id or os.clock() - lastClick < 0.3 then return end
	lastClick = os.clock()
	local camera = workspace.CurrentCamera
	local ray = camera:ViewportPointToRay(input.Position.X, input.Position.Y)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {player.Character}
	local hit = workspace:Raycast(ray.Origin, ray.Direction * 600, params)
	if hit then remotes.PetAction:FireServer("PlacePetAt", id, hit.Position) end
end)
