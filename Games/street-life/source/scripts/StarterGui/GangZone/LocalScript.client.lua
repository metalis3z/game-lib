if not game:IsLoaded() then game.Loaded:Wait() end

local Player = game:FindService('Players').LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

while true do
	wait(1);
	local v1 = workspace.GZones:GetChildren();
	for v2 = 1, #v1 do
		local v3 = v1[v2];
		if Character:FindFirstChild('HumanoidRootPart') then
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v3.Position).magnitude <= 50 and script.Parent.Frame.Value.Value == false then
				script.Parent.Frame.Value.Value = true;
				script.Parent.Frame.Block.Text = string.upper(v3.Name);
				for v4 = 1, 20 do
					wait();
					script.Parent.Frame.ImageTransparency = script.Parent.Frame.ImageTransparency - 0.025;
					script.Parent.Frame.TextLabel2.TextTransparency = script.Parent.Frame.TextLabel2.TextTransparency - 0.05;
					script.Parent.Frame.TextLabel2.UIStroke.Transparency = script.Parent.Frame.TextLabel2.TextTransparency
					script.Parent.Frame.TextLabel3.TextTransparency = script.Parent.Frame.TextLabel3.TextTransparency - 0.05;
					script.Parent.Frame.TextLabel3.UIStroke.Transparency = script.Parent.Frame.TextLabel3.TextTransparency
					script.Parent.Frame.Block.TextTransparency = script.Parent.Frame.Block.TextTransparency - 0.05;
					script.Parent.Frame.Block.UIStroke.Transparency = script.Parent.Frame.Block.TextTransparency
				end;
			end;
			if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v3.Position).magnitude > 50 and script.Parent.Frame.Block.Text == string.upper(v3.Name) and script.Parent.Frame.Value.Value == true then
				script.Parent.Frame.Value.Value = false;
				for v5 = 1, 20 do
					wait();
					script.Parent.Frame.ImageTransparency = script.Parent.Frame.ImageTransparency + 0.025;
					script.Parent.Frame.TextLabel2.TextTransparency = script.Parent.Frame.TextLabel2.TextTransparency + 0.05;
					script.Parent.Frame.TextLabel2.UIStroke.Transparency = script.Parent.Frame.TextLabel2.TextTransparency
					script.Parent.Frame.TextLabel3.TextTransparency = script.Parent.Frame.TextLabel3.TextTransparency + 0.05;
					script.Parent.Frame.TextLabel3.UIStroke.Transparency = script.Parent.Frame.TextLabel3.TextTransparency
					script.Parent.Frame.Block.TextTransparency = script.Parent.Frame.Block.TextTransparency + 0.05;
					script.Parent.Frame.Block.UIStroke.Transparency = script.Parent.Frame.Block.TextTransparency
				end;
			end;
		end
	end;
end;