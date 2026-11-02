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

local showingLicenses = false
local showingLicense = false

function toggleLicensesTab(force)
	for i,v in pairs(script.Parent.NYPD.Licenses:GetChildren()) do
		v.Visible = force
	end
end

function toggleLicenseTab(force)
	for i,v in pairs(script.Parent.NYPD.License:GetChildren()) do
		v.Visible = force
	end
end

local searchPlrBtn = script.Parent.NYPD.Search
local searchLPBtn = script.Parent.NYPD.SearchLicenses

local NYPDFrame = script.Parent.NYPD

searchPlrBtn.MouseButton1Click:Connect(function()
	for i,v in pairs(NYPDFrame.Licenses.ScrollingFrame:GetChildren()) do
		if v:IsA("Frame") then
			v:Destroy()
		end
	end
	toggleLicenseTab(false)
	
	local playerName = NYPDFrame.PlayerName.Text
	local plr = nil

	if game.Players:FindFirstChild(playerName) then
		plr = game.Players:FindFirstChild(playerName)
	else
		plr = findPlayer(playerName)
	end

	if not plr then return print("no player found") end
	local response = game.ReplicatedStorage:FindFirstChild("getLicenseInfo"):InvokeServer("player",plr)
	
	if response then
		toggleLicensesTab(true)
		toggleLicenseTab(false)

		for index,res in response do
			local Frame = game.ReplicatedStorage.NYPDArrest:Clone()
			Frame.OfficerName.Text = res["Player"].Name or "Unknown"
			Frame.TimeLabel.Text = res["Car"].Name or "Unknown"
			Frame.ChargeLabel.Text = res["PLATENUMBER"] or "Unknown"
			Frame.Parent = NYPDFrame.Licenses.ScrollingFrame
		end
	else
		toggleLicenseTab(false)
		toggleLicensesTab(false)
	end
	
end)
local placeHolder = "rbxassetid://837701510"

searchLPBtn.MouseButton1Click:Connect(function()
	local licenseText = NYPDFrame.LicenseText.Text
	toggleLicensesTab(false)

	if not licenseText or licenseText == "" then 
		NYPDFrame.License.Owner.Text = "Owner: Unknown"
		NYPDFrame.License.Vehicle.Text = "Vehicle: Unknown"
		NYPDFrame.License.Stolen.Text = "Reported Stolen: Unknown"
		local icon = NYPDFrame.License.PlrThumbnail
		icon.Image = placeHolder
		toggleLicenseTab(false)
		toggleLicensesTab(false)
		return print("no input")	
	end
	local response = game.ReplicatedStorage:FindFirstChild("getLicenseInfo"):InvokeServer("license",licenseText)
	
	if response then
		print("responded")
		toggleLicensesTab(false)
		toggleLicenseTab(true)
		spawn(function()
			local content, isReady = game.Players:GetUserThumbnailAsync(response["Player"].UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
			local icon = NYPDFrame.License.PlrThumbnail
			icon.Image = (isReady and content) or placeHolder
		end)
		NYPDFrame.License.Owner.Text = "Owner: "..response["Player"].Name
		NYPDFrame.License.Vehicle.Text = "Vehicle: "..response["Car"].Name
		NYPDFrame.License.Stolen.Text = "Reported Stolen: "..tostring(response["Stolen"])
	else
		print("no respond")
		NYPDFrame.License.Owner.Text = "Owner: Unknown"
		NYPDFrame.License.Vehicle.Text = "Vehicle: Unknown"
		NYPDFrame.License.Stolen.Text = "Reported Stolen: Unknown"
		local icon = NYPDFrame.License.PlrThumbnail
		icon.Image = placeHolder
		toggleLicenseTab(false)
		toggleLicensesTab(false)
	end
	
end)

--[[
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
--]]