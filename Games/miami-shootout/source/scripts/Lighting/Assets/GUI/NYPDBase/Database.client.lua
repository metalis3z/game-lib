local frame = script.Parent.NYPD

local function RemoveSpaces(name)
	return name:gsub('%s+', '') or name
end

local function findPlayer(name)
	name = RemoveSpaces(name)
	for i, player in pairs(game:GetService('Players'):GetPlayers()) do
		if player.Name:lower():match('^'.. name:lower()) then
			print("returning PLAYER")
			return player
		end
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if player.Character and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Humanoid").DisplayName then
				if player.Character:FindFirstChild("Humanoid").DisplayName:lower():match('^'.. name:lower()) then
					print("returning DISPLAY NAME")
					return player
				end
			end
		end
	end
	return nil
end

frame.Search.MouseButton1Click:Connect(function()
	
	for i,v in pairs(frame.ScrollingFrame:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	
	local plrName = frame.PlayerName.Text
	local plr = nil
	
	if game.Players:FindFirstChild(plrName) then
		plr = game.Players:FindFirstChild(plrName)
	else
		plr = findPlayer(plrName)
	end
	
	if not plr then return end
	
	local res = game.ReplicatedStorage:FindFirstChild("getArrests"):InvokeServer(plr)
	for i,v in pairs(res) do
		--officer = officer id
		--officerName = officer name
		--seconds - timer
		--charges - table
		
		local chargeText = ""
		
		print(tostring(v["charges"]))
		
		if #v["charges"] == 1 then
			chargeText = v["charges"][1]
		else
			chargeText = v["charges"][1]
			for ind,charge in pairs(v["charges"]) do
				if ind ~= 1 then
					chargeText = chargeText .. ", "..charge
				end
			end
		end
		
		local Frame = game.ReplicatedStorage.NYPDArrest:Clone()
		Frame.OfficerName.Text = v["officerName"]
		Frame.TimeLabel.Text = v["seconds"]
		Frame.ChargeLabel.Text = chargeText
		Frame.Parent = frame.ScrollingFrame
	end
	frame.ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, frame.ScrollingFrame.UIListLayout.AbsoluteContentSize.Y)
end)