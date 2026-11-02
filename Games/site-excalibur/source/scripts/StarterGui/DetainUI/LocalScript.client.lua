
local textTop = "You have been detained" --Text that will appear when detained
local textBottom = "Do not leave the game, you are being detained." --Text under textTop
local blurEffect = true --Adds a blur effect
local icon = "rbxassetid://5087913874" --Icon that will appear when detained (image ID); nil for none
local textShadow = true
local cooldown = nil --Adds a maximum detaining time; nil for none
local hideBackpack = true
local maxDistanceStuds = 15 --Max distance (studs)
local mustWalk = false
local mustBeAPlayer = true
local whiteListPlayer = {"johnpka"} --Player names (may not get detained)
local whiteListGroup = nil --Group ID (may not get detained); nil for none
local whiteListRank = {nil, 255} --Groupd ID; nil for none. Minimum Rank ID; 255 max, 1 minimum.

--DO NOT EDIT
local detainUI = script.Parent.Frame
local eventDetained = game.ReplicatedStorage.Detain.Detained
local eventDetain = game.ReplicatedStorage.Detain.Detain
local detained = false
local detaining = false
detainUI.TextTop.Text = textTop
detainUI.TextBottom.Text = textBottom
detainUI.TextTop.Shadow.Text = textTop
detainUI.TextBottom.Shadow.Text = textBottom
if icon then
	detainUI.Icon.Image = "rbxassetid://"..icon
	detainUI.Icon.Visible = true
else detainUI.Icon.Visible = false
end
if textShadow == true then
	detainUI.TextTop.Shadow.Visible = true
	detainUI.TextBottom.Shadow.Visible = true
else detainUI.TextTop.Shadow.Visible = false
	detainUI.TextBottom.Shadow.Visible = false
end
local blur
if blurEffect == true then
	blur = Instance.new("BlurEffect", game.Lighting)
	blur.Size = 0
end
local mouse = game.Players.LocalPlayer:GetMouse()
local tweenProp1 = {Position = UDim2.fromScale(0, .5)}
local tweenProp2 = {Position = UDim2.fromScale(0, 1.15)}
local tweenService = game:GetService("TweenService")

--OnDetained
eventDetained.OnClientEvent:Connect(function(toggled)
	if toggled == true and detained == false then
		if hideBackpack == true and not game.Players.LocalPlayer.PlayerGui:FindFirstChild("BackpackUI") then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
			game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
		end
		game.StarterGui:SetCore("ResetButtonCallback", false) 
		if detaining == true then
			eventDetain:FireServer(false)
		end
		tweenService:Create(detainUI, TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), tweenProp1):Play()
		if blurEffect == true then
			for  i = 1, 16 do --16 == blur size
				blur.Size = blur.Size + 1
				wait()
			end
		end
	elseif toggled == false and detained == true then
		if hideBackpack == true and not game.Players.LocalPlayer.PlayerGui:FindFirstChild("BackpackUI") then
			game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, true)
		end
		game.StarterGui:SetCore("ResetButtonCallback", true) 
		tweenService:Create(detainUI, TweenInfo.new(.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.In, 0, false, 0), tweenProp2):Play()
		if blurEffect == true then
			for  i = 1, 16 do --16 == blur size
				blur.Size = blur.Size - 1
				wait()
			end
		end
	end
	detained = toggled
end)

--OnClick
game:GetService("UserInputService").InputBegan:Connect(function(key, gameProcessed)
	if gameProcessed == false and key.UserInputType == Enum.UserInputType.MouseButton1 and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Detain") and game.Players.LocalPlayer.Character.Humanoid.Health > 0 then
		if mouse.Target and detained == false and (mouse.Target.Position - game.Players.LocalPlayer.Character.Head.Position).magnitude <= maxDistanceStuds and detaining == false then
			local hum = mouse.Target.Parent:FindFirstChildOfClass("Humanoid") or mouse.Target.Parent.Parent:FindFirstChildOfClass("Humanoid")
			local plr
			if mustWalk == true then
				if hum.WalkSpeed == 16 then
				else return
				end
			end
			if hum == game.Players.LocalPlayer.Character.Humanoid then
				return 
			end
			if mustBeAPlayer == true then
				if game.Players:GetPlayerFromCharacter(mouse.Target.Parent) or game.Players:GetPlayerFromCharacter(mouse.Target.Parent.Parent) then
					plr = game.Players:GetPlayerFromCharacter(mouse.Target.Parent) or game.Players:GetPlayerFromCharacter(mouse.Target.Parent.Parent)
				else return
				end
				if not table.find(whiteListPlayer, plr.Name) then
					if whiteListGroup then 
						if plr:GetRankInGroup(whiteListGroup) < 1 then
						else return
						end
					end
					if whiteListRank[1] then
						if plr:GetRankInGroup(whiteListRank[1]) >= whiteListRank[2] then
						else return
						end
					end
				else return
				end
			end
			detaining = true
			eventDetain:FireServer(true, hum, plr)
			if cooldown then
				local cd = cooldown
				while cd > 0 and detaining == true do
					cd = cd - 1
					wait(1)
				end
				if cd == 0 then
					eventDetain:FireServer(false)
				end
			end
		elseif detaining == true then
			detaining = false
			eventDetain:FireServer(false)
		end
	end
end)