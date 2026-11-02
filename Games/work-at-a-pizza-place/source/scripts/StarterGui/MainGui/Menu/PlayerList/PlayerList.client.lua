local MAX_NUM_PLAYERS = 12

local BC_ICON = 'rbxasset://textures/ui/icon_BC-16.png'
local TBC_ICON = 'rbxasset://textures/ui/icon_TBC-16.png'
local OBC_ICON = 'rbxasset://textures/ui/icon_OBC-16.png'
local FRIEND_ICON = 'rbxasset://textures/ui/icon_friends_16.png'
local ADMIN_ICON = 'rbxasset://textures/ui/icon_admin-16.png'

local TEAM_LABEL_SIZE = 20
local PLAYER_LABEL_SIZE = 20
local SPACING = 3

local Window = script.Parent
local localplayer = game.Players.LocalPlayer
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Menu = MainGui.Menu:WaitForChild("Menu") 
local isSmallScreen = false
local Template = Window:WaitForChild("PlayerNameTemplate")
local TeamTemplate = Window:WaitForChild("TeamNameTemplate")
local Enums =  require(game.ReplicatedStorage:WaitForChild("Enums"))
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))





local WindowData = GuiManager:RegisterWindow(Window)


if _G.GamepadEnabled then
	
	TEAM_LABEL_SIZE = 30
	PLAYER_LABEL_SIZE = 30
	
	Template.Size = UDim2.new(1,-9,0,PLAYER_LABEL_SIZE)
	TeamTemplate.Size = UDim2.new(1,-9,0,TEAM_LABEL_SIZE)
	
	Template.TextLabel.Size = UDim2.new(1,-30,1,0)
	Template.TextLabel.Position = UDim2.new(0,30,0,0)
	Template.TextLabel.TextSize = 24
	
	TeamTemplate.TextLabel.Position = UDim2.new(0,10,0,0)
	TeamTemplate.TextLabel.Size = UDim2.new(1,-10,1,0)
	TeamTemplate.TextLabel.TextSize = 24
	
	Window.Size = UDim2.new(0,210,1,0)
	Window.Position = UDim2.new(1,-210,0,70)
	
	Window.Selectable = false
	
end




local teams = (Enums.IsPartyServer and {}) or {"Manager","Cashier","Cook","Pizza Boxer","Delivery","Supplier","On Break"}
local teamColorToName = {}
local teamNameToColor = {}
for _,team in ipairs(game.Teams:GetChildren()) do
	local colorName = team.TeamColor.Name
	teamNameToColor[team.Name] = colorName
	teamColorToName[colorName] = team.Name
end



local teamLabels = {}
for name,color in pairs(teamNameToColor) do
	teamLabels[name] = script.Parent:WaitForChild("TeamNameTemplate"):clone()
	teamLabels[name].TextLabel.Text = name
	teamLabels[name].BackgroundColor3 = BrickColor.new(color).Color
	teamLabels[name].Parent = script.Parent
	teamLabels[name].Visible = true
end


local nameLabels = {}




function RefreshList()
	local currentLine = 0
	--loop through all the team
	local function AddPlayerByTeamColor(color)
		--find players on current team and add to list
		for _,player in ipairs(game.Players:GetPlayers()) do
			if nameLabels[player] and (color == nil or  player.TeamColor == BrickColor.new(color)) then
				nameLabels[player].Position = UDim2.new(0,0,0,currentLine*(PLAYER_LABEL_SIZE + SPACING))
				currentLine = currentLine + 1
			end
		end
	end
	
	for _,name in ipairs(teams) do  
		--add team label
		local color = teamNameToColor[name]
		teamLabels[name].Position = UDim2.new(0,0,0,currentLine*(TEAM_LABEL_SIZE + SPACING))
		currentLine = currentLine + 1
		
		AddPlayerByTeamColor(color)
	end
	
	if #teams == 0 then
		AddPlayerByTeamColor(nil)
	end
	
	Window.CanvasSize = UDim2.new(0,0,0,currentLine*(PLAYER_LABEL_SIZE + SPACING))

	--gamepad can't scroll list, make list size the size of the window
	--if _G.GamepadEnabled then
		--Window.Size = UDim2.new(Window.Size.X.Scale,Window.Size.X.Offset,0,currentLine*(PLAYER_LABEL_SIZE + SPACING))
	--end

end



function AddPlayer(player)
	--if player.Name == "Dued1"  and game.Players.LocalPlayer ~= "Dued1" then return end
	local nameTemplate = Template:clone()
	nameTemplate.TextLabel.Text = player.Name
	nameTemplate.Parent = script.Parent
	nameTemplate.Visible = true
	
	
	--need to know if too small to see icons before creating nametemplate
	
	nameLabels[player] = nameTemplate
	
	if not isSmallScreen then
		spawn(function()
				
			local isFriends = false
			if player and player.Parent and player ~= localplayer then
				pcall(function() isFriends = localplayer:IsFriendsWith(player.userId) end)
				if nameTemplate.Parent == nil or isFriends == nil then return end
				if isFriends then
					if _G.GamepadEnabled then
						nameTemplate.FriendsConsole.Visible = true
					else
						nameTemplate.Friends.Visible = true
					end
				end
			end
				
			if nameTemplate.Parent == nil then return end

			local icon
				
			--[[if player:IsInGroup(1200769) then
			--icon = ADMIN_ICON]]
			
			if _G.GamepadEnabled then return end  --dont show BC status on Xbox
			
			
			if player.MembershipType == Enum.MembershipType.BuildersClub then
				icon = BC_ICON
					
			elseif player.MembershipType == Enum.MembershipType.TurboBuildersClub then
				icon = TBC_ICON
					
			elseif player.MembershipType == Enum.MembershipType.OutrageousBuildersClub then
				icon = OBC_ICON
			end
				
			if icon then
				nameTemplate.BCIcon.Visible = true
				nameTemplate.BCIcon.Image = icon
				if isFriends then 	
					--scooch everything over to make room for friend icon
					nameTemplate.BCIcon.Position = UDim2.new(0, 23,0.5, -8) --move BC icon over
					nameTemplate.TextLabel.Position = UDim2.new(0, 42,0, 0)
					nameTemplate.TextLabel.Size = UDim2.new(1,-42,1,0)
				end
			end
				
				
		end)
	else
		nameTemplate.TextLabel.Position = UDim2.new(0, 3, 0, 0)
	end
	
	
	player.Changed:connect(function(property)
		if property == "TeamColor" then
			RefreshList()
		end
	end)
	
	RefreshList()

	
end





local WindowPosY = (_G.GamepadEnabled and 70) or -35

Window.Position = UDim2.new(Window.Position.X.Scale,Window.Position.X.Offset,0, WindowPosY)

local OriginalPosition = Window.Position


--window is never resized only pushed off screen
local function RealighMenu()
	Window.Position = OriginalPosition

	local overlapping = WindowData:IsOverlapping(Menu)

	if overlapping then
		--put the playerlist at the end of topbar menu
		Window.Position = UDim2.new(0,Menu.AbsolutePosition.X + Menu.AbsoluteSize.X,0,WindowPosY)
		
		--if more than half list is offscreen then push playerlist down
		if Window.AbsolutePosition.X + (Window.AbsoluteSize.X/2) > MainGui.AbsoluteSize.X then 
			Window.Position = UDim2.new(1, - (Window.AbsoluteSize.X/2),0,0)
		end
	end
	
	--if menu was pushed down, remove all icons next to players and move name to the left
	if not isSmallScreen and MainGui.AbsoluteSize.X - (Menu.AbsolutePosition.X + Menu.AbsoluteSize.X)  < (Window.AbsoluteSize.X/2) then
		isSmallScreen = true
		for _,player in ipairs(game.Players:GetPlayers()) do
			local label = nameLabels[player]
			if label then
				label.TextLabel.Position = UDim2.new(0, 3, 0, 0)
				label.BCIcon.Visible = false
				label.Friends.Visible = false
			end
		end
	end
	
	WindowData:UpdateTweenEndPoints()
end

--when the menu position changes, move the player list too
Menu.Changed:connect(function(prop)
	if prop == "AbsolutePosition" or prop == "AbsoluteSize" then
		RealighMenu()
	end
end)

MainGui.Changed:connect(function(prop)
	if prop == "AbsoluteSize" then
		wait()
		RealighMenu()
	end
end)


RealighMenu()

for _,player in ipairs(game.Players:GetPlayers()) do
	AddPlayer(player)
end

game.Players.PlayerAdded:connect(function(player)
	AddPlayer(player)
end)


game.Players.PlayerRemoving:connect(function(player)
	--if player.Name == "Dued1" then return end

	nameLabels[player]:Destroy()
	nameLabels[player] = nil
	RefreshList()
end)



WindowData:SetVisible(true)


