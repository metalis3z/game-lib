-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:43:41
-- Luau version 6, Types version 3
-- Time taken: 0.004384 seconds

wait()
Players = game:GetService("Players") -- Setting global
Debris = game:GetService("Debris") -- Setting global
function Create(arg1) -- Line 8
	local any_upvr = Instance.new(arg1)
	return function(arg1_2) -- Line 10
		--[[ Upvalues[1]:
			[1]: any_upvr (readonly)
		]]
		for i, v in pairs(arg1_2) do
			any_upvr[i] = v
		end
		return any_upvr
	end
end
Player = Players.LocalPlayer -- Setting global
Character = Player.Character -- Setting global
Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
function ShakeCam() -- Line 23
	local CurrentCamera = game:GetService("Workspace").CurrentCamera
	CurrentCamera.CoordinateFrame = CFrame.new(CurrentCamera.Focus.p) * (CurrentCamera.CoordinateFrame - CurrentCamera.CoordinateFrame.p) * CFrame.fromEulerAnglesXYZ(math.random(-10, 10) / 40, math.random(-10, 10) / 40, math.random(-10, 10) / 40) * CFrame.new(0, 0, (CurrentCamera.CoordinateFrame.p - CurrentCamera.Focus.p).Magnitude)
end
function TweenNumber(arg1, arg2, arg3, arg4) -- Line 31
	local var12 = arg4 * 30
	local var13 = (arg3 - arg1[arg2]) / var12
	for _ = 1, var12 do
		arg1[arg2] += var13
		wait()
	end
	return true
end
if Humanoid then
	Humanoid.WalkSpeed = 6
	local var14_upvw = false
	pcall(function() -- Line 44
		--[[ Upvalues[1]:
			[1]: var14_upvw (read and write)
		]]
		Spawn(function() -- Line 45
			for _ = 1, math.random(5, 10) do
				ShakeCam()
				wait(0.03333333333333333)
			end
		end)
		local var19 = Create("BlurEffect")({
			Name = "Blur";
			Size = 0;
			Enabled = true;
		})
		Debris:AddItem(var19, 15)
		var19.Parent = game:GetService("Workspace").CurrentCamera
		TweenNumber(var19, "Size", 35, 1)
		wait(4)
		TweenNumber(var19, "Size", 0, 2)
		if var19 and var19.Parent then
			var19:Destroy()
		end
		var14_upvw = true
	end)
	if not var14_upvw then
		wait(3)
	end
	Humanoid.WalkSpeed = 16
end
Debris:AddItem(script, 0.5)