local server = game.ReplicatedStorage:WaitForChild("server")
local CoreGui = game:GetService("StarterGui") 

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	game.Lighting.Dead.Enabled = false

	if game.Players.LocalPlayer.PlayerScripts then
		for i,v in pairs(game.Players.LocalPlayer.PlayerScripts:GetChildren()) do
			if v.Name == "Unequip" or v.Name == "Taze" then
				v:Destroy()
			end
		end

	end
end)
	
local using = false

local TS = game:GetService("TweenService")

_G.showMsg = function(text,duration,lol)
	
	local mg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("message") or nil 

	if mg then mg:Destroy() end

	local gui = game.ReplicatedStorage.message:Clone()
	gui.Parent = game.Players.LocalPlayer.PlayerGui
	
	if lol == "money" then
		game.ReplicatedStorage.assets_imp.money:Play()
		gui.Frame.TextLabel.TextColor3 = Color3.new(0,255,0)
	elseif lol == "alert" then
		gui.Frame.TextLabel.TextColor3 = Color3.new(255,0,0)
	end
	
	gui.Frame.TextLabel.Text = text

	wait(duration)

	if gui then
		repeat wait(0.01) 
			if gui and gui:FindFirstChild("Frame") then gui.Frame.TextLabel.TextTransparency = gui.Frame.TextLabel.TextTransparency + 0.1 end
		until not gui:FindFirstChild("Frame") or gui.Frame.TextLabel.TextTransparency == 1 or gui.Frame.TextLabel.TextTransparency > 1
		if gui then gui:Destroy() end
	end
	
end

server.OnClientEvent:Connect(function(arg1,arg2,arg3)
	local plr = game.Players.LocalPlayer
	
	if arg1 == "fadein" then

		local pgui = plr.PlayerGui or nil

		if pgui and pgui:FindFirstChild("Enter") then

			local enter = pgui:FindFirstChild("Enter")
			enter.Enabled = true
			enter.Frame.BackgroundTransparency = 0

			local Frame = enter.Frame

			game:GetService("TweenService"):Create(
				Frame,
				TweenInfo.new(3),
				{BackgroundTransparency = 1}
			):Play()

		end

	end
	
	if arg1 == "backpack" then
		game:GetService("StarterGui"):SetCoreGuiEnabled("Backpack", arg2)
	end
	
	if arg1 == "reset" then
		game:GetService("StarterGui"):SetCore("ResetButtonCallback", arg2)
	end
	
	--store
	if arg1 == "alert" then

		local mg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("message") or nil 

		if mg then mg:Destroy() end

		local gui = game.ReplicatedStorage.message:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui

		gui.Frame.TextLabel.Text = arg2
		gui.Frame.TextLabel.TextColor3 = Color3.new(255,0,0)

		wait(2)

		if gui then
			repeat wait(0.01) 
				if gui and gui:FindFirstChild("Frame") then gui.Frame.TextLabel.TextTransparency = gui.Frame.TextLabel.TextTransparency + 0.1 end
			until not gui:FindFirstChild("Frame") or gui.Frame.TextLabel.TextTransparency == 1 or gui.Frame.TextLabel.TextTransparency > 1
			if gui then gui:Destroy() end
		end

	end
	
	if arg1 == "money" then

		if game.Players.LocalPlayer.PlayerGui:FindFirstChild('Adder') then game.Players.LocalPlayer.PlayerGui:FindFirstChild('Adder'):Destroy() end
		local Adder = game.ReplicatedStorage.Misc.Adder:Clone()
		Adder.Parent = game.Players.LocalPlayer.PlayerGui
		Adder.Amount.Text = '-$' .. tostring(arg2)
		Adder.Amount.TextColor3 = Color3.fromRGB(255, 0, 0)
		if arg3 == true or arg3 == 'GAINED' then
		Adder.Amount.Text = '+$' .. tostring(arg2)
		Adder.Amount.TextColor3 = Color3.fromRGB(0, 255, 0)
		end
		Adder.Parent = game.Players.LocalPlayer.PlayerGui
		if arg3 == nil and arg3 ~= false then
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		end
		if arg3 == 'GAINED' then
			if not script.Kaching.IsPlaying then script.Kaching:Play() end
		end
		if arg3 == true or arg3 == false then
			task.wait(1)
		else
			task.wait(2)
		end
		for _ = 1, 100 do if Adder and Adder:FindFirstChild('Amount') then Adder.Amount.TextTransparency += .01 Adder.Amount.UIStroke.Transparency += .01 task.wait(.00001) end end
		Adder:Destroy()
	end
	
	if arg1 == "marker" then
		local mg = game.Workspace.RedCarArrow
		mg.Transparency = arg2
		
		if arg2 == 0 then
			-- visible
			game.Workspace["Lower Garage Boxes"].ClickDetector.MaxActivationDistance = 10
		else
			game.Workspace["Lower Garage Boxes"].ClickDetector.MaxActivationDistance = 0
		end
		
	end

	if arg1 == "lmsg" then

		local mg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("message") or nil 

		if mg then mg:Destroy() end

		local gui = game.ReplicatedStorage.message:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui

		gui.Frame.TextLabel.Text = arg2
		gui.Frame.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		wait(3)

		if gui then
			repeat wait(0.01) 
				if gui and gui:FindFirstChild("Frame") then gui.Frame.TextLabel.TextTransparency = gui.Frame.TextLabel.TextTransparency + 0.1 end
			until not gui:FindFirstChild("Frame") or gui.Frame.TextLabel.TextTransparency == 1 or gui.Frame.TextLabel.TextTransparency > 1
			if gui then gui:Destroy() end
		end

	end
	
	if arg1 == "msg" then
		
		local mg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("message") or nil 
		
		if mg then mg:Destroy() end
		
		local gui = game.ReplicatedStorage.message:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui

		gui.Frame.TextLabel.Text = arg2
		
		wait(2)
		
		if gui then
			repeat wait(0.01) 
				if gui and gui:FindFirstChild("Frame") then gui.Frame.TextLabel.TextTransparency = gui.Frame.TextLabel.TextTransparency + 0.1 end
			until not gui:FindFirstChild("Frame") or gui.Frame.TextLabel.TextTransparency == 1 or gui.Frame.TextLabel.TextTransparency > 1
			if gui then gui:Destroy() end
		end
		
	end

end)


