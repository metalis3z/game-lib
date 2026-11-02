local replicatedStorage = game:GetService("ReplicatedStorage")
local RSEngine = replicatedStorage.Engine
local dataModules = replicatedStorage.DataModules
local roll = RSEngine.RemotesEvents.Roll
local Modules = RSEngine.Modules
local RemoteFunctions = RSEngine:WaitForChild("RemotesFunctions")
local getValue = RemoteFunctions:WaitForChild("GetValue")
local mps = game:GetService("MarketplaceService")
local luck = require(Modules:WaitForChild("Luck"))

local SoundService = game:GetService("SoundService")
local Main = SoundService:WaitForChild("Main")
local Interface = Main:WaitForChild("Interface")
local pop = Interface:WaitForChild("UiClick")
local confirm = Interface:WaitForChild("Confirm")

local autoRollId = replicatedStorage.ID.Gamepasses["Auto Roll"].Value

local rarities = require(dataModules.Rarities)
local petsModule = require(dataModules.Pets)
local ToggleUI = require(Modules.ToggleUI)
local rollPet = require(Modules.Roll)

local pets = {}
local lastLuck = 0

local plr = game.Players.LocalPlayer

local gui = plr.PlayerGui:WaitForChild("GUI")
local Stop = gui:WaitForChild("Stop")
local rollButton = gui:WaitForChild("Bottom"):WaitForChild("roll")
local autoRollButton = gui:WaitForChild("Bottom"):WaitForChild("autoRoll")
local rollFrame = gui:WaitForChild("RollFrame")
local viewportFrame = rollFrame:WaitForChild("Info"):WaitForChild("Pet")
local tweenService = game:GetService("TweenService")
local lockOverlay = autoRollButton.Lock

local debounce = false
local autoRolling
local delayTime = 1

local viewportCam = Instance.new("Camera", workspace)
viewportCam.CFrame = CFrame.new(Vector3.new(0,0,0))

local function getChance(rarity, totalRarity)
	return "1/"..math.round(1/rarity * totalRarity)
end

local function playSound(sound: Sound)
	coroutine.wrap(function()
		local new = sound:Clone()
		new.Parent = Interface
		new:Play()

		wait(5)

		new:Remove()
	end)()
end


local function getAccumulated(weightsTable)
	local totalWeight = 0
	for _, weight in pairs(weightsTable) do
		totalWeight = totalWeight + weight.weight
	end
	return totalWeight
end

local function viewport(petData)
	if viewportFrame:FindFirstChild("petFrame") then
		viewportFrame:FindFirstChild("petFrame"):Destroy()
	end
	local petModel:Model = petData.pet:Clone()
	local multi = 1
	if petModel:GetAttribute("big") then
		multi = 2
	end
	viewportFrame.CurrentCamera = viewportCam
	petModel.Name = "petFrame"
	petModel.Parent = viewportFrame
	petModel:PivotTo(CFrame.new(0,0,-4*multi) * CFrame.Angles(0, math.rad(100), math.rad(-10)))
end

local function displayPet(plr: Player, pet, valid, accumulated, multi)
	local petData = pets[pet]
	if not petData then return end
	
	local PlayerGui = game.Players.LocalPlayer.PlayerGui
	local GUI = PlayerGui:WaitForChild("GUI")
	local RollFrame = GUI:WaitForChild("RollFrame")
	local Info = RollFrame:WaitForChild("Info")
	local PetDisplay = Info:WaitForChild("Pet")
	local PetName = Info:WaitForChild("PetName")
	local Title = Info:WaitForChild("Title")
	local Chance = Info:WaitForChild("Chance")
	local Ring = PetDisplay:WaitForChild("ring")
	
	for _, object in pairs(PetDisplay:GetChildren()) do
		if object:IsA("Model") then
			object:Remove()
		end
	end
	
	--local new = petData.pet:Clone()
	--new.Parent = PetDisplay
	--new:MoveTo(Vector3.new(0,0,-3))
	

	coroutine.wrap(function()
		RollFrame.Visible = true
		Info.Position = UDim2.new(0.5,0,0.5,0)
		tweenService:Create(RollFrame, TweenInfo.new(.5 * multi), {Transparency = .5}):Play()

		tweenService:Create(Info, TweenInfo.new(.025* multi), {Position = UDim2.new(0.5,0,0.475,0)}):Play()
		wait(0.025)
		tweenService:Create(Info, TweenInfo.new(.025* multi), {Position = UDim2.new(0.5,0,0.5,0)}):Play()
		
		PetName.Text = petData.name
		Title.Text = petData.title
		viewport(petData)
		local rarityColor = rarities[petData.title].color
		if rarityColor then
			Title.TextColor3 = rarityColor
		end
		Chance.Text = getChance(petData.weight, accumulated)

		if valid then
			Ring.ImageTransparency = 0
			Ring.Size = UDim2.fromScale(0,0)
			tweenService:Create(Ring, TweenInfo.new(1* multi), {Size = UDim2.fromScale(6.67, 6.49)}):Play()
			tweenService:Create(Ring, TweenInfo.new(1* multi), {ImageTransparency = 1}):Play()
			wait(2* multi)
			tweenService:Create(RollFrame, TweenInfo.new(.5* multi), {Transparency = 1}):Play()
			tweenService:Create(Info, TweenInfo.new(.5* multi), {Position = UDim2.fromScale(0.5,-0.3)}):Play()
			wait(.5* multi)
			RollFrame.Visible = false
		end
	end)()
	wait(0.025* multi)
end

local function rollDice()
	local multi = 1
	if mps:UserOwnsGamePassAsync(plr.UserId, 739606548) then
		multi = 0.5
	end
	
	if debounce == false then
		debounce = true
		ToggleUI.Close(plr)
		local accumulated = getAccumulated(pets)
		for i = 1,4 do
			local pet = rollPet.rollPet(pets)
			playSound(pop)
			displayPet(plr, table.find(pets, pet), false, accumulated, multi)
			--print(pets[pet].name .. " Invalid")
			wait(.05 * multi)
		end
		local pet = rollPet.rollPet(pets)
		playSound(confirm)
		displayPet(plr, table.find(pets, pet), true, accumulated, multi)
		roll:FireServer(pet.name)
		wait(2.5 * multi)
		ToggleUI.Open(plr)
		wait(delayTime)
		debounce = false
	end
end

rollButton.MouseButton1Down:Connect(function()
	rollDice()
end)

autoRollButton.MouseButton1Click:Connect(function()
	if mps:UserOwnsGamePassAsync(plr.UserId, autoRollId) then
		lockOverlay.Visible = false
		if autoRolling == true then
			autoRolling = false
		else
			autoRolling = true
		end
	else
		mps:PromptGamePassPurchase(plr, autoRollId)
		lockOverlay.Visible = true
	end
end)

Stop.MouseButton1Click:Connect(function()
	Stop.Visible = false
	autoRolling = false
end)

local aLuck = luck.GetLuck(plr)
lastLuck = aLuck
lastWorld = getValue:InvokeServer("World")
pets = {}
for _, pet in pairs(petsModule) do
	if pet.weight <= 0.02 then
		pet.weight *= aLuck
	end
	
	table.insert(pets, pet)
	
	if pet.title == "Cave" then
		local world = lastWorld
		if world ~= pet.title then
			table.remove(pets, table.find(pets, pet))
		end
	end
	
	if pet.title == "Desert" then
		local world = lastWorld
		if world ~= pet.title then
			table.remove(pets, table.find(pets, pet))
		end
	end
	
	if pet.title == "Snow" then
		local world = lastWorld
		if world ~= pet.title then
			table.remove(pets, table.find(pets, pet))
		end
	end
end

while wait() do
	if autoRolling then
		Stop.Visible = true
		rollDice()
	else
		Stop.Visible = false
	end
	
	local aLuck = luck.GetLuck(plr)
	local world = getValue:InvokeServer("World")
	if lastLuck ~= aLuck or world ~= lastWorld then
		print("a")
		lastWorld = world
		lastLuck = aLuck
		pets = {}
		for _, pet in pairs(petsModule) do
			if pet.weight <= 0.02 then
				pet.weight *= aLuck
			end
			
			table.insert(pets, pet)
			
			if pet.title == "Cave" then
				if world ~= pet.title then
					table.remove(pets, table.find(pets, pet))
				end
			end
			
			if pet.title == "Desert" then
				if world ~= pet.title then
					table.remove(pets, table.find(pets, pet))
				end
			end
			
			if pet.title == "Snow" then
				if world ~= pet.title then
					table.remove(pets, table.find(pets, pet))
				end
			end
		end
	end
end

if mps:UserOwnsGamePassAsync(plr.UserId, autoRollId) then
	lockOverlay.Visible = false
else
	mps:PromptGamePassPurchase(plr, autoRollId)
	lockOverlay.Visible = true
end