wwlocal clientRemotes = game.ReplicatedStorage:WaitForChild("Client")
local callAccepted, callAction, removeCall, addCall, chatAdded = clientRemotes:WaitForChild("CallAccepted"), clientRemotes:WaitForChild("CallAction"), clientRemotes:WaitForChild("RemoveCall"), clientRemotes:WaitForChild("AddCall"), clientRemotes:WaitForChild("ChatAdded")
local toilet = {}

local player = game.Players.LocalPlayer

player.CharacterAdded:Connect(function()
	print("flushing")
	for i,v in pairs(toilet) do
		if v then v:Destroy() end
	end
end)

print("Police module loaded.")

function track(playerToTrack) 
	print("Got track")
	local plr = player
	local v = playerToTrack
	local bb = Instance.new('BillboardGui')
	--local la = Instance.new('SelectionPartLasso',bb)
	local Humanoid = plr.Character:FindFirstChild("Humanoid")
	local Part = v.Character:FindFirstChild("HumanoidRootPart")
	if Part and Humanoid then
		print("Valid!")
		--la.Part = Part
		--la.Humanoid = Humanoid
		bb.Name = v.Name..'Tracker'
		bb.Adornee = v.Character.Head
		bb.AlwaysOnTop = true
		bb.StudsOffset = Vector3.new(0,2,0)
		bb.Size = UDim2.new(0,100,0,40)
		local f = Instance.new('Frame',bb)
		f.BackgroundTransparency = 1
		f.Size = UDim2.new(1,0,1,0)
		local name = Instance.new('TextLabel',f)
		name.Text = v.Name
		name.BackgroundTransparency = 1
		name.Font = "Arial"
		name.TextColor3 = Color3.new(1,1,1)
		name.TextStrokeColor3 = Color3.new(0,0,0)
		name.TextStrokeTransparency = 0
		name.Size = UDim2.new(1,0,0,20)
		name.TextScaled = true
		name.TextWrapped = true
		local arrow = name:clone()
		arrow.Parent = f
		arrow.Position = UDim2.new(0,0,0,20)
		arrow.Text = 'v'
		
		bb.Parent = plr.PlayerGui
		
		v.CharacterRemoving:Connect(function()
			bb:Destroy()
		end)
		plr.CharacterRemoving:Connect(function()
			bb:Destroy()
		end)
		
		wait(180)
		bb:Destroy()
	else
		print("Invalid!")
	end
end

function addChat(uname,phrase,distress)
	print("Add chat")
	if player.Team ~= game.Teams.Police and player.Team ~= game.Teams.EMS then return print("Ignore, not police") end
	if not player.PlayerGui:FindFirstChild("PoliceGui") and not player.PlayerGui:FindFirstChild("EMSGui") then return print("Ignore, no gui") end
	
	local gui = player.PlayerGui:FindFirstChild("PoliceGui") or player.PlayerGui:FindFirstChild("EMSGui")
	local comFrame = gui.Comms
	
	local children = {}
	local actChildren = comFrame.Talking:GetChildren()

	for i,v in pairs(actChildren) do
		if v:IsA("TextLabel") then
			table.insert(children,v)
		end
	end

	wait()

	if #children >= 6 then
		print("Above max, remove first child")
		children[1]:Destroy()
	end

	if uname and phrase then
		local stringNa = game.ReplicatedStorage.String:Clone()
		stringNa.Visible = false
		stringNa.Parent = comFrame.Talking
		stringNa.Text = uname..": "..phrase
		stringNa.Visible = true
		
		if distress then
			stringNa.Font = Enum.Font.SourceSansBold
			stringNa.TextColor3 = Color3.fromRGB(255,0,0)
		end
	end

	if distress then
		game.Lighting.sound.radioComeOn:Play()
		track(game.Players:FindFirstChild(uname))
		print("Tracking user")
	end
end

chatAdded.OnClientEvent:Connect(function(from,phrase,distressSig)
	print("GOT A FIRE")
	addChat(from,phrase,distressSig)
	print("Done!")
end)

addCall.OnClientEvent:Connect(function(callerName,callReason,id)
	if player.Team ~= game.Teams.Police and player.Team ~= game.Teams.EMS then return print("Ignore, not police") end
	if not player.PlayerGui:FindFirstChild("PoliceGui") and not player.PlayerGui:FindFirstChild("EMSGui") then return print("Ignore, no gui") end
	
	local gui = player.PlayerGui:FindFirstChild("PoliceGui") or player.PlayerGui:FindFirstChild("EMSGui") 
	
	local callFrame = game.ReplicatedStorage.CallFrame:Clone()
	callFrame.Parent = gui.IncomingCallFrame.Frame.ScrollingFrame
	
	callFrame.reasonforcall.Text = callReason
	callFrame.uname.Text = callerName
	callFrame.CALLID.Value = id
	
	print("Call added.")
	game.ReplicatedStorage.Notification:Play()
end)

callAction.OnClientEvent:Connect(function(caller,action)

end)

removeCall.OnClientEvent:Connect(function(id)
	if player.Team ~= game.Teams.Police and player.Team ~= game.Teams.EMS then return print("Ignore, not police") end
	if not player.PlayerGui:FindFirstChild("PoliceGui") and not player.PlayerGui:FindFirstChild("EMSGui") then return print("Ignore, no gui") end
	
	local gui = player.PlayerGui:FindFirstChild("PoliceGui") or player.PlayerGui:FindFirstChild("EMSGui") 
	local scroller = gui.IncomingCallFrame.Frame.ScrollingFrame
	
	for i,v in pairs(scroller:GetChildren()) do
		if v:IsA("Frame") then
			if v.CALLID.Value == id then v:Destroy() end
		end
	end
	
	if game.Workspace:FindFirstChild("CALLMARK_"..id) then
		game.Workspace:FindFirstChild("CALLMARK_"..id):Destroy()
	end
	
end)


-- information
--[[
[1] = player
[2] = reason
[3] = location
]]

local acceptedCalls = {}

function markCall(information,id)
	
	local loc = game.ReplicatedStorage.CallLocation:Clone()
	loc.Parent = game.Workspace
	loc.Position = information[3]
	loc.SurfaceGui.ToolText.Text = "📞 CALL #"..id	
	loc.Name = "CALLMARK_"..id
	
	table.insert(toilet,loc)
	
end

callAccepted.OnClientEvent:Connect(function(plrAct,reason,id,information)
	if player.Team ~= game.Teams.Police and player.Team ~= game.Teams.EMS then return print("Ignore, not police") end
	if not player.PlayerGui:FindFirstChild("PoliceGui") and not player.PlayerGui:FindFirstChild("EMSGui") then return print("Ignore, no gui") end

	local gui = player.PlayerGui:FindFirstChild("PoliceGui") or player.PlayerGui:FindFirstChild("EMSGui") 
	local scroller = gui.IncomingCallFrame.Frame.ScrollingFrame

	for i,v in pairs(scroller:GetChildren()) do
		if v:IsA("Frame") then
			if v.CALLID.Value == id and reason == "accept" then
				if not acceptedCalls[id] then
					acceptedCalls[id] = plrAct
					v.act.BackgroundColor3 = Color3.fromRGB(255,85,0)
					if plrAct.UserId == game.Players.LocalPlayer.UserId then markCall(information,id) print("marked call") _G.showMsg("The call's location has been marked.",3) end
				else
					if not game.Workspace:FindFirstChild("CALLMARK_"..id) and plrAct == game.Players.LocalPlayer then
						markCall(information,id) 
						if acceptedCalls[id] and acceptedCalls[id].Name then
							_G.showMsg("You have joined "..acceptedCalls[id].Name.."'s call.",3)
						else
							_G.showMsg("You have joined the call.",3)
						end
					end
				end	
			end
		end
	end
	
end)