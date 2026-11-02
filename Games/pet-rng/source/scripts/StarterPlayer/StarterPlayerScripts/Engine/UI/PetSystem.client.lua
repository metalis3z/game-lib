local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local RSEngine = ReplicatedStorage:WaitForChild("Engine")
local Remotes = RSEngine:WaitForChild("RemotesEvents")
local Functions = RSEngine:WaitForChild("RemotesFunctions")
local EquipPet = Remotes:WaitForChild("EquipPet")
local GetValue = Functions:WaitForChild("GetValue")

local player = game.Players.LocalPlayer
local playerGui = player.PlayerGui
local gui = playerGui:WaitForChild("GUI")
local frames = gui:WaitForChild("Frames")
local inventory = frames:WaitForChild("Inventory")
local holder = inventory:WaitForChild("PetsHolder")
local scroll = holder:WaitForChild("HolderScroll")
local equip = inventory:WaitForChild("Equip")

local function equipPet(petFrame, pet)
	petFrame.Equipped.Size = UDim2.fromScale(0,0)
	TweenService:Create(petFrame.Equipped, TweenInfo.new(0.25), {Size = UDim2.fromScale(0.8,0.8)}):Play()
	petFrame.LayoutOrder -= 1000000
	petFrame.Equipped.Visible = true
	
	EquipPet:FireServer(pet, true)
end

equip.MouseButton1Click:Connect(function()
	local petName = inventory.PetsHolder.InfoFrame.PetName.Text
	local pet = game.ReplicatedStorage.Pets:FindFirstChild(petName)
	
	local petFrame = scroll:FindFirstChild(petName)
	for _, frame in pairs(scroll:GetChildren()) do
		if frame:IsA("ImageButton") then
			if frame.Equipped.Visible then
				frame.LayoutOrder += 1000000
				frame.Equipped.Visible = false
			end
		end
	end
	if petFrame and pet then
		equipPet(petFrame, pet)
	end
end)

local EquipedPet = GetValue:InvokeServer("EquipedPet")
local pet = game.ReplicatedStorage.Pets:WaitForChild(EquipedPet)
local petFrame = scroll:WaitForChild(EquipedPet)
equipPet(petFrame, pet)
