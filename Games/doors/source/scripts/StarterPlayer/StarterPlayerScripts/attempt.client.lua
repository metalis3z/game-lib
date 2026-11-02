-- Decompiled with the Synapse X Luau decompiler.

if game.Players.LocalPlayer.Name == "Lightning_Splash" then
	print("flipping it!");
	wait(3);
	for v1 = 1, 10 do
		for v2, v3 in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
			if v3:FindFirstAncestor("PermUI") == nil and v3:GetAttribute("Arabiced") ~= true then
				v3:SetAttribute("Arabiced", true);
				if v3:IsA("GuiObject") then
					if v3:IsA("TextLabel") or v3:IsA("TextBox") then
						if v3.TextXAlignment == Enum.TextXAlignment.Left then
							v3.TextXAlignment = Enum.TextXAlignment.Right;
						elseif v3.TextXAlignment == Enum.TextXAlignment.Right then
							v3.TextXAlignment = Enum.TextXAlignment.Left;
						end;
					end;
					v3.Position = UDim2.new(-v3.Position.X.Scale + 1, v3.Position.X.Offset, v3.Position.Y.Scale, v3.Position.Y.Offset);
					v3.AnchorPoint = Vector2.new(-v3.AnchorPoint.X + 1, v3.AnchorPoint.Y);
				end;
				if v3:IsA("UIPadding") then
					local v4 = v3:Clone();
					v3.PaddingLeft = v4.PaddingRight;
					v3.PaddingRight = v4.PaddingLeft;
					v4:Destroy();
				end;
				if v3:IsA("UIListLayout") then
					if v3.HorizontalAlignment == Enum.HorizontalAlignment.Left then
						v3.HorizontalAlignment = Enum.HorizontalAlignment.Right;
					elseif v3.HorizontalAlignment == Enum.HorizontalAlignment.Right then
						v3.HorizontalAlignment = Enum.HorizontalAlignment.Left;
					end;
				end;
				if v3:IsA("UIGradient") and (v3.Rotation == 0 or v3.Rotation == 180) then
					v3.Rotation = v3.Rotation + 180;
				end;
			end;
		end;
		wait(1);
	end;
end;
