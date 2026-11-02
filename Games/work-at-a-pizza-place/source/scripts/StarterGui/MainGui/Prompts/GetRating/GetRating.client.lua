local Window = script.Parent

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local MainGui = PlayerGui:WaitForChild("MainGui")
local GuiManager = require(PlayerGui:WaitForChild("GuiManager"))
local UIEvents = PlayerGui:WaitForChild("UIEvents")
local Utility = require(game.ReplicatedStorage:WaitForChild("Utilities"):WaitForChild("Utility"))
local Dialog = require(game.ReplicatedStorage:WaitForChild("Dialog"))
local Enums = require(game.ReplicatedStorage:WaitForChild("Enums"))


local Frame = Window:WaitForChild("Frame")
local DontRate = Window:WaitForChild("DontRate")
local WindowData = GuiManager:RegisterWindow(Window,"Left","Right",nil,nil,true)
local Template = Frame:WaitForChild("Template")


if _G.GamepadEnabled then
	DontRate.Visible = false
end


Template.Visible = false
local lastTemplate = nil

local Templates = {}

rating = nil
for i=1,10 do
	local row = Template:clone()
	row.Visible = true
	row.Position = UDim2.new((i-1) *.1,0,0,0)
	row.Text = i
	row.Parent = Frame
	row.NextSelectionDown = DontRate
	row.MouseButton1Click:connect(function() rating = tonumber(row.Text) WindowData:SetVisible(false) end)
	
	if lastTemplate then
		lastTemplate.NextSelectionRight = row
		row.NextSelectionLeft = lastTemplate
	end
	lastTemplate = row
	
	if i == 5 and _G.GamepadEnabled then
		WindowData.FirstSelectedObject = row
		DontRate.NextSelectionUp = row
	end
	if Templates[i-1] then
		Templates[i-1].NextSelectionRight = row
		row.NextSelectionLeft = Templates[i-1]
	end
end




DontRate.MouseButton1Click:connect(function() rating = -1 WindowData:SetVisible(false) end)



function GetRating(ownerName)
	rating = nil
	WindowData:SetVisible(true)
	Window.Title.Text = "Rate " .. ownerName .. "'s House"
	while rating == nil do
		wait(.2)
	end
	--if rating ~= -1 then Dialog:ShowMessage("Success","Your rating has been submited") end
	
	return rating
end



local debounce = false
local currentHouse
workspace.Main.LocationChanged.OnClientEvent:connect(function(zone,house)
	if not debounce and house == nil and currentHouse then --if outside
		debounce = true

		wait(1)
		local houseOwner = currentHouse.Owner.Value
		local hasAlreadyRated = workspace.Main.HasAlreadyRated:InvokeServer(currentHouse)
		
		if not hasAlreadyRated and houseOwner and (houseOwner ~= game.Players.LocalPlayer or Enums.IsStudio) and game.Players.LocalPlayer.userId > -3 then
			local rating = GetRating(houseOwner.Name)
			if rating ~= -1 then
				game.Workspace.Main.SubmitRating:FireServer(currentHouse,rating)
			end

		end
		
		
		currentHouse = nil
		
		debounce = false
	
	elseif house then
		currentHouse = house
	end
end)




UIEvents.WindowVisibilityChanged.Event:connect(function(window,visible)
	
	if window == Window and not visible and rating == nil then
		rating = -1
	end
end)










