local ts = game:GetService("TweenService")
local ti = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local upPos = UDim2.new(0.5,0,0.5,0)
local downPos = UDim2.new(0.5,0,2,0)
local parentFrame = game.Players.LocalPlayer.PlayerGui:WaitForChild("GameGUI").Frame

script.Parent.Activated:Connect(function()
	if game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.UGCFrame:GetAttribute("Up") then
		game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.UGCFrame:SetAttribute("Up", false)
		ts:Create(game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.UGCFrame, ti, {Position = downPos}):Play()
	else
		ts:Create(game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.UGCFrame, ti, {Position = upPos}):Play()
		for i, v in pairs(parentFrame:GetChildren()) do
			if v:GetAttribute("Up") then
				v:SetAttribute("Up", false)
				ts:Create(v, ti, {Position = downPos}):Play()
			end
		end
		game.Players.LocalPlayer.PlayerGui.GameGUI.Frame.UGCFrame:SetAttribute("Up", true)
	end
end)