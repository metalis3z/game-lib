-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

workspace:FindFirstChild("LobbyMusic").Volume = 0
local v_u_1 = -1
local v_u_2 = 0
for v3 = 1, 4 do
	game:GetService("TweenService"):Create(script.Parent:WaitForChild("Phases"):FindFirstChild(v3), TweenInfo.new(0), {
		["PlaybackSpeed"] = 1
	}):Play()
end
game:GetService("RunService").Stepped:Connect(function()
	-- upvalues: (ref) v_u_1, (ref) v_u_2
	if workspace.GAME.STOP_MUSIC.Value == true then
		for _, v4 in workspace.PLAYERS.KILLER:GetChildren() do
			if v4:FindFirstChild("Phases") then
				for v5 = 1, 4 do
					game:GetService("TweenService"):Create(script.Parent:FindFirstChild("Phases"):FindFirstChild(v5), TweenInfo.new(0.25), {
						["Volume"] = 0
					}):Play()
				end
			end
		end
		v_u_1 = -1
		return
	elseif workspace.GAME.STOP_MUSIC_ALL.Value == true then
		for _, v6 in workspace.PLAYERS.KILLER:GetChildren() do
			if v6:FindFirstChild("Phases") then
				for v7 = 1, 6 do
					if v6:WaitForChild("Phases"):FindFirstChild(v7) then
						game:GetService("TweenService"):Create(v6:FindFirstChild("Phases"):FindFirstChild(v7), TweenInfo.new(0.25), {
							["Volume"] = 0
						}):Play()
					end
				end
			end
		end
		v_u_1 = 0
		return
	elseif game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
		for v8 = 1, 6 do
			if script.Parent:WaitForChild("Phases"):FindFirstChild(v8) then
				game:GetService("TweenService"):Create(script.Parent:WaitForChild("Phases"):FindFirstChild(v8), TweenInfo.new(0.5), {
					["PlaybackSpeed"] = 0
				}):Play()
			end
		end
		v_u_1 = -1
		return
	else
		if workspace:FindFirstChild("MAPS"):FindFirstChild("GAME MAP"):FindFirstChild("Music") then
			local v9 = workspace:FindFirstChild("MAPS"):FindFirstChild("GAME MAP"):FindFirstChild("Music")
			if v_u_1 > 0 then
				game:GetService("TweenService"):Create(v9, TweenInfo.new(0.5), {
					["Volume"] = 0
				}):Play()
			else
				game:GetService("TweenService"):Create(v9, TweenInfo.new(0.5), {
					["Volume"] = v9:GetAttribute("Volume")
				}):Play()
			end
		end
		local v10 = false
		for _, v11 in workspace.PLAYERS.ALIVE:GetChildren() do
			if v11:FindFirstChild("HumanoidRootPart") and (v11:FindFirstChild("HumanoidRootPart").Position - script.Parent:FindFirstChild("HumanoidRootPart").Position).Magnitude <= 15 then
				v10 = true
			end
		end
		if script.Parent:HasTag("INVISIBILE") or (script.Parent:HasTag("TRUE_UNDETECTABLE") or not script.Parent:HasTag("COMBAT") and v10 ~= true) then
			v_u_2 = 0
			for v12 = 1, 4 do
				game:GetService("TweenService"):Create(script.Parent:FindFirstChild("Phases"):FindFirstChild(v12), TweenInfo.new(0.5), {
					["Volume"] = 0
				}):Play()
				game:GetService("TweenService"):Create(script.Parent:FindFirstChild("Phases"):FindFirstChild(v12), TweenInfo.new(0.5), {
					["PlaybackSpeed"] = 0
				}):Play()
			end
		else
			if v_u_2 ~= 4 then
				script.Parent:WaitForChild("Phases"):FindFirstChild("4").TimePosition = 0
			end
			v_u_2 = 4
			for v13 = 1, 4 do
				if v13 ~= 4 then
					game:GetService("TweenService"):Create(script.Parent:FindFirstChild("Phases"):FindFirstChild(v13), TweenInfo.new(0), {
						["Volume"] = 0
					}):Play()
				end
			end
			game:GetService("TweenService"):Create(script.Parent:FindFirstChild("Phases"):FindFirstChild("4"), TweenInfo.new(0), {
				["PlaybackSpeed"] = 1
			}):Play()
			game:GetService("TweenService"):Create(script.Parent:FindFirstChild("Phases"):FindFirstChild("4"), TweenInfo.new(0), {
				["Volume"] = script.Parent:FindFirstChild("Phases"):FindFirstChild("3"):GetAttribute("VOLUME_MAX")
			}):Play()
		end
	end
end)