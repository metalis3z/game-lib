local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))
if Enums.IsPartyServer then
	script:Destroy()
	return
end

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local CameraUtil = require(game.ReplicatedStorage.Utilities.CameraUtil)
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local SoundFX = require(game.ReplicatedStorage:WaitForChild("SoundFX"))

local PlayerGui = player:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")





local GameService = workspace.GameService
local ing_drag = nil
local object_dragged = nil
local localCopy = nil
local down = false

local current_order = nil
local current_customer = nil
local current_target = nil
local objectParent = nil





local jobs_completed = Utility:SendData("GetJobsCompleted","PlayerChannel",10) or Utility:SendData("GetJobsCompleted","PlayerChannel",10) or {Cook = 0, Cashier = 0, ["Pizza Boxer"] = 0, Delivery = 0, Supplier = 0}



workspace.Main.RefreshJobsCompleted.OnClientEvent:connect(function(jobs_completed_array)
	jobs_completed = jobs_completed_array
end)




local tutorialEnabled = false
workspace.TutorialService.TutorialEnabled.OnClientEvent:connect(function(enabled)
	_G["TutorialEnabled"] = enabled
	tutorialEnabled = enabled
end)





while player.Character == nil or player.Character:FindFirstChild("Humanoid") == nil do
	wait(.1)
end




local tutorial_limit = {["Cook"] = 5,["Pizza Boxer"] = 5,["Delivery"] = 5,["Supplier"] = 10}--{["Cook"] = 25,["Pizza Boxer"] = 25,["Delivery"] = 25,["Supplier"] = 125}




GameService.RecivedCustomerOrder.OnClientEvent:connect(function(order,customer)
	current_order = order
	current_customer = customer
end)

GameService.NofityFoodOrderComplete.OnClientEvent:connect(function(failed,button)
	if button == nil then return end
	flashRegisterButton(button,failed)
end)

function flashRegisterButton(button,failed)
	if not button:FindFirstChild("SG") then return end
	local gui = button.SG.Frame
	if failed then
		gui.Check.Image = "http://www.roblox.com/asset/?id=168397389" --red x
	else
		gui.Check.Image = "http://www.roblox.com/asset/?id=168401336"  --check mark
		button.Sparkles.Enabled = true
	end
	--button.BrickColor = color
	delay(1.5,function() button.Sparkles.Enabled = false gui.Check.Image = "" end)
end

function changeJob(job_name)
	local currentJobName = player.Team.Name
	if currentJobName and currentJobName ~= job_name and currentJobName ~= "Manager" then
		Utility:SendData("ChangeJob","PlayerChannel",nil,job_name)
	end
end

player.Changed:connect(function (prop) 
	if prop == "TeamColor" then
		
		local jobchange = MainGui.Notifications.JobChange
		jobchange.JobName.TextColor3 = player.TeamColor.Color
		jobchange.JobName.Text = Enums.BrickColorToTeamName[player.TeamColor.Number] or ""
		jobchange:TweenPosition(UDim2.new(.8, 0, .8, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,1,true)
		--MainGui.Notifications.Multiplier.Visible = false
		delay(3,function()
			jobchange:TweenPosition(UDim2.new(1, 0, .8, 0),Enum.EasingDirection.InOut,Enum.EasingStyle.Sine,1,true)
			wait(1)
			--MainGui.Notifications.Multiplier.Visible = true
		end)
		
	
		
		--[[if player.TeamColor ~= BrickColor.new(37) then
			local character = player.Character
			if character ~= nil then
				local uniform = nil
				if character:FindFirstChild("Uniform") and character.Uniform.ShirtTemplate ~= "http://www.roblox.com/asset/?id=147222549"  then
					uniform = character.Uniform
					character["Body Colors"].LeftLegColor = BrickColor.new(1003)
					character["Body Colors"].RightLegColor = BrickColor.new(1003)
				elseif character.Head:FindFirstChild("Uniform") and character.Head.Uniform.ShirtTemplate ~= "http://www.roblox.com/asset/?id=147222549"  then
					uniform = character.Head.Uniform
				else
					return
				end
				uniform.ShirtTemplate = "http://www.roblox.com/asset/?id=147222549"
				if uniform.Parent:FindFirstChild("BusinessSkirt") ~= nil then
					uniform.Parent.BusinessSkirt:Destroy()
				end
			end
		end]]
	end
end)


local buttons = {
	Cheese = 1,
	Pepperoni = 2,
	Sausage = 3,
	MountainDew = 4
}



local sel = Instance.new("SelectionBox")
sel.Parent = script

local FloorWire = Instance.new("FloorWire")
FloorWire.Transparency = 0.5
FloorWire.WireRadius = 0
FloorWire.TextureSize = Vector2.new(2,2)
FloorWire.Texture = "http://www.roblox.com/asset/?id=168194931"
FloorWire.Parent = script

--[[if workspace:FindFirstChild("LocalParts") == nil then
	local c = Instance.new("Camera")
	c.Parent = workspace
	c.Name = "LocalParts"
	script.DewSpot.Parent = c
	script.DewSpot2.Parent = c
	script.OvenSpot.Parent = c
	script.TableSpot.Parent = c
	script.BoxSpot.Parent = c
end]]
local_parts = workspace.Spots


local image = nil


local selected_ingredient = nil
local click_speed = Vector3.new(0,0,0)
local click_distance = 0
local movement = 0
local dragables = {Dough = true, Pizza = true, MountainDew = true, Dew = true, BoxClosed = true,SupplyBox = true}


local dragger = Instance.new("Dragger")


function displayGuideArrows(obj)
	FloorWire.To = obj
	if obj.Name ~= "Bottom" then 
		script[obj.Name].Enabled = true 
	end
	script.ArrowBillboardGui.Enabled = true
	script.ArrowBillboardGui.Adornee = obj

end

local touchEnabled = false
local UIS = game:GetService("UserInputService")
if UIS.TouchEnabled then
	touchEnabled = true
end

function workspace.TutorialService.IsTouchEnabled.OnClientInvoke()
	return touchEnabled
end

local camera = workspace.CurrentCamera
local cameraState = nil
local inputChanged = nil
local absoluteSizeX = MainGui.AbsoluteSize.X
local absoluteSizeY = MainGui.AbsoluteSize.Y
local lastDoughGrabbed = nil


local RunService = game:GetService("RunService")
_G["MouseLockEnabled"] = true
function cameraLock(enabled)
	if not _G["MouseLockEnabled"] then return end
	if touchEnabled and _G["StartedPlaying"] then --
		if enabled then
			script.CameraLock.Value = true
			--cameraState = camera.CameraType
			camera.CameraType = "Scriptable"
			UIS.ModalEnabled = true
			
			inputChanged = UIS.InputChanged:connect(function(inputObject,gameProcessed)
				if inputObject.UserInputType == Enum.UserInputType.Touch then
					
					local position = inputObject.Position
					if position.X < absoluteSizeX/8  then
					 	CameraUtil:TweenPan(player,-1.5)
					
					elseif position.X > absoluteSizeX - (absoluteSizeX/8) then
						CameraUtil:TweenPan(player,1.5)

					else
						CameraUtil:EndTweenPan()
						
					end
				end
			end)
			
		else
			script.CameraLock.Value = false
			camera.CameraType = "Custom"--cameraState
			UIS.ModalEnabled = false
			if inputChanged then
				CameraUtil:EndTweenPan()
				inputChanged:disconnect()
				inputChanged = nil
			end
		end
	end
		
end

function SurfaceGuisEnabled(object,enabled)
	for _,obj in ipairs(object:GetChildren()) do
		if obj:IsA("SurfaceGui") then
			obj.Enabled = enabled
		end
	end
end


local DraggableObject = nil
function copyLocal(draggableObject)
	localCopy = draggableObject:clone()
	localCopy.Parent = draggableObject.Parent
	localCopy.CFrame = draggableObject.CFrame
	localCopy.Name = "LocalCopy"
	localCopy.CanCollide = false
	localCopy.Anchored = true
	
	
	
	--[[SurfaceGuisEnabled(draggableObject,false)
	draggableObject.Transparency = 1
	localCopy.CanCollide = false
	localCopy.Anchored = true]]
	DraggableObject = draggableObject
	draggableObject.Parent = game.ReplicatedStorage
	
end
		
		
		
		
		

local dragging = false
function onButton1Down()
	if mouse ~= nil and mouse.Target ~= nil and  mouse.Target.Parent ~= nil then
		
		if script.CameraLock.Value then
			cameraLock(false)
		end
		
		movement = 0
		if jobs_completed == nil then print("ERROR jobcomplted null") return end
		local tar = mouse.Target
		if tar:FindFirstChild("Tutorial") and tar.Tutorial.Value ~= game.Players.LocalPlayer then print("NOT ALLOWED") return end
		if player:DistanceFromCharacter(mouse.Hit.p) > 120 then return end
		click_speed = tick()
		click_distance = mouse.Hit.p
		onMove()--for mobile
		if tar == nil then return end
		
		--when finished dragging somthing
		if down then --mouse up
			

			if tutorialEnabled and object_dragged and object_dragged.Parent then
				if object_dragged.Name == "Dough" and (object_dragged.Position - workspace.CookTable.Position).magnitude < 13 then
					 workspace.TutorialService.PlayerAction:FireServer("DraggedToTable",true)
			
				elseif object_dragged.Name == "Dough" and (object_dragged.Position - workspace.OvenBelt.Position).magnitude < 8 then
					 workspace.TutorialService.PlayerAction:FireServer("DraggedToOven",true)
				
				elseif object_dragged.Name == "BoxClosed" and (object_dragged.Position - workspace.BoxBelt.Position).magnitude < 18 then
					local obj = object_dragged
					spawn(function()
						wait(.5)
						 if math.abs(obj.Position.Y-5) < 1 then
						 	workspace.TutorialService.PlayerAction:FireServer("DraggedToDelivery",true)
						end
					end)
				elseif object_dragged.Name == "SupplyBox" then
					if (object_dragged.Position - workspace.SupplyBelt.Position).magnitude < 18 and object_dragged.Position.Z > -13 then --if dragging to belt
						workspace.TutorialService.PlayerAction:FireServer("DraggedToSupplyBelt",true)
					else
						--if dragged to truck
						for _,truck in ipairs(workspace.Trucks:GetChildren()) do
							if truck and truck:FindFirstChild("Bottom") and (truck.Bottom.Position - object_dragged.Position).magnitude < 13 then
								workspace.TutorialService.PlayerAction:FireServer("DraggedToTruck",true)
							end
						end
					end
				end
				lastDoughGrabbed = object_dragged
				--
			end
			
			SoundFX:PlaySound("Drop")
			mouse.Icon = ""
			mouse.TargetFilter = nil
			--workspace.GameService.DraggingObject:FireServer(object_dragged,localCopy.CFrame)
			
			down = false
			dragger:MouseUp()
			FloorWire.To = nil
			FloorWire.From = nil
		 	script.TableSpot.Enabled = false
			script.OvenSpot.Enabled = false
			script.DewSpot.Enabled = false
			script.DewSpot2.Enabled = false
			script.SupplyBoxSpot.Enabled = false
			script.BoxSpot.Enabled = false
			script.ArrowBillboardGui.Enabled = false
			local obj = object_dragged
			local localObj = localCopy
			object_dragged = nil
			--wait(.5)
		--	obj.CFrame = localCopy.CFrame
			
			if localObj.Parent ~= game.ReplicatedStorage then --in replicated storage when pizza is inside box
				local timeout = 30
				while (localObj.Position - obj.Position).magnitude > .05 and timeout > 0 do --wait for server verion to catch up
					wait() 
					timeout = timeout - 1
				end 
			end
			workspace.GameService.UpdateObjectProperty:FireServer(obj,"Anchored",false)
			localObj:Destroy()
			if obj.Parent == game.ReplicatedStorage then obj.Parent = objectParent end
			
			cameraLock(false)
			dragging = false
			
			return
		end
		if (tar.Parent.Name == "Register1" or tar.Parent.Name == "Register2" or tar.Parent.Name == "Register3") and tar:FindFirstChild("Pressed") then
			sel.Adornee = nil
			changeJob("Cashier")
			--make button on register press
			if not tar.Pressed.Value then
				--if current_order == nil and current_customer == nil then
					SoundFX:PlaySound("RegisterButtonDown")
				--end
				local tarframe = tar.CFrame
				--tar.BrickColor = BrickColor.new("Medium stone grey")
				local x,y,z,r00,r01,r02,r10,r11,r12,r20,r21,r22 = tar.CFrame:components()
				tar.CFrame = tarframe + (Vector3.new(-r01,-r11,-r21) / 5.3)
				--workspace.GameService.UpdateObjectProperty:FireServer(tar,"BrickColor",BrickColor.new("Medium stone grey"))
				--workspace.GameService.UpdateObjectProperty:FireServer(tar,"CFrame",tar.CFrame)
				--workspace.GameService.UpdateObjectProperty:FireServer(tar.Pressed,"Value",true)
				tar.Pressed.Value = true
				
				delay(.1,function()
					SoundFX:PlaySound("RegisterButtonUp")
					--tar.BrickColor = BrickColor.new("Lily white")
					tar.CFrame = tarframe
					tar.Pressed.Value = false
					--workspace.GameService.UpdateObjectProperty:FireServer(tar,"CFrame",tarframe)
					--workspace.GameService.UpdateObjectProperty:FireServer(tar.Pressed,"Value",false)

					--workspace.GameService.UpdateObjectProperty:FireServer(tar,"BrickColor",BrickColor.new("Lily white"))

				end)
			--[[elseif tar.BrickColor == BrickColor.new("Medium stone grey") then
				tar.CFrame = tar.CFrame + Vector3.new(0,.092,-.052)
				local tarframe = tar.CFrame
				tar.Size = Vector3.new(2,.4,2)
				tar.CFrame = tarframe
				workspace.GameService.UpdateObjectProperty:FireServer(tar,"Size",Vector3.new(2,.4,2))
				workspace.GameService.UpdateObjectProperty:FireServer(tar,"CFrame",tarframe)]]
			end
			
			--process cusomer order
			local button_name = string.sub(tar.Name,7)
			if current_order ~= nil and current_customer ~= nil then
				if buttons[button_name] == current_order then
					
					flashRegisterButton(tar,false)
					
					GameService.OrderCompleted:FireServer(current_customer,false)
				--[[elseif current_order == 5 then --order ordering pizza
					flashRegisterButton(tar,false)
					GameService.OrderCompleted:FireServer(current_customer,buttons[button_name])]]
				else
					flashRegisterButton(tar,true)
					GameService.OrderCompleted:FireServer(current_customer,true)
	
				end
				current_order = nil
				current_customer = nil
				return
			else
				workspace.GameService.RegisterButtonPressedNoCustomer:FireServer(buttons[button_name],tar)
			end
		--[[elseif tar.Parent.Name == "Phone" then
			changeJob("Cashier")
			current_customer = GameService.PickUpPhone:InvokeServer()
			if current_customer ~= nil then
				current_order = 5
			end
			return
		]]
		--start drag ingriedient
		elseif tar.Parent.Name == "Ingredients" and not selected_ingredient and (tar.Transparency == 0 or tar:FindFirstChild("Dragger")) then
			if tutorialEnabled and tar.Name == "Sausage" then
				return
			end
			local ing = {Cheese = true,Pepperoni = true,Sausage = true,TomatoSauce = true}
			if not ing[tar.Name] then return end
			
			if tar:FindFirstChild("CurrentDragger") then
				local drag_val = tar.CurrentDragger.Value
				if drag_val  and (drag_val  ~= player or drag_val.Parent == nil)  then 
					print("Another player already dragging") 
					return 
				end
			end
			
			
			 --for mobile
			SoundFX:PlaySound("PickUp")
			changeJob("Cook")
			mouse.Icon = "http://www.roblox.com/asset/?id=168756505"

			ing_drag = workspace.GameService.RequestIngredientObject:InvokeServer(tar)
			if ing_drag ~= nil then
				

				dragging = true
				cameraLock(true)

				objectParent = ing_drag.Parent
	
				image = ing_drag.SG.Frame.ImageLabel
				
				copyLocal(ing_drag)
				
				mouse.TargetFilter = localCopy--ing_drag
				selected_ingredient = ing_drag.Name
			
			else
				mouse.Icon = ""
				
				--cameraLock(false) --for mobile
				--dragging = false
			end
			
		
			
			
			
			
			if tutorialEnabled then
				workspace.TutorialService.PlayerAction:FireServer(tar.Name,true)
				if lastDoughGrabbed then
					FloorWire.To = lastDoughGrabbed
					FloorWire.From = localCopy--ing_drag
				end
			end
			
			return
		end
		
		--adding topping to pizza
		
		if selected_ingredient and tar.Parent.Name ~= "Ingredients" then --if placing on pizza dough
			
			if tar.Name == "Dough" and not ing_drag.SG.Frame:FindFirstChild("ImageLabel") then
				
				if image.Parent ~= tar.SG.Frame then image.Parent = tar.SG.Frame end  --FOR Mobile
				--local newimage = image:clone()
				--newimage.Name = "ImageLabel"
				--newimage.Parent = ing_drag.SG.Frame
				workspace.GameService.DestroyIngredient:FireServer(ing_drag,false)
				
				image.Name = selected_ingredient
				workspace.GameService.UpdateObjectProperty:FireServer(image,"Name",image.Name )--	workspace.GameService.UpdateObjectName:FireServer(image,image.Name )
				
			
				
			else --if placing on ground
				ing_drag.Parent = workspace.Ingredients
				workspace.GameService.ReleaseOwnership:FireServer(ing_drag)
			end
			
			localCopy:Destroy()
			FloorWire.To = nil
			FloorWire.From = nil
			mouse.TargetFilter = nil
			SoundFX:PlaySound("Drop")
			mouse.Icon = ""
			selected_ingredient = nil
			
			--[[if ing_drag then 
				local obj = ing_drag
				spawn(function()
					while true do
						wait(10)
						if obj and obj.Parent ~= nil and obj ~= ing_drag then
							
							if obj then workspace.GameService.DestroyIngredient:FireServer(obj,false) end
							break
						elseif obj == nil or obj.Parent == nil then
							break
						end
					end
				end)
			 end]]
			
			ing_drag = nil
		


			return
		elseif selected_ingredient and tar.Parent.Name == "Ingredients" then  --put ingreident back
			SoundFX:PlaySound("Drop")
			
			workspace.GameService.DestroyIngredient:FireServer(ing_drag,false)
			localCopy:Destroy()
			selected_ingredient = nil
			mouse.Icon = ""
			
			return
		end
		if tar.Name == "Box" then   --close box
			changeJob("Pizza Boxer")
			GameService.CloseBox:FireServer(tar)
			if tutorialEnabled then
				workspace.TutorialService.PlayerAction:FireServer("ClosedBox",tar)
			end
			return
		end
		if not tar.Locked and tar.Name == "Handle" and tar.Parent:IsA("Tool") then  --
			if tutorialEnabled and tar.Parent.Name == "PizzaTool" then
				workspace.TutorialService.PlayerAction:FireServer("GrabbedPizza",true)
			end
			workspace.GameService.AddPizzaToBackpack:FireServer(tar.Parent)
		end
		
		--draggin objects
		if dragables[tar.Name] then
			local drag_val = tar.CurrentDragger.Value
			if drag_val  and (drag_val  ~= player or drag_val.Parent == nil)  then print("Another player already dragging") return end
		--	game.Workspace.InventoryService.Emotion:Invoke("Work")--pcall(function() player.Character.Torso["Right Shoulder"].CurrentAngle = 1.6 end)
			SoundFX:PlaySound("PickUp")
	
			
			mouse.Icon = "http://www.roblox.com/asset/?id=168756505"
			objectParent = tar.Parent
			tar.Transparency = 0
			copyLocal(tar)
			object_dragged = tar
			
			workspace.GameService.DraggingStarted:FireServer(object_dragged)
			
			if down then dragger:MouseUp() end
			cameraLock(true)
			dragging = true
			down = true
			dragger:MouseDown( localCopy, mouse.Target.Position - mouse.Hit.p,{localCopy})
			workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"Anchored",true)
			localCopy.Rotation = Vector3.new(0,0,0)
			--[[if tar.Name == "Dough" or tar.Name == "Pizza" then
				localCopy.Rotation = Vector3.new(-90,-90,0)
			end]]
			FloorWire.To = nil
			FloorWire.From = localCopy
			
			sel.Adornee = localCopy
			sel.Color = player.TeamColor
			
			if tar.Name == "MountainDew" then
				changeJob("Cook")
				if jobs_completed["Cook"] < tutorial_limit["Cook"] then

					displayGuideArrows(local_parts.DewSpot)

				end
			elseif tar.Name == "Dough" and not tar.SG.Frame:FindFirstChild("MeltedCheese") then
				if tutorialEnabled then
					workspace.TutorialService.NewDough:FireServer(tar)
				end
				changeJob("Cook")
				if jobs_completed["Cook"] < tutorial_limit["Cook"] then
					if tar.SG.Frame:FindFirstChild("TomatoSauce") and tar.SG.Frame:FindFirstChild("Cheese") then
						displayGuideArrows(local_parts.OvenSpot)

					else
						displayGuideArrows(local_parts.TableSpot)
					end
				end
			elseif tar.Name == "BoxClosed" then
				changeJob("Pizza Boxer")
				if jobs_completed["Pizza Boxer"] < tutorial_limit["Pizza Boxer"] then

					displayGuideArrows(local_parts.BoxSpot)
				end
			elseif tar.Name == "Pizza" then
				if tutorialEnabled then --remove arrows?
					for _,obj in ipairs(MainGui:GetChildren()) do
						if obj:IsA("BillboardGui") then
							if obj.Adornee == tar then
								obj:Destroy()
							end
						end
					end
					workspace.TutorialService.NewPizza:FireServer(tar)
				end
				changeJob("Pizza Boxer")
				if jobs_completed["Pizza Boxer"] < tutorial_limit["Pizza Boxer"] then
					FloorWire.To = workspace.AllBox:FindFirstChild("Box")
				end
			elseif tar.Name == "Dew" then
				changeJob("Pizza Boxer")	
				if jobs_completed["Pizza Boxer"] < tutorial_limit["Pizza Boxer"] then
					displayGuideArrows(local_parts.DewSpot2)
				end
		
			elseif tar.Name == "SupplyBox" then
				changeJob("Supplier")
				if jobs_completed["Supplier"] < tutorial_limit["Supplier"] then
					local trucks = workspace.Trucks:GetChildren()
					local closest = nil
					
					if tutorialEnabled and trucks[1].Driver:FindFirstChild("TutorialPlayerOnly") and trucks[1].Driver.TutorialPlayerOnly.Player.Value == game.Players.LocalPlayer then
						closest = trucks[1].Bottom
				
					elseif tutorialEnabled and #trucks == 2 and trucks[2].Driver:FindFirstChild("TutorialPlayerOnly") and trucks[2].Driver.TutorialPlayerOnly.Player.Value == game.Players.LocalPlayer then
						closest = trucks[2].Bottom
					
					else
						if #trucks == 2 and player:DistanceFromCharacter(trucks[1].Bottom.Position) > player:DistanceFromCharacter(trucks[2].Bottom.Position) then
							closest = trucks[2].Bottom
						elseif #trucks ~= 0 then
							closest = trucks[1].Bottom
						else
							closest = workspace.Border
						end
						
					end
					if player:DistanceFromCharacter(workspace.SupplyBelt.Position) < 120 then
						closest = local_parts.SupplyBoxSpot
						script.SupplyBoxSpot.Enabled = true
							
					end
					
					displayGuideArrows(closest)
				end
			end
			
			mouse.TargetFilter = localCopy
			
			

		end
		
		if tar.Parent:FindFirstChild("Humanoid") and game.Players:GetPlayerFromCharacter(tar.Parent) ~= nil and player.TeamColor == BrickColor.new(37) then
			local selected_player = game.Players:GetPlayerFromCharacter(tar.Parent)
			if selected_player ~= player then
				local gui = MainGui.Menu.Manage
				gui.Current_Player.Value = selected_player
				GuiManager:GetWindowDataByName("Manage"):SetVisible(true)
			end
		end
		
	end
end

function onButton1Up()
	
	
	
	--if clicking and dragging then let go when player lifts finger
	if movement > 5 or _G.GamepadEnabled then--if tick() - click_speed > .1 and (click_distance - mouse.Hit.p).magnitude > .8 then
		--if not touchEnabled then
			onButton1Down()
		--end
	elseif dragging then --tapping instead of dragging
		cameraLock(false)
	end
	if tutorialEnabled then
		workspace.TutorialService.PlayerAction:FireServer("ButtonUp",true)
	end

	--[[if dragging then
		print("DRAGGING = FALSAE")
		cameraLock(false)
		dragging = false
	end]]
end

function Weld(x,y)
	local W = Instance.new("Weld")
	W.Name = "PizzaWeld"
	W.Part0 = x
	W.Part1 = y
	local CJ = CFrame.new(x.Position)
	local C0 = x.CFrame:inverse()*CJ
	local C1 = y.CFrame:inverse()*CJ
	W.C0 = C0
	W.C1 = C1
	W.Parent = x
end


local current_box = nil
local last_target = nil

local camera = workspace.CurrentCamera
local tar1 = nil
local hand = nil
local last_position = Vector3.new(0,0,0)
local currentButton = nil
--local switch = 0
function onMove()
	--if switch >= 3 then switch = 0  else switch = switch + 1 return end
	if mouse and mouse.Target and mouse.Target.Parent then
		if down or selected_ingredient then movement = movement + 1 end
		tar1 = mouse.Target
		if tar1 == nil then return end
		if player:DistanceFromCharacter(mouse.Hit.p) > 120 then return end
		if down then
			
			if tar1.Parent.Name == "Spots" and script[tar1.Name].Enabled then
				localCopy.Position = tar1.Position
				workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"CFrame",localCopy.CFrame)
				return
			end
			if tar1 == current_box then return end
			--dragging into box
			if object_dragged.Name == "Pizza" and tar1.Name == "Box" and tar1:FindFirstChild("PizzaWeld") == nil then
				
				if tar1:FindFirstChild("Tutorial") and tar1.Tutorial.Value ~= game.Players.LocalPlayer then return end

				if tutorialEnabled then
					workspace.TutorialService.NewBox:FireServer(tar1)
				end
				
				current_box = tar1
				object_dragged.Parent = objectParent
				localCopy.Parent = game.ReplicatedStorage
				mouse.TargetFilter = object_dragged
				
				object_dragged:BreakJoints()
				object_dragged.Size = Vector3.new(4.6,.4,4.6) 
				object_dragged.CFrame = tar1.CFrame - Vector3.new(0,2,0)--tar1.CFrame * CFrame.Angles(0,0,math.pi/2) - Vector3.new(0,2,0)
				
				
				--workspace.GameService.WeldObject:FireServer(current_box,object_dragged)
				--workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"Size",object_dragged.Size)
				--workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"CFrame",object_dragged.CFrame)
				
				workspace.GameService.PutInBox:FireServer(object_dragged,current_box,Vector3.new(4.6,.4,4.6))
				
				
				--Weld(current_box,object_dragged)
			else --dragging anything else
				
				if current_box and object_dragged.Name == "Pizza" then--dragging out of box
					object_dragged:BreakJoints()
					
					object_dragged.Size = Vector3.new(5,.4,5)
					workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"Size",object_dragged.Size)
					
					object_dragged.Anchored = true
					workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"Anchored",true)
					
					current_box = nil
					localCopy.Parent = objectParent
					object_dragged.Parent = game.ReplicatedStorage
					localCopy.Transparency = 0
					localCopy.SG.Enabled = true
					mouse.TargetFilter = localCopy
				--	dragger:MouseDown( localCopy, mouse.Target.Position - mouse.Hit.p,{localCopy})
				end
				--local ray = Ray.new(camera.CoordinateFrame.p,(camera.CoordinateFrame.p * camera.CoordinateFrame.lookVector) * 500)
				dragger:MouseMove(mouse.UnitRay)
				if last_position ~= localCopy.Position then
				
					workspace.GameService.UpdateObjectProperty:FireServer(object_dragged,"CFrame",localCopy.CFrame)
					last_position = localCopy.Position
				end
			end
		end
		hand = nil
		
		
		if tar1 ~= last_target and not tar1.Locked  and not down and (selected_ingredient == nil or tar1.Name == "Dough") then  --highlitght unlocked object
			
		
				sel.Adornee = tar1
			
				sel.Color = player.TeamColor
				
		elseif tar1.Parent:FindFirstChild("Register") and tar1.BrickColor == BrickColor.new("Medium stone grey") and tar1 ~= currentButton then  --register button
			if currentButton then
				currentButton.BrickColor = BrickColor.new("Medium stone grey")
			end
			tar1.BrickColor = BrickColor.new("Lily white")
			currentButton = tar1
		
			
		elseif player.TeamColor == BrickColor.new(37) and tar1.Parent:FindFirstChild("Humanoid") and game.Players:GetPlayerFromCharacter(tar1.Parent) then --hover over person as maanger
		
			sel.Adornee = tar1.Parent
			
			sel.Color = player.TeamColor
			
		else
			sel.Adornee =nil
			if currentButton and tar1 ~= currentButton then
				currentButton.BrickColor = BrickColor.new("Medium stone grey")
				currentButton = nil
			end
		end
	
		--dragging ingredients
		if selected_ingredient ~= nil  then --
			if tar1:FindFirstChild("Tutorial") and tar1.Tutorial.Value ~= game.Players.LocalPlayer then return end
			--add ingreidnt to dough
			
			if tar1.Name == "Dough" and tar1.SG.Frame:FindFirstChild(selected_ingredient) == nil then
				if image.Parent ~= tar1.SG.Frame then 
					image.Parent = tar1.SG.Frame
					workspace.GameService.UpdateObjectProperty:FireServer(image,"Parent",tar1.SG.Frame)
					if localCopy and localCopy.Parent and localCopy:FindFirstChild("SG") then
						localCopy.SG.Enabled = false
					end
				end
			elseif ing_drag then
				if image.Parent ~= ing_drag.SG.Frame then --remove from pizza dough
					image.Parent = ing_drag.SG.Frame 
					workspace.GameService.UpdateObjectProperty:FireServer(image,"Parent",ing_drag.SG.Frame)
					if localCopy and localCopy.Parent and localCopy:FindFirstChild("SG") then
						localCopy.SG.Enabled = true
					end
				end
				if localCopy and localCopy.Parent then
					localCopy.CFrame = CFrame.new(mouse.Hit.p)--ing_drag.CFrame = CFrame.new(mouse.Hit.p)
					workspace.GameService.UpdateObjectProperty:FireServer(ing_drag,"CFrame",localCopy.CFrame)
				end
			end
			
		end
	end
end




--[[
---refreshing chatboxes
script.Parent:WaitForChild("Lane1")
script.Parent:WaitForChild("Lane2")

lane1 = script.Parent.Lane1
lane2 =  script.Parent.Lane2

workspace.GameService.RefreshAllChatboxes.OnClientEvent:connect(function()

	
	
	for i,cus in ipairs(workspace.Customers:GetChildren()) do
		local target = cus.Humanoid.WalkToPart
		if target ~= nil and script.Parent:FindFirstChild(target.Name) and cus.TalkingTo.Value == nil then
			local billboard = script.Parent[target.Name]
			billboard.Adornee = cus.Head
			billboard.Enabled = true
		end
	end
	local lane1Target = lane1.Adornee
	if lane1Target ~= nil and (lane1Target.Parent.Humanoid.WalkToPart ~= game.Workspace.Lane1 or lane1Target.Parent.TalkingTo.Value ~= nil or lane1Target.Parent.TalkingTo.Value == player) then
		lane1.Adornee = nil
		lane1.Enabled = false
	end
	
	local lane2Target = lane2.Adornee
	if lane2Target ~= nil and (lane2Target.Parent.Humanoid.WalkToPart ~= game.Workspace.Lane2 or lane2Target.Parent.TalkingTo.Value ~= nil or lane2Target.Parent.TalkingTo.Value == player) then
		lane2.Adornee = nil
		lane2.Enabled = false
	end
	
end)


function chatBoxClick(billboard)
	
	local head = billboard.Adornee
	if head ~= nil then
		current_order = GameService.GetCustomerOrder:InvokeServer(head.Parent,player)
		if current_order ~= nil then
			current_customer = head.Parent
		end
	end
end

lane1.Bubble.MouseButton1Click:connect(function()  chatBoxClick(lane1) end)
lane1.Question.MouseButton1Click:connect(function()   chatBoxClick(lane1) end)

lane2.Bubble.MouseButton1Click:connect(function() chatBoxClick(lane2) end)
lane2.Question.MouseButton1Click:connect(function() chatBoxClick(lane2) end)

]]

mouse.Button1Down:connect(onButton1Down)
mouse.Button1Up:connect(onButton1Up)
mouse.Move:connect(onMove)
local holding = false


if _G.GamepadEnabled then
	UIS.InputBegan:connect(function(inputObject,gameProcessed)
		if not gameProcessed and not holding then
			if inputObject.UserInputState == Enum.UserInputState.Begin and inputObject.KeyCode == Enum.KeyCode.ButtonR2 then
				game:GetService("RunService"):BindToRenderStep("CameraMovement",Enum.RenderPriority.Camera.Value,function()
					onMove()
				end)
				holding = true
			end
			
		end
	end)
	
	UIS.InputEnded:connect(function(inputObject,gameProcessed)
		if not gameProcessed and holding then
			if inputObject.UserInputState == Enum.UserInputState.End and inputObject.KeyCode == Enum.KeyCode.ButtonR2 then
				
				game:GetService("RunService"):UnbindFromRenderStep("CameraMovement")
				holding = false
			end
		end
	end)
	
	
--[[	UIS.InputChanged:connect(function(inputObject,gameProcessed)
		if gameProcessed then
			if inputObject.KeyCode == Enum.KeyCode.Thumbstick1 or inputObject.KeyCode == Enum.KeyCode.Thumbstick2 then
				onMove()
			end
		end
	end)]]
end
