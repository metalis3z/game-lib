local amount = script.Parent.amount
local playername = script.Parent.playername

local function RemoveSpaces(name)
	return name:gsub('%s+', '') or name
end

function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
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

local smc2 = "SendMoneyConfirm"

local SMC = game.Lighting.Assets.GUI:FindFirstChild(smc2)

script.Parent.drop.MouseButton1Click:Connect(function()
	
	if game.Players.LocalPlayer.PlayerGui:FindFirstChild(smc2) then
		return print("found")
	end
	
	local amt = tonumber(amount.Text)
	
	if not amt then return end
	
	if game.Players.LocalPlayer.stored.Money.Value < amt then
		return _G.showMsg("You don't have enough for that!",4,"alert")
	end
	if amt <= 1 and amt ~= 1 then return _G.showMsg("Invalid input!",4,"alert") end
	
	local clo = SMC:Clone()
	clo.Amount.Value = amt
	clo.SendingName.Value = "floor"
	clo.Frame.mainText.Text = "Are you sure you want to drop $"..comma_value(amount.Text).." on the floor?"
	
	clo.Parent = game.Players.LocalPlayer.PlayerGui
	print("yes")
end)

script.Parent.sendTo.MouseButton1Click:Connect(function()
	
	local plrName = playername.Text
	local plr = nil
	
	if plrName == "" then
		return _G.showMsg("No player!",4,"alert")
	end
	
	if game.Players:FindFirstChild(plrName) then
		plr = game.Players:FindFirstChild(plrName)
	else
		plr = findPlayer(plrName)
	end
	
	if plr then
		
		local amt = tonumber(amount.Text)
		if not amt then return end

		if game.Players.LocalPlayer.PlayerGui:FindFirstChild(smc2) then
			return print("found")
		end
		
		if game.Players.LocalPlayer.stored.Money.Value < amt then
			return _G.showMsg("You don't have enough for that!",4,"alert")
		end
		if amt <= 1 and amt ~= 1 then return _G.showMsg("Invalid input!",4,"alert") end
		
		local clo = SMC:Clone()
		clo.Amount.Value = amt
		clo.SendingName.Value = plr.Name
		clo.Frame.mainText.Text = "Are you sure you want to send "..plr.Name.." $"..comma_value(amount.Text).."?"

		clo.Parent = game.Players.LocalPlayer.PlayerGui
		print("done")
	else
		_G.showMsg("Player not found!",4,"alert")
	end
end)