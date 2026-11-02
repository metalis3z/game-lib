-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

--Decompiled by Medal, I take no credit I only Made The dumper and I I.. I iron man
local v_u_1 = script.Parent
local v_u_2 = v_u_1:WaitForChild("Remote")
local v_u_3 = nil
local v_u_4 = game:GetService("ContextActionService")
local v_u_5 = game:GetService("Players").LocalPlayer
local v_u_6 = v_u_5:GetMouse()
function onAction()
	-- upvalues: (copy) v_u_2, (copy) v_u_6
	v_u_2:FireServer("Activate", v_u_6.Hit.p)
end
function onEquipped(p7)
	onUnequipped()
	p7.Button1Down:connect(onAction)
end
function onUnequipped()
	-- upvalues: (copy) v_u_4, (ref) v_u_3
	v_u_4:UnbindAction("PenguinAttack")
	if v_u_3 then
		v_u_3:Destroy()
	end
end
function playAnimation(p8, ...)
	-- upvalues: (copy) v_u_1
	local v9 = v_u_1:FindFirstChild(p8)
	local v10 = v9 and v_u_1.Parent:FindFirstChild("Humanoid")
	if v10 then
		v10:LoadAnimation(v9):Play(...)
	end
end
function chooseSong()
	-- upvalues: (copy) v_u_5, (copy) v_u_2, (ref) v_u_3
	if not v_u_5.PlayerGui:FindFirstChild("ChooseSongGui") then
		local v_u_11 = Instance.new("ScreenGui")
		v_u_11.Name = "ChooseSongGui"
		local v12 = Instance.new("Frame")
		v12.Style = "RobloxRound"
		v12.Size = UDim2.new(0.25, 0, 0.25, 0)
		v12.Position = UDim2.new((1 - v12.Size.X.Scale) / 2, 0, (1 - v12.Size.Y.Scale) / 2, 0)
		v12.Parent = v_u_11
		v12.Draggable = true
		local v13 = Instance.new("TextLabel")
		v13.BackgroundTransparency = 1
		v13.TextStrokeTransparency = 0
		v13.TextColor3 = Color3.new(1, 1, 1)
		v13.Size = UDim2.new(1, 0, 0.6, 0)
		v13.TextScaled = true
		v13.Text = "Lay down the beat!\nPut in the ID number for a song you love that\'s been uploaded to ROBLOX.\nLeave it blank to stop playing music."
		v13.Parent = v12
		local v_u_14 = Instance.new("TextBox")
		v_u_14.BackgroundColor3 = Color3.new(0, 0, 0)
		v_u_14.BackgroundTransparency = 0.5
		v_u_14.BorderColor3 = Color3.new(1, 1, 1)
		v_u_14.TextColor3 = Color3.new(1, 1, 1)
		v_u_14.TextStrokeTransparency = 1
		v_u_14.TextScaled = true
		v_u_14.Text = "142376088"
		v_u_14.Size = UDim2.new(1, 0, 0.2, 0)
		v_u_14.Position = UDim2.new(0, 0, 0.6, 0)
		v_u_14.Parent = v12
		local v15 = Instance.new("TextButton")
		v15.Style = "RobloxButton"
		v15.Size = UDim2.new(0.75, 0, 0.2, 0)
		v15.Position = UDim2.new(0.125, 0, 0.8, 0)
		v15.TextColor3 = Color3.new(1, 1, 1)
		v15.TextStrokeTransparency = 0
		v15.Text = "Play!"
		v15.TextScaled = true
		v15.Parent = v12
		v15.MouseButton1Click:connect(function()
			-- upvalues: (ref) v_u_2, (copy) v_u_14, (copy) v_u_11
			local v16 = v_u_2
			local v17 = v_u_14.Text
			v16:FireServer("PlaySong", (tonumber(v17)))
			v_u_11:Destroy()
		end)
		v_u_11.Parent = v_u_5.PlayerGui
		v_u_3 = v_u_11
	end
end
function onRemote(p18, ...)
	if p18 == "PlayAnimation" then
		playAnimation(...)
	end
	if p18 == "ChooseSong" then
		chooseSong()
	end
end
v_u_1.Equipped:connect(onEquipped)
v_u_1.Unequipped:connect(onUnequipped)
v_u_2.OnClientEvent:connect(onRemote)
