wait()
local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()

local Char = Player.Character
local db = false

local unpassable = {'Fist', 'Phone', 'Btools', 'DeliveryFood', 'ArrestTool', 'GrabTool', 'Box'}

Mouse.KeyDown:connect(function(k)
	if string.lower(k) == "q" and Char:FindFirstChildOfClass('Tool') then
		if table.find(unpassable, Char:FindFirstChildOfClass('Tool').Name) then return end
		local character = Player.Character

		local head = Player.Character:WaitForChild("HumanoidRootPart")

		local origin = head.Position
		local lookDirection = head.CFrame.lookVector
		local ray = Ray.new(origin, lookDirection * 50)

		local part, hitPosition = workspace:FindPartOnRay(ray, character)

		if not part then return end
		local partparent = part.Parent

		if part.Parent:FindFirstChild("Humanoid") then
			partparent = part.Parent
		else
			partparent = part.Parent.Parent	
		end

		if partparent:FindFirstChild("Humanoid") then
			local HRP = partparent:FindFirstChild("HumanoidRootPart")

			if HRP then
				db = true
				local hit = part
				if (Char.HumanoidRootPart.Position - HRP.Position).magnitude < 5 then
					if game.Players:FindFirstChild(partparent.Name) then
						local tool = character:FindFirstChildOfClass('Tool')
						if tool:FindFirstChild('POLICE') then return end
						Char.Humanoid:UnequipTools()
						local anim1 = Char.Humanoid:LoadAnimation(script.gives)
						anim1:Play()
						local anim2 = HRP.Parent.Humanoid:LoadAnimation(script.takes)
						anim2:Play()
						game:FindService('ReplicatedStorage'):FindFirstChild('HAA'):FireServer(partparent, Player, tool)
						wait(.25)
						db = false
					end
				end	

			end
		end
	end
end)

game:FindService('UserInputService').InputBegan:Connect(function(Key, Processed)
	if not Processed then
		if Key.KeyCode == Enum.KeyCode.DPadUp then
			if Char:FindFirstChildOfClass('Tool') then
				if table.find(unpassable, Char:FindFirstChildOfClass('Tool').Name) then return end
				local character = Player.Character

				local head = Player.Character:WaitForChild("HumanoidRootPart")

				local origin = head.Position
				local lookDirection = head.CFrame.lookVector
				local ray = Ray.new(origin, lookDirection * 50)

				local part, hitPosition = workspace:FindPartOnRay(ray, character)

				if not part then return end
				local partparent = part.Parent

				if part.Parent:FindFirstChild("Humanoid") then
					partparent = part.Parent
				else
					partparent = part.Parent.Parent	
				end

				if partparent:FindFirstChild("Humanoid") then
					local HRP = partparent:FindFirstChild("HumanoidRootPart")

					if HRP then
						db = true
						local hit = part
						if (Char.HumanoidRootPart.Position - HRP.Position).magnitude < 5 then
							if game.Players:FindFirstChild(partparent.Name) then
								local tool = character:FindFirstChildOfClass('Tool')
								if tool:FindFirstChild('POLICE') then return end
								Char.Humanoid:UnequipTools()
								local anim1 = Char.Humanoid:LoadAnimation(script.gives)
								anim1:Play()
								local anim2 = HRP.Parent.Humanoid:LoadAnimation(script.takes)
								anim2:Play()
								game:FindService('ReplicatedStorage'):FindFirstChild('HAA'):FireServer(partparent, Player, tool)
								wait(.25)
								db = false
							end
						end	

					end
				end
			end
		end
	end
end)