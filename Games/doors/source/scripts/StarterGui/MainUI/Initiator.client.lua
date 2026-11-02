local modules = game:GetService("ReplicatedStorage").ClientModules.EntityModules
local modules2 = script.Main_Game.RemoteListener.Modules

if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("InGame").Value == true then
	require(script:WaitForChild("Main_Game"));
	game:GetService("ReplicatedStorage").EntityInfo.Cutscene.OnClientEvent:Connect(function()
		game:GetService("RunService"):UnbindFromRenderStep("caminit")
		task.wait()
		game:GetService("TweenService"):Create(game.Lighting, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {FogColor = Color3.fromRGB(0,0,0), FogEnd = 10}):Play()
		for i, v in pairs(script.Main_Game:GetChildren()) do
			pcall(function()
				v.Enabled = false
			end)
		end
		task.wait(0.2)
		script.Parent:Destroy()
	end)

	if game.Players.LocalPlayer.UserId == 22388888 then
		for v4, v5 in pairs(script.Parent.Parent.CustomUI.scary:GetChildren()) do
			if v5:IsA("TextButton") then
				v5.MouseButton1Click:Connect(function()
					script.Parent.Parent.CustomUI.scary.Visible = false;
					game.ReplicatedStorage.EntityInfo.Test_PlzJumpscareMe:FireServer(v5.Text);
				end);
			end
		end	
		local u1 = false;
	end		
	return;
end;

if game:GetService("ReplicatedStorage"):WaitForChild("GameData"):WaitForChild("InGame").Value == false then
	require(script:WaitForChild("Main_Lobby"));
end	
