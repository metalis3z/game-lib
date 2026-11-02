-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local _ = script.Parent
local v_u_1 = { Instance.new("NumberValue") }
local v_u_2 = { workspace:WaitForChild("LobbyMusic") }
local v_u_3 = math.random(#v_u_2)
local v_u_4 = nil
local function v_u_5()
	-- upvalues: (ref) v_u_3, (copy) v_u_2, (ref) v_u_4, (copy) v_u_5
	v_u_3 = v_u_3 % #v_u_2 + 1
	v_u_4 = v_u_2[v_u_3]
	v_u_4:Play()
	v_u_4.Stopped:Once(v_u_5)
end
v_u_3 = v_u_3 % #v_u_2 + 1
v_u_4 = v_u_2[v_u_3]
v_u_4:Play()
v_u_4.Stopped:Once(v_u_5)
game:GetService("RunService").Stepped:Connect(function()
	-- upvalues: (ref) v_u_4, (copy) v_u_1
	for _, v6 in workspace.PLAYERS.KILLER:GetChildren() do
		if v6:FindFirstChild("Phases") then
			for v7 = 1, 4 do
				v6:FindFirstChild("Phases"):FindFirstChild(v7).Volume = 0
			end
		end
	end
	if game.Players.LocalPlayer:GetAttribute("LOADED") == false or (workspace.GAME.STOP_MUSIC_ALL.Value == true or (workspace.GAME.LMS.Value == true or workspace.GAME.STOP_MUSIC.Value == true)) then
		v_u_4.TimePosition = 0
		v_u_4.Volume = 0
		v_u_1[1].Value = 0
	else
		if workspace.GAME.TIMER.Value <= 18 then
			game:GetService("TweenService"):Create(v_u_1[1], TweenInfo.new(4), {
				["Value"] = 0
			}):Play()
		else
			game:GetService("TweenService"):Create(v_u_1[1], TweenInfo.new(0.25), {
				["Value"] = 3
			}):Play()
		end
		v_u_4.Volume = v_u_1[1].Value
	end
end)