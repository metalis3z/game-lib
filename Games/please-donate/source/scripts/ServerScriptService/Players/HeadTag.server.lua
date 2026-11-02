--[[
    Bro made by me arxxxx, it is kinda buggy idk how fix
]]

local _Templates = game:GetService("ReplicatedStorage").Templates
local _Players = game:GetService("Players")

local founders = {"NameHolderName"}
local cofounders = {"AnonymousDark_Knight", "dxcompline"}
local Staff = {"Fireonit_YT", "T8tion"}

_Players.PlayerAdded:Connect(function(l__LocalPlayer)
	l__LocalPlayer.CharacterAppearanceLoaded:Connect(function(char)
		local l__char = char
		local l__head = l__char.Head
		local _HeadTag = _Templates:FindFirstChild("HeadTag"):Clone()
		
		_HeadTag.Display.Text = l__LocalPlayer.DisplayName
		l__char:FindFirstChild("Humanoid").DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		_HeadTag.Parent = l__head
		
		if table.find(founders, l__LocalPlayer.Name) then
			local char = char
			local headtag = char.Head:FindFirstChild("HeadTag")
			headtag:FindFirstChild("Roles").Founder.Visible = true
		elseif table.find(cofounders, l__LocalPlayer.Name) then
			local char = char
			local headtag = char.Head:FindFirstChild("HeadTag")
			headtag:FindFirstChild("Roles").CoFounder.Visible = true
		elseif table.find(Staff, l__LocalPlayer.Name) then
			local char = char
			local headtag = char.Head:FindFirstChild("HeadTag")
			headtag:FindFirstChild("Roles").Staff.Visible = true
		end
		
		if l__LocalPlayer:IsInGroup(34084839) then
			if l__LocalPlayer:GetRankInGroup(34084839) == 255 then
				local char = char
				local headtag = char.Head:FindFirstChild("HeadTag")
				headtag:FindFirstChild("Roles").Fan.Visible = false
			elseif p:GetRankInGroup(34084839) == 1 then
				local char = char
				local headtag = char.Head:FindFirstChild("HeadTag")
				headtag:FindFirstChild("Roles").Fan.Visible = true
			end
		end
		
	end)
end)