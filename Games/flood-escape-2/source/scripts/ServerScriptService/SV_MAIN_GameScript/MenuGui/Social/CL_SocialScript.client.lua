local player = game.Players.LocalPlayer
local cl_main = player.PlayerScripts:WaitForChild("CL_MAIN_GameScript")
local window = script.Parent.Window
local categories = window.Content.Categories
local pages = window.Content.Pages
local socialSrv = game:GetService("SocialService")

local function ChangePage(pageName)
	for i,v in next, categories:GetChildren() do
		if v:IsA("TextButton") then
			if v.Name == pageName then
				v.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
				continue
			end
			v.BackgroundColor3 = Color3.fromRGB(127, 140, 141)
		end
	end
	for i,v in next, pages:GetChildren() do
		if v:IsA("Frame") then
			v.Visible = false
			if v.Name == pageName then
				v.Visible = true
				v.UIScale.Scale = 0
				game:GetService("TweenService"):Create(v.UIScale, TweenInfo.new(.315,Enum.EasingStyle.Quint), {Scale = 1}):Play()
end
end
end
end


for i, v in next, categories:GetChildren() do
	if v:IsA("TextButton") then
		v.Activated:Connect(function()
			ChangePage(v.Name)
		end)
	end
end

player.PlayerGui:WaitForChild("MenuGui").MenuOpened.Event:Connect(function(menu)
	if menu == script.Parent then
		ChangePage('Spectate')
	end
end)

window.BottomBar.Close.Activated:Connect(function()
	cl_main.ViewMenu:Fire()
end)

categories.Invite.Activated:Connect(function()
		if socialSrv:CanSendGameInviteAsync(player) then
			socialSrv:PromptGameInvite(player)
		end
end)