local Players = game:GetService("Players")

-- DEINE USER ID
local VERIFIED_USER_ID = 1580586066 -- ←ersetze mit deiner IDb                 	 


local function createTag(character)
	local head = character:WaitForChild("Head")

	local old = head:FindFirstChild("VerifiedTag")
	if old then
		old:Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "VerifiedTag"
	billboard.Parent = head

	-- KLEINER NAMETAG
	billboard.Size = UDim2.new(0, 145, 0, 30)

	-- WEITER RUNTER
	billboard.StudsOffset = Vector3.new(0, 2.2, 0)

	billboard.AlwaysOnTop = true
	billboard.MaxDistance = 40

	local holder = Instance.new("Frame")
	holder.BackgroundTransparency = 1
	holder.Size = UDim2.fromScale(1,1)
	holder.Parent = billboard

	-- NAME
	local nameLabel = Instance.new("TextLabel")
	nameLabel.BackgroundTransparency = 1
	nameLabel.Size = UDim2.new(1, -24, 1, 0)
	nameLabel.Position = UDim2.new(0,0,0,0)

	nameLabel.Font = Enum.Font.GothamBold
	nameLabel.TextScaled = true
	nameLabel.Text = "OWNER"

	nameLabel.TextColor3 = Color3.new(1,1,1)
	nameLabel.TextStrokeTransparency = 0.15
	nameLabel.TextStrokeColor3 = Color3.fromRGB(70,40,0)

	nameLabel.Parent = holder

	-- OG GOLD EFFECT
	local gradient = Instance.new("UIGradient")

	gradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 4)),
		ColorSequenceKeypoint.new(0.2, Color3.fromRGB(66, 230, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(92, 212, 92)),
		ColorSequenceKeypoint.new(0.8, Color3.fromRGB(255, 125, 99)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(181, 255, 243))
		
	})

	gradient.Rotation = 15
	gradient.Parent = nameLabel

	-- GLOW
	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = Color3.fromRGB(100, 70, 0)
	stroke.Parent = nameLabel

	-- SHINE ANIMATION
	task.spawn(function()
		while billboard.Parent do
			for i = -1, 1, 0.015 do
				gradient.Offset = Vector2.new(i,0)
				task.wait()
			end
		end
	end)

	-- VERIFIED ICON
	local verified = Instance.new("ImageLabel")
	verified.Name = "Verified"

	verified.BackgroundTransparency = 1

	verified.Size = UDim2.new(0,18,0,18)
	verified.Position = UDim2.new(1,-20,0.5,-9)

	-- FUNKTIONIERENDES VERIFIED ICON
	verified.Image = "rbxassetid://836086849"

	verified.Parent = holder
end

Players.PlayerAdded:Connect(function(player)
	if player.UserId == VERIFIED_USER_ID then
		player.CharacterAdded:Connect(createTag)
	end
end)

for _, player in ipairs(Players:GetPlayers()) do
	if player.UserId == VERIFIED_USER_ID and player.Character then
		createTag(player.Character)
	end
end