local Players = game:GetService('Players')
local Remotes = require(game.ReplicatedStorage.Remotes)
local numb = require(game.ReplicatedStorage.Common.NumberHelpers)

local UserService = game:GetService('UserService')

if not game:GetService('RunService'):IsStudio() then
	
	script.Parent.Parent:Destroy()
	
end

local a = Remotes.Function('GetOurTopDonated')

script.Parent.Frame.TextBox.FocusLost:Connect(function()
	
	local iouoijhiouyh = Players:GetUserIdFromNameAsync(script.Parent.Frame.TextBox.Text)
	
	if iouoijhiouyh then
		print(iouoijhiouyh)
		local UserInfo = UserService:GetUserInfosByUserIdsAsync({iouoijhiouyh})
		UserInfo = table.unpack(UserInfo)
		script.Parent.Frame.Avatar.Image = Players:GetUserThumbnailAsync(UserInfo.Id, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
		script.Parent.Frame.Display.Text = UserInfo.DisplayName
		script.Parent.Frame.User.Text = UserInfo.Username
		
		local xd = a:InvokeServer(UserInfo.Id)
		
		for lul, aaa in pairs(script.Parent.ScrollingFrame:GetChildren()) do
			if aaa:IsA('Frame') then
				aaa:Destroy()
			end
		end
		
		for _, s in pairs(xd) do
			
			local xddd = script.Player:Clone()
			
			xddd.Avatar.Image = Players:GetUserThumbnailAsync(s.userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
			xddd.Robux.Text = numb.formatCommas(s.robux)
			pcall(function()
				
				xddd.Display.Text = Players:GetNameFromUserIdAsync(s.userId)
				
			end)
			
			xddd.Parent = script.Parent.ScrollingFrame
			
		end
		
	end
	
end)