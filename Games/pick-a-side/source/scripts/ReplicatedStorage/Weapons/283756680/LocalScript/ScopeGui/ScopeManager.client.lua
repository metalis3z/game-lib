-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:38
-- Luau version 6, Types version 3
-- Time taken: 0.009391 seconds

wait()
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
RunService = game:GetService("RunService") -- Setting global
Player = Players.LocalPlayer -- Setting global
Mouse = Player:GetMouse() -- Setting global
Gui = script.Parent -- Setting global
MainFrame = Gui:WaitForChild("MainFrame") -- Setting global
Scope = MainFrame:WaitForChild("Scope") -- Setting global
LeftFrame = MainFrame:WaitForChild("LeftFrame") -- Setting global
RightFrame = MainFrame:WaitForChild("RightFrame") -- Setting global
Crosshair = MainFrame:WaitForChild("Crosshair") -- Setting global
ZoomPercentLabel = MainFrame:WaitForChild("ZoomPercentLabel") -- Setting global
Tool = Gui:WaitForChild("Tool").Value -- Setting global
ZoomPercent = Gui:WaitForChild("ZoomPercent") -- Setting global
function Create(arg1) -- Line 23
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 25
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
MainFrame.Visible = false
function IsTeamMate(arg1, arg2) -- Line 35
	local var12 = arg1
	if var12 then
		var12 = arg2
		if var12 then
			var12 = arg1.Neutral
			if not var12 then
				var12 = arg2.Neutral
				if not var12 then
					if arg1.TeamColor ~= arg2.TeamColor then
						var12 = false
					else
						var12 = true
					end
				end
			end
		end
	end
	return var12
end
function AdjustScreenSize() -- Line 39
	Scope.Position = UDim2.new(0.5, -10 - Gui.AbsoluteSize.Y / 2, 0, -10)
	Scope.Size = UDim2.new(0, 20 + Gui.AbsoluteSize.Y, 0, 30 + Gui.AbsoluteSize.Y, 1, 20)
	LeftFrame.Size = UDim2.new(0, 30 + (Gui.AbsoluteSize.X - Gui.AbsoluteSize.Y) / 2, 1, 30)
	RightFrame.Size = UDim2.new(0, 30 + (Gui.AbsoluteSize.X - Gui.AbsoluteSize.Y) / 2, 1, 30)
	RightFrame.Position = UDim2.new(1, -10 - (Gui.AbsoluteSize.X - Gui.AbsoluteSize.Y) / 2, 0, -10)
end
function SetSpread(arg1) -- Line 47
	local Spread = arg1.Spread
	local Speed = arg1.Speed
	if not Spread or not Speed then
	else
		Crosshair:TweenPosition(UDim2.new(0.5, (1 - Spread * Gui.AbsoluteSize.Y) / 2, 0.5, -18 - Spread * Gui.AbsoluteSize.Y / 2), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, Speed, true, function() -- Line 52
		end)
		Crosshair:TweenSize(UDim2.new(0, Spread * Gui.AbsoluteSize.Y, 0, Spread * Gui.AbsoluteSize.Y), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, Speed, true, function() -- Line 53
		end)
	end
end
function AdjustSpread() -- Line 56
	if not Tool.Enabled then
		SetSpread({
			Spread = 0.125;
			Speed = 0.5;
		})
	elseif Tool.Enabled then
		SetSpread({
			Spread = 0;
			Speed = 0.25;
		})
	end
end
function AdjustZoomDisplay() -- Line 64
	ZoomPercentLabel.Visible = true
	ZoomPercentLabel.Text = "Zoom : "..tostring(ZoomPercent.Value)..'%'
end
Tool.Changed:connect(function(arg1) -- Line 69
	if arg1 == "Enabled" then
		AdjustSpread()
	end
end)
ZoomPercent.Changed:connect(function() -- Line 75
	AdjustZoomDisplay()
end)
Gui.Changed:connect(function() -- Line 79
	AdjustScreenSize()
end)
RunService.RenderStepped:connect(function() -- Line 83
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Target = Mouse.Target
	local var32
	local var33
	if not Tool.Enabled then
		var33 = BrickColor.new("Medium stone grey").Color
		local var34
	else
		if Target then
			local var35 = nil
			if var35:IsA("Hat") or var35:IsA("Tool") then
				var35 = var35.Parent
			end
			local Humanoid = var35:FindFirstChild("Humanoid")
			local function INLINED() -- Internal function, doesn't exist in bytecode
				local Players_GetPlayerFromCharacter_result1 = Players:GetPlayerFromCharacter(var35)
				return Players_GetPlayerFromCharacter_result1
			end
			if Humanoid and 0 < Humanoid.Health and (not INLINED() or Players_GetPlayerFromCharacter_result1 and Players_GetPlayerFromCharacter_result1 ~= Player and not IsTeamMate(Player, Players_GetPlayerFromCharacter_result1)) then
				var32 = var35
			end
		end
		if var32 then
			var35 = BrickColor.new("Magenta")
			var33 = var35.Color
		end
	end
	for _, v_2 in pairs(Crosshair:GetChildren()) do
		if v_2:IsA("Frame") then
			v_2.BackgroundColor3 = var33
			v_2.BorderColor3 = var33
		end
	end
end)
AdjustScreenSize()
AdjustZoomDisplay()
MainFrame.Visible = true