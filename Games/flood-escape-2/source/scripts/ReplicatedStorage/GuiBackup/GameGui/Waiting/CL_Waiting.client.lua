local Local_Player = game.Players.LocalPlayer
local FE2Library = require(game.ReplicatedStorage:WaitForChild("SharedModules"):WaitForChild("FE2Library"))
local CL_MAIN_GameScript = Local_Player.PlayerScripts.CL_MAIN_GameScript
local CurrentDif = game.ReplicatedStorage.Remote.CurrentDif:InvokeServer()
local MapInfo = "Get Ready..."
local UI = script.Parent.UI
local Content = UI.Content
local Colors = {
	["CanBoost"] = Color3.fromRGB(154, 89, 182),
	["CantBoost"] = Color3.fromRGB(22, 31, 40),
}
local CurrentBoost = game.ReplicatedStorage.Remote.GetCurrentBoost:InvokeServer()
local isVisible = false

Local_Player.PlayerGui.GameGui.HUD.TimeBar.Percent.BackgroundColor3 = Color3.fromRGB(241, 196, 15)

CL_MAIN_GameScript.AddWaiting.Event:Connect(function()
	CurrentDif = game.ReplicatedStorage.Remote.CurrentDif:InvokeServer()
	UI.Visible = true
	isVisible = true
	Content.Buttons.Intensity.Visible = true
	Content.GameInfo.MapInfo.Text = MapInfo
	Content.GameInfo.Difficulty.Difficulty.TextColor3 = FE2Library.Difficulties[math.floor(CurrentDif)][2]
	Content.GameInfo.Difficulty.Difficulty.Text = FE2Library.Difficulties[math.floor(CurrentDif)][1] .. ": " .. tostring(CurrentDif)
	if CurrentBoost ~= nil then
		if CurrentBoost ~= 49 then
			Content.Buttons.Intensity.AddIntensity.Text = `💎{tostring(CurrentBoost)} Boost Intensity`
			Content.Buttons.Intensity.AddIntensity.BackgroundColor3 = Colors.CanBoost
		else
			Content.Buttons.Intensity.AddIntensity.Text = `❌ Max boost!`
			Content.Buttons.Intensity.AddIntensity.BackgroundColor3 = Colors.CantBoost
		end
	else
		Content.Buttons.Intensity.AddIntensity.Text = `❌ Cannot boost!`
		Content.Buttons.Intensity.AddIntensity.BackgroundColor3 = Colors.CantBoost
	end
end)

Content.Buttons.Intensity.AddIntensity.MouseButton1Click:Connect(function()
	if isVisible then
		print("hello world!")
	end
end)

script.IsVoting.Event:Connect(function(isWon)
	if not isWon then
		Content.Buttons.Intensity.Visible = false
		Content.Buttons.MapVote.Visible = true
		Content.Buttons.MapVote.BackgroundColor3 = Color3.fromRGB(241, 196, 15)
		Content.Buttons.MapVote.TextTransparency = 0.2
		Content.Buttons.MapVote.Transparency = 0
	else
		CL_MAIN_GameScript.PlayerWon:Fire()
	end
end)