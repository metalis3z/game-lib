local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
local player = game.Players.LocalPlayer
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local isTransparent = false
local isInvisible = false
local collisionsEnabled = true
local nameHidden = false
local scale = 1
local running = false
local shrinkRay = false
local mouseconnection = nil
local UserInputService = game:GetService("UserInputService")

local torsoTouch
local headTouch
local collidedParts = {}

local TRANSPARENCY = .8

if player.Name == "Dued1" or player.Name == "Player"  then
	workspace.MessageService.ShowHint.ShowHint:Fire("Name: Hidden",1)
	workspace.Main.Ghost:FireServer("NameHidden",true)
	nameHidden = true
	player.CharacterAdded:connect(function()
		workspace.Main.Ghost:FireServer("NameHidden",true)
		workspace.MessageService.ShowHint.ShowHint:Fire("Name: Hidden",1)

	end)
end



UserInputService.InputBegan:connect(function(inputObject,gameProcessed)
			
	if (inputObject.UserInputType == Enum.UserInputType.Keyboard)   then --rotate event - key press
		--toggle between opeque and translucent
		if inputObject.KeyCode == Enum.KeyCode.One then
			if isTransparent then
				isTransparent = false
				workspace.Main.Ghost:FireServer("SetVisible",TRANSPARENCY,0)
			else
				workspace.Main.Ghost:FireServer("SetVisible",0,TRANSPARENCY)
				isTransparent = true
			end
			
		--toggle between translucent and invisible
		elseif inputObject.KeyCode == Enum.KeyCode.Two then
			if isInvisible then
				isInvisible = false
				workspace.Main.Ghost:FireServer("SetVisible",1,TRANSPARENCY)
			else
				isInvisible = true
				workspace.Main.Ghost:FireServer("SetVisible",TRANSPARENCY,1)
			end
		--disable collisions
		elseif inputObject.KeyCode == Enum.KeyCode.Three then
			if collisionsEnabled then
				collisionsEnabled = false


				local function touch(hit)
					if hit.CanCollide and (hit.Size.X < 150 or hit.Size.Z < 150) then
						hit.CanCollide = false
						table.insert(collidedParts,hit)
					end
				end
				
		
				headTouch = player.Character.Head.Touched:connect(touch)
				torsoTouch = player.Character.HumanoidRootPart.Touched:connect(touch)

				workspace.MessageService.ShowHint.ShowHint:Fire("Collision: Disabled",1)

			
			else
				workspace.MessageService.ShowHint.ShowHint:Fire("Collision: Enabled",1)
				collisionsEnabled = true
				
				headTouch:disconnect()
				torsoTouch:disconnect()
				
				for _,part in ipairs(collidedParts) do
					part.CanCollide = true
				end
				collidedParts = {}
				
			end
		--hide name
		elseif inputObject.KeyCode == Enum.KeyCode.Four then
			if nameHidden then
				nameHidden = false
				workspace.MessageService.ShowHint.ShowHint:Fire("Name: Visible",1)
				workspace.Main.Ghost:FireServer("NameHidden",false)
			else
				nameHidden = true
				workspace.MessageService.ShowHint.ShowHint:Fire("Name: Hidden",1)

				workspace.Main.Ghost:FireServer("NameHidden",true)

			end
		
		--turn small	
		elseif inputObject.KeyCode == Enum.KeyCode.Five then
			player.CameraMaxZoomDistance = 10
			--scale = scale - 
			workspace.Main.Ghost:FireServer("ScaleCharacter",.9)
			
		--turn into giant
		elseif inputObject.KeyCode == Enum.KeyCode.Six then
			player.CameraMaxZoomDistance = math.huge
			--scale = scale + .1
			workspace.Main.Ghost:FireServer("ScaleCharacter",1.1)
		
		
		elseif inputObject.KeyCode == Enum.KeyCode.Seven then
			if running then
				running = false
				workspace.MessageService.ShowHint.ShowHint:Fire("Runnig: false",1)
				workspace.Main.Ghost:FireServer("Running",false)
			else
				running = true
				workspace.MessageService.ShowHint.ShowHint:Fire("Running: true",1)

				workspace.Main.Ghost:FireServer("Running",true)

			end
			
		elseif inputObject.KeyCode == Enum.KeyCode.Eight then
			if shrinkRay then
				shrinkRay = false
				workspace.MessageService.ShowHint.ShowHint:Fire("Click to shrink: false",1)
				if mouseconnection then mouseconnection:disconnect() end

			else
				if mouseconnection then mouseconnection:disconnect() end
				shrinkRay = true
				workspace.MessageService.ShowHint.ShowHint:Fire("Click to shrink: true",1)
				
				local mouse = player:GetMouse()
				mouseconnection = mouse.Button1Down:connect(function()
					if mouse and mouse.Target and mouse.Target.Parent and game.Players:GetPlayerFromCharacter(mouse.Target.Parent) then
						workspace.Main.Ghost:FireServer("ShrinkRay",mouse.Target.Parent)
					end
				end)
				

			end
	
		end
	end
end)


		
