
	game:GetService("RunService"):BindToRenderStep("ThrowingKnifeVisualizer", Enum.RenderPriority.Last.Value, function(p2)
	for v3, v4 in pairs(game.Workspace:GetChildren()) do
		if v4.Name == "ThrowingKnife" then
			local l__BladePosition__5 = v4.BodyPosition;
			local v6 = v4.CFrame * CFrame.Angles(-math.rad(720) * p2, 0, 0);
			local l__lookVector__7 = CFrame.new(v4.Position, v4.BodyPosition.Position).lookVector;
			local l__magnitude__8 = (v4.Position - v4.BodyPosition.Position).magnitude;
			local v9 = v4.CFrame.p + v4.VelocityV.Value * 1.3 * (p2 / 0.016666666666666666);
			local v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21 = v6:components();
			local v22 = CFrame.new(v9.X, v9.Y, v9.Z, v13, v14, v15, v16, v17, v18, v19, v20, v21);
			v4.CFrame = v22;
		end
	end
	end)
