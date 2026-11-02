local cserver = game.ReplicatedStorage:WaitForChild("CServer")
wait(2)
local player = game.Players.LocalPlayer

function isRagged()
	local newHum = game.Players.LocalPlayer.Character.Humanoid
	local setEnabled = newHum:GetState() ~= Enum.HumanoidStateType.Physics

	if setEnabled == true then
		return "NotRagged"
	else
		return "Ragged"
	end
end


local plr = game.Players.LocalPlayer
local character = game.Players.LocalPlayer.Character or plr.CharacterAdded:Wait()
local humanoid = game.Players.LocalPlayer.Character:WaitForChild("Humanoid") 
local ragdolled
local ragDisabled = false

plr.CharacterAdded:Connect(function()
	print("Respawn")
	character = plr.Character
	humanoid = character:WaitForChild("Humanoid")
	print("New humanoid set")
	
	ragDisabled = false
	
	for i,v in pairs(plr.PlayerScripts:GetChildren()) do
		if v.Name == "Unequip" or v.Name == "Taze" then
			v:Destroy()
		end
	end
end)


function shiftDown()
	
	print("shift down")
	
	local setEnabled = humanoid:GetState() ~= Enum.HumanoidStateType.Physics
	humanoid:ChangeState(setEnabled and Enum.HumanoidStateType.Physics or Enum.HumanoidStateType.GettingUp)
	character.Animate.Disabled = setEnabled

	--wait(0.5)
	--if setEnabled2 == true then
	--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	--else
	--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	--end

	--[[
	local set = game.StarterGui:GetCoreGuiEnabled("Backpack")
	print(set)
	if set then
		print("Going off")
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	else
		print("Going on")
		game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
	end
	--]]
end

cserver.OnClientEvent:Connect(function(act,param,param2)
	
	if act == "changePromptEnable" then
		param.Enabled = param2
	end
	
	if act == "releasetime" then

		local vv = player.PlayerGui:FindFirstChild("release") or nil

		if vv == nil then
			local c = game.ReplicatedStorage.release:Clone() 
			c.Parent = player.PlayerGui
			vv = c
		end

		vv:FindFirstChild("Frame"):FindFirstChild("TextLabel").Text = "Releasing in "..param

	end
	
	if act == "immunityExpire" then
		
		local vv = player.PlayerGui:FindFirstChild("expireImmunity") or nil
		
		local customText = nil
		
		if param == "remove" and vv then
			return vv:Destroy()
		elseif param == "remove" then
			return
		elseif param == "customtext" then
			customText = param2
		end
		
		if vv == nil then
			local c = game.ReplicatedStorage.expireImmunity:Clone() 
			c.Parent = player.PlayerGui
			vv = c
		end
		
		local plural = "seconds"
		
		if param == 1 then
			plural = "second"
		end
		
		if customText then
			vv:FindFirstChild("Frame"):FindFirstChild("TextLabel").Text = customText
		else
			if param2 and param2 == "cooldown" then
				vv:FindFirstChild("Frame"):FindFirstChild("TextLabel").Text = "Immunity is on cooldown for "..param.. " "..plural
				return 
			end
			vv:FindFirstChild("Frame"):FindFirstChild("TextLabel").Text = "Immunity will expire in "..param.. " "..plural
		end
		

	end
	
	if act == "downCarry" then
		if ragDisabled then return end
		
		ragDisabled = true
		local st = script.Unequip:Clone()
		st.Parent = game.Players.LocalPlayer.PlayerScripts
		st.Disabled = false
		ragdolled = true
		shiftDown()
		local hdied
		local diedWhileDown = false
		hdied = humanoid.Died:Connect(function()
			hdied:Disconnect()
			st:Destroy()
			diedWhileDown = true
			ragDisabled = false
		end)
	end
	
	if act == "upCarry" then
		if not ragdolled or not ragDisabled then return end
		ragDisabled = false
		if plr.PlayerScripts:FindFirstChild("Unequip") then
			plr.PlayerScripts:FindFirstChild("Unequip"):Destroy()
		end
		ragdolled = false
		shiftDown()
	end
	
	if act == "down" then
		if ragDisabled then return end
		--local clo = script.Taze:Clone()
		--clo.Parent = game.Players.LocalPlayer.PlayerScripts
		--clo.Disabled = false

		local st = script.Unequip:Clone()
		st.Parent = game.Players.LocalPlayer.PlayerScripts
		st.Disabled = false

		if isRagged() == "Ragged" then return print("ragdolled") end
		ragdolled = true
		shiftDown()
		local set = game.StarterGui:GetCoreGuiEnabled("Backpack")
		print(set)
		if set then
			print("Going off")
			--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end
		local hdied
		local diedWhileDown = false
		hdied = humanoid.Died:Connect(function()
			hdied:Disconnect()
			st:Destroy()
			diedWhileDown = true
		end)
		if diedWhileDown then return print("died while tazed") end
		local lol = param
		wait(lol)
		print("Getting up")
		if isRagged() ~= "Ragged" then return print("n ragdolled") end
		if ragDisabled then return st:Destroy() end
		shiftDown()
		local set = game.StarterGui:GetCoreGuiEnabled("Backpack")
		print(set)
		if game.StarterGui:GetCoreGuiEnabled("Backpack") == false then
			--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end		
		st:Destroy()
	end
	
	if act == "taze" then
		if ragDisabled then return end
		local clo = script.Taze:Clone()
		clo.Parent = game.Players.LocalPlayer.PlayerScripts
		clo.Disabled = false
		
		local st = script.Unequip:Clone()
		st.Parent = game.Players.LocalPlayer.PlayerScripts
		st.Disabled = false
		
		if isRagged() == "Ragged" then return print("ragdolled") end
		ragdolled = true
		shiftDown()
		local set = game.StarterGui:GetCoreGuiEnabled("Backpack")
		print(set)
		if set then
			print("Going off")
			--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
		end
		local hdied
		local diedWhileDown = false
		hdied = humanoid.Died:Connect(function()
			hdied:Disconnect()
			st:Destroy()
			diedWhileDown = true
		end)
		if diedWhileDown then return print("died while tazed") end
		local lol = param
		wait(lol)
		print("Getting up")
		if isRagged() ~= "Ragged" then return print("n ragdolled") end
		shiftDown()
		local set = game.StarterGui:GetCoreGuiEnabled("Backpack")
		print(set)
		if game.StarterGui:GetCoreGuiEnabled("Backpack") == false then
			--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end		
		st:Destroy()
	end
	
end)

local tweenService = game:GetService("TweenService")

local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut)

local damageForColours = 
{
	[25] = Color3.fromRGB(255, 255, 255),
	[50] = Color3.fromRGB(255, 255, 255),
	[75] = Color3.fromRGB(255, 0, 0),
	[100] = Color3.fromRGB(255, 0, 0),
}

game.ReplicatedStorage.DamageNumber.OnClientEvent:Connect(function(char,currentHealth,health)	
	local healthLost = math.floor(currentHealth - health)

	local damageIndicatorGui = Instance.new("BillboardGui")
	damageIndicatorGui.AlwaysOnTop = true

	damageIndicatorGui.Size = UDim2.new(1.4, 0, 1.4, 0)

	local offsetX = math.random(-10, 10)/10
	local offsetY = math.random(-10, 10)/10
	local offsetZ = math.random(-10, 10)/10
	damageIndicatorGui.StudsOffset = Vector3.new(offsetX, offsetY, offsetZ)

	local damageIndicatorLabel = Instance.new("TextLabel")

	damageIndicatorLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	damageIndicatorLabel.Position = UDim2.new(0.5, 0, 0.5, 0)

	damageIndicatorLabel.TextScaled = true
	damageIndicatorLabel.BackgroundTransparency = 1
	damageIndicatorLabel.Font = Enum.Font.GothamBlack

	damageIndicatorLabel.Text = healthLost

	damageIndicatorLabel.Size = UDim2.new(0, 0, 0, 0)

	for damage, colour in pairs(damageForColours) do

		if tonumber(healthLost) <= tonumber(damage) then 

			damageIndicatorLabel.TextColor3 = colour
			damage = 100
		end
	end

	damageIndicatorLabel.Parent = damageIndicatorGui

	damageIndicatorGui.Parent = char.HumanoidRootPart

	damageIndicatorLabel:TweenSize(UDim2.new(1, 0, 1, 0), "InOut", "Quint", 0.3)


	wait(0.3)

	local guiUpTween = tweenService:Create(damageIndicatorGui, tweenInfo, {StudsOffset = damageIndicatorGui.StudsOffset + Vector3.new(0, 1, 0)})

	local textFadeTween = tweenService:Create(damageIndicatorLabel, tweenInfo, {TextTransparency = 1})

	guiUpTween:Play()
	textFadeTween:Play()

	game:GetService("Debris"):AddItem(damageIndicatorGui, 0.3)
	
end)