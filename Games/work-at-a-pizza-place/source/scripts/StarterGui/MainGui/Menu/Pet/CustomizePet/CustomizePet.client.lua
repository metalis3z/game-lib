local camera = workspace.CurrentCamera
local player = game.Players.LocalPlayer

local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")

local Window = script.Parent
local Title = Window:WaitForChild("Title")
local Right = Window:WaitForChild("Right")
local Cancel = Window:WaitForChild("CancelButton")

local PetType = Right:WaitForChild("PetType")
local Next = PetType:WaitForChild("Next")
local Previous = PetType:WaitForChild("Previous")
local Type = PetType:WaitForChild("Type")

local Primary = Right:WaitForChild("Primary")

local Secondary = Right:WaitForChild("Secondary")
local SelectedColor = Primary:WaitForChild("SelectedColor")
local SelectedColorSecondary = Secondary:WaitForChild("SelectedColor")
local Colors = SelectedColor:WaitForChild("Colors")
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))

local PetName = Right:WaitForChild("PetName")
local Buy = Window:WaitForChild("Buy")
local ChooseNameDropdown = Right:WaitForChild("ChooseNameDropdown") 





wait()
--if the buy buttons are not on screen
if Buy.AbsolutePosition.Y + Buy.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
	
	--move window to left
	Window.Position = UDim2.new(0,0,0,-60)
	
	Title.Text = ""

	Colors.Position = UDim2.new(0,0,0,-70)
	Colors.Size = UDim2.new(0,250,0,250)
	
	--move next to arrows
	Cancel.Position = UDim2.new(1, 0,0, 60)
	
	--if still not in frame, move buttons to the right
	--[[if BuyWithMoneyz.AbsolutePosition.Y + BuyWithMoneyz.AbsoluteSize.Y > MainGui.AbsoluteSize.Y then
		
		--move buttons to right
		BuyWithMoneyz.Position = UDim2.new(.35,0,1,-50)
		BuyWithRobux.Position = UDim2.new(.85,0,1,-50)
		
		Window.Size = UDim2.new(Window.Size.X.Scale,Window.Size.X.Offset,1,60)
		buttonShift = true
	end]]
end


--if menu is taking more than 1/3 of the screen horizonally, move it to the side
if Window.AbsoluteSize.X * 3 > MainGui.AbsoluteSize.X then
	Window.Position = UDim2.new(0,-100,0,Window.Position.Y.Offset)
	
	Title.Position = UDim2.new(0.35,0,0,0)
	Title.Size = UDim2.new(0.65,0,0,50)
	
	
	isSmallScreen = true
end


local WindowData = GuiManager:RegisterWindow(Window,"Left","Left")
local petPanelData = GuiManager:GetWindowDataByName("PetPanel")

WindowData.FirstSelectedObject = Next --choose type


--show pet names for players that cant chat
local DropdownMenuData
if Enums.CanChat == false then --UPDATECHANGE
	DropdownMenuData = GuiManager:RegisterDropdownMenu(Window,ChooseNameDropdown)
	PetName.Visible = false
	ChooseNameDropdown.Visible = true
end


local Menu = MainGui:WaitForChild("Menu")


local pet = nil

local types = {"Default","Bunny","Cat","Dog","Cub","Mouse","Jellyfish","Plant","Bug","Elf","Monkey","Lion","Deer","Moose","Bull"}
local typeIndex = 1

local maxZoom = player.CameraMaxZoomDistance
local minZoom = player.CameraMinZoomDistance

local died = nil


workspace.PetService.CustomizePet.OnClientEvent:connect(function(petObject,numPets)

	if player and player.Character and player.Character:FindFirstChild("Humanoid") then
		died = player.Character.Humanoid.Died:connect(function()
			workspace.PetService.CustomizePet:FireServer("Cancel")
			Exit()
			WindowData:SetVisible(false)
		end)
		
		petPanelData:SetVisible(false)
		WindowData:SetVisible(true)

	--	GuiManager:TouchControlsEnabled(false)

		
		PetName.Text = (isSmallScreen and "Enter Name") or "" 
		
		pet = petObject
		SelectedColor.BackgroundColor3 = Color3.new(0.0156863, 0.686275, 0.92549)
		SelectedColorSecondary.BackgroundColor3 = Color3.new(0.0156863, 0.686275, 0.92549)
		typeIndex = 1
		Type.Text = "Default"
		
		local cameraTarget = Instance.new("Part")
		cameraTarget.Transparency = 1
		cameraTarget.Size = Vector3.new(1,1,1)
		cameraTarget.Anchored = true
		cameraTarget.CanCollide = false
		cameraTarget.CFrame = petObject.CFrame
		cameraTarget.Parent = camera
		
		camera.CameraType = "Scriptable"
		camera.CoordinateFrame = CFrame.new( (petObject.Position + (petObject.CFrame.lookVector * 5)) + Vector3.new(0,2,0),petObject.Position)
		wait()
		camera.CameraType = "Custom"
		camera.CameraSubject = cameraTarget
		player.CameraMaxZoomDistance = 2
		player.CameraMinZoomDistance = 2
		

		
	else
		workspace.PetService.CustomizePet:FireServer("Cancel")
		Exit()
	end
end)

function FocusLost()
	PetName.Text = 	workspace.Main.FilterString:InvokeServer(nil,PetName.Text)

end

PetName.FocusLost:connect(FocusLost)





function ChooseType(dir)
	typeIndex = typeIndex + dir
	if typeIndex == 0 then
		typeIndex = #types
	elseif typeIndex > #types then
		typeIndex = 1
	end
	Type.Text = types[typeIndex]
	workspace.PetService.CustomizePet:FireServer("TypeChanged",types[typeIndex])

end


Next.MouseButton1Click:connect(function()  ChooseType(1) end)
Previous.MouseButton1Click:connect(function()  ChooseType(-1) end)






for i,v in ipairs(Colors:GetChildren()) do
	v.TextButton.MouseButton1Click:connect(function()
		
		local color3 = v.TextButton.BackgroundColor3

		Colors.Visible = false
		
		if Colors.Parent == SelectedColorSecondary then
			if _G.GamepadEnabled then
				game:GetService("GuiService").SelectedObject = Secondary
			end
			SelectedColorSecondary.BackgroundColor3 = color3
			workspace.PetService.CustomizePet:FireServer("SecondaryChanged",BrickColor.new(color3).Number)
		
		else
			if _G.GamepadEnabled then
				game:GetService("GuiService").SelectedObject = Primary
			end
			SelectedColor.BackgroundColor3 = color3
			workspace.PetService.CustomizePet:FireServer("PrimaryChanged",BrickColor.new(color3).Number)
		end
	end)
end

function StartColorPicker(selectedColor)
	if _G.GamepadEnabled then
		game:GetService("GuiService").SelectedObject = Colors.Frame.TextButton
	end
	Colors.Parent = selectedColor
	Colors.Visible = true 
end

Primary.MouseButton1Click:connect(function() StartColorPicker(SelectedColor) end)
Secondary.MouseButton1Click:connect(function() StartColorPicker(SelectedColorSecondary) end)


function Exit()
	if died then died:disconnect() end
	
	petPanelData:SetVisible(true)

	ChooseNameDropdown.SelectedOption.Text = ""	 --UPDATECHANGE

			
	player.CameraMaxZoomDistance = maxZoom
	player.CameraMinZoomDistance = 8
	camera.CameraSubject = player.Character:WaitForChild("Humanoid",5)
	wait()
	player.CameraMinZoomDistance = minZoom
end




local debounce = false

function Submit()

	if debounce then return end
	debounce = true
	
	local name = (Enums.CanChat and PetName.Text) or ChooseNameDropdown.SelectedOption.Text   --UPDATECHANGE
	
	if string.find(name,"##") then
		debounce = false
		Dialog:ShowMessage("Name was filtered","Please try another name for you pet.","Ok")
		return
	end


	if name == "Enter Name" or name == "" then
		
		Dialog:ShowMessage("No Name","You should give your pet a name.","Ok","")
		debounce = false
		return
	end
	
	if string.len(name) > 13 then
		Dialog:ShowMessage("Name too long","The pet's name is too long. Please rename your pet.","Ok")
		debounce = false
		return
	end
	
	if string.match(name,"[%a ]+") ~= name then
		Dialog:ShowMessage("Invalid name","Only letters and numbers are allowed in the pet's name.","Ok")
		debounce = false
		return
	end
	
	if pet.BrickColor.Number == 1013 then
		if not Dialog:GetChoice("","You didn't change the color of your pet. Are you sure you want your pet to be this color?","Yes","No") then
			debounce = false
			return
		end
	end
	
	if #pet.Hat:GetChildren() == 0 then --pet is default
		if not Dialog:GetChoice("","You can add ears and horns to your pet. Are you sure you want the default look?","     Yes     ","     No     ") then
			debounce = false
			return
		end
	end
	

	
		
	--yeild until purchase is made
	local purchased = workspace.PetService.FinishedCustomizing:InvokeServer(name)
	
			
	if purchased then
		SoundFX:PlaySound("CashRegister")
	else
		workspace.PetService.CustomizePet:FireServer("Cancel")
	end
				
	
	Exit()
	
	WindowData:SetVisible(false)

		
	debounce = false
	
	
	
end
Buy.MouseButton1Click:connect(function() Submit() end)


--when b button is pressed or X button is clicked
UIEvents.WindowManuallyClosed.Event:connect(function(window)
	if window == Window then
		workspace.PetService.CustomizePet:FireServer("Cancel")
		Exit() 
	end
end)





local petNames = "Acorn\
Alvin\
Asia\
Audi\
Bagel\
Balou\
Barclay\
Barney\
Beck\
Bellatrix\
Bianca\
Biloxi\
Birdie\
Biscuit\
Blanca\
Bobbafett\
Bodie\
Bono\
Booboo\
Bootsie\
Bordeaux\
Brandy\
Bren\
Bronco\
Bruin\
Bubbles\
Buffy\
Burt\
Butler\
Button\
Calvin\
Candy\
Carter\
Cece\
Cessa\
Chandler\
Chaucer\
Chevy\
China\
Choochoo\
Cisco\
Claire\
Cleopatra\
Clooney\
Coconut\
Connor\
Cosmo\
Crosby\
Cupcake\
Daisy\
Dallas\
Daphne\
Delilah\
Diva\
Doc\
Domino\
Donna\
Donovan\
Dulus\
Dutch\
Ed\
Elton\
Elwood\
Ernie\
Faith\
Faya\
Felix\
Fig\
Fiona\
Foxy\
Fritz\
Fuse\
Giblet\
Gibson\
Gingi\
Goofy\
Graysen\
Greystoke\
Guinness\
Hershey\
Holly\
Honey\
Huck Finn\
Hudson\
Hutch\
Ike\
Indira\
Iris\
Ivory\
Jasmine\
Jasper\
Jazzy\
Jeeves\
Jenna\
Jenne\
Joy\
Kai\
Kalua\
Kaly\
Kassie\
Kaya\
Keanna\
Keesha\
Keiko\
Kiefer\
Kingston\
Koby\
Kona\
Laguna\
Landon\
Larissa\
Lefty\
Leia\
Lexi\
Lil’bit\
Lilypie\
Linus\
Logan\
Lola\
Luca\
Lucy\
Luke\
Madonna\
Malble\
Malibu\
Margo\
Marshmellow\
Marti\
Max\
Maya\
Meadow\
Mercedes\
Merlot\
Merry\
Mia\
Midnight\
Midori\
Mika\
Milan\
Mira\
Mischa\
Mitzi\
Moby\
Mochi\
Monet\
Monkey\
Mooshie\
Mozart\
Mr Big\
Muggles\
Mulder\
Mulligan\
Murphy\
Mylo\
Nanda\
Nate\
Nell\
Niana\
Nico\
Noodle\
Nugget\
Olive\
Onyx\
Otis\
Owen\
Ozzie\
Paddington\
Paisley\
Paris\
Parker\
Paulie\
Pazzo\
Peanut\
Pearl\
Pepper\
Persia\
Pesci\
Phoenix\
Picasso\
Pinot\
Pipsie\
Pixie\
Porche\
Quattro\
Ramona\
Redford\
Reece\
Rico\
Robin Hood\
Rocco\
Rocky\
Romeo\
Roxie\
Rufus\
Rusty\
Scotty\
Scout\
Shadow\
Shaggy\
Shane\
Shaq\
Sheba\
Silas\
Skip\
Skitty\
Skyler\
Smitty\
Snooky\
Snoopy\
Sookie\
Spark\
Sprite\
Stitch\
Strsky\
Sugar\
Summer\
Sunny\
Sushi\
Sweetpea\
Syrah\
Tallulah\
Tango\
Tank\
Tanner\
Tatertot\
Theo\
Tibbs\
Timber\
Tink\
Toast\
Toffee\
Tonka\
Vegas\
Wednesday\
Wilbur\
Willow\
Winnie\
Wolfie\
Yoshiko\
Zach\
Zara\
Zeke\
Zelda\
Zeppelin\
ZsaZsa"


--UPDATECHANGE


if Enums.CanChat == false then
	local petNameList = {}
	for w in string.gmatch(petNames, "%w+") do 
		table.insert(petNameList,w)
	end
	DropdownMenuData:SetList(petNameList)
	
	ChooseNameDropdown.NextSelectionDown = Buy
	ChooseNameDropdown.NextSelectionUp = Secondary
	Secondary.NextSelectionDown = ChooseNameDropdown
	Buy.NextSelectionUp = ChooseNameDropdown
end


















