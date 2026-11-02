local server = game.ReplicatedStorage:WaitForChild("server")
local CoreGui = game:GetService("StarterGui") 

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	game:GetService("StarterGui"):SetCoreGuiEnabled("Backpack", true)
	game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
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
	
	--if arg1 == "fillcar" then
		
	--	if plr.PlayerGui:FindFirstChild("A-Chassis Interface") then
	--		print("ACI")
	--		local aci = plr.PlayerGui:FindFirstChild("A-Chassis Interface")
	--		local fo = aci:FindFirstChild("FuelOut")
	--		fo.Value = true
	--	end
		
	--end
	
	if arg1 == "createWarnMessage" then
		game.ReplicatedStorage.Fail:Play()
		local mn = game.Lighting.ModeratorNote:Clone()
		mn.Frame.WarnMsg.Text = '"'..arg2..'"'
		mn.Parent = plr.PlayerGui
		
		mn.Frame.Timer.Text = "10"
		
		spawn(function()
			local timed = 10
			
			repeat wait(1) 
				timed = timed - 1
				mn.Frame.Timer.Text = timed
			until timed <= 0
			
			mn.Frame.OkButton.BackgroundTransparency = 0
			mn.Frame.OkButton.Transparency = 0
			mn.Frame.OkButton.BackgroundColor3 = Color3.fromRGB(0, 145, 5)
			
			mn.Frame.Timer.Visible = false
			mn.Frame.OkButton.MouseButton1Click:Connect(function()
				--game.ReplicatedStorage.HOVER:Play()
				mn:Destroy()
			end)
			
		end)
	end
	
	if arg1 == "togglelocker" then
		
		if plr.PlayerGui and plr.PlayerGui:FindFirstChild("PDLocker") then
			plr.PlayerGui:FindFirstChild("PDLocker"):Destroy()
		else
			local pdlocker = game.ReplicatedStorage.PDLocker:Clone()
			pdlocker.Parent = plr.PlayerGui
			pdlocker.lockerscript.Disabled = false
		end
		
	end
	
	if arg1 == "toggleemslocker" then

		if plr.PlayerGui and plr.PlayerGui:FindFirstChild("EMSLocker") then
			plr.PlayerGui:FindFirstChild("EMSLocker"):Destroy()
		else
			local pdlocker = game.ReplicatedStorage.EMSLocker:Clone()
			pdlocker.Parent = plr.PlayerGui
			pdlocker.lockerscript.Disabled = false
		end

	end
	
	if arg1 == "togglecars" then

		if plr.PlayerGui and plr.PlayerGui:FindFirstChild("PDCars") then
			plr.PlayerGui:FindFirstChild("PDCars"):Destroy()
		else
			local pdlocker = game.ReplicatedStorage.PDCars:Clone()
			pdlocker.Parent = plr.PlayerGui
			pdlocker.carscript.Disabled = false
		end

	end
	
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
		print("reset getting set to :"..tostring(arg2))
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

		local mg = game.Players.LocalPlayer.PlayerGui:FindFirstChild("message") or nil 

		if mg then mg:Destroy() end
		
		game.ReplicatedStorage.assets_imp.money:Play()
		
		local gui = game.ReplicatedStorage.message:Clone()
		gui.Parent = game.Players.LocalPlayer.PlayerGui

		gui.Frame.TextLabel.Text = arg2
		gui.Frame.TextLabel.TextColor3 = Color3.new(0,255,0)

		wait(2)

		if gui then
			repeat wait(0.01) 
				if gui and gui:FindFirstChild("Frame") then gui.Frame.TextLabel.TextTransparency = gui.Frame.TextLabel.TextTransparency + 0.1 end
			until not gui:FindFirstChild("Frame") or gui.Frame.TextLabel.TextTransparency == 1 or gui.Frame.TextLabel.TextTransparency > 1
			if gui then gui:Destroy() end
		end

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

		wait(6)

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


