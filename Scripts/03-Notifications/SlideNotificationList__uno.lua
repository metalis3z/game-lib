-- Reference copy for study. Game: UNO (uno)
-- Original: StarterGui/GameUI/Everything/Client/NotificationManager.lua
-- What it does: Good/Neutral/Bad notifications with colored side bar and sound; new ones slide in at the top and push older ones down, then slide out left. NOTE: the original has "if true then return end" at the top (disabled in game).

--X_Z

local GameUI = script.Parent.Parent

local module = {}

function module:CreateLabel(Type, Text)
	
	if true then return end
	
	local Clone = GameUI.GuiTemplates.NotifTemplate:Clone()
	Clone.Back.Txt.Text = Text
	
	if Type == "Bad" then
		Clone.Back.Bar.BackgroundColor3 = Color3.fromRGB(170, 70, 70)
		GameUI.Sounds.NegativeNotif:Play()
	elseif Type == "Neutral" then
		Clone.Back.Bar.BackgroundColor3 = Color3.fromRGB(95, 202, 255)
		GameUI.Sounds.NegativeNotif:Play()
	else
		Clone.Back.Bar.BackgroundColor3 = Color3.fromRGB(110, 222, 165)
		GameUI.Sounds.PositiveNotif:Play()
	end
	
	for i,v in pairs(GameUI.Notifications.List:GetChildren()) do
		v.YPos.Value = v.YPos.Value + 1.03
		v:TweenPosition(UDim2.new(0,0,v.YPos.Value,0),"Out","Quad",.3,true)
	end
	
	Clone.Visible = true
	Clone.Parent = GameUI.Notifications.List
	
	Clone:TweenPosition(UDim2.new(0,0,0,0),"Out","Quad",.3,true)
	
	spawn(function()
		wait(4)
		if Clone and Clone.Parent and Clone.Parent ~= nil then
			Clone:TweenPosition(UDim2.new(-1,0,Clone.Position.Y.Scale,0),"Out","Quad",.3,true)
			wait(.5)
			if Clone and Clone.Parent and Clone.Parent ~= nil then
				Clone:Destroy()
			end
		end
	end)
	
end

return module