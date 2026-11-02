local refresh = 10
local selected = script.Parent.normal.SELECTED

local policeFrame = script.Parent.police
local emsFrame = script.Parent.ems

local normalFrame = script.Parent.normal
local assets = game.ReplicatedStorage.PhoneStuff

script.Parent.normal.ScrollingFrame:WaitForChild("911").MouseButton1Click:Connect(function()
	normalFrame.Visible = false
	policeFrame.Visible = true
end)

script.Parent.normal.ScrollingFrame:WaitForChild("911EMS").MouseButton1Click:Connect(function()
	normalFrame.Visible = false
	emsFrame.Visible = true
end)

emsFrame.back.MouseButton1Click:Connect(function()
	normalFrame.Visible = true
	emsFrame.Visible = false
end)

policeFrame.back.MouseButton1Click:Connect(function()
	normalFrame.Visible = true
	policeFrame.Visible = false
end)

policeFrame.call.MouseButton1Click:Connect(function()
	local function msg(ms)
		policeFrame.sit.Text = ms
		wait(3)
		policeFrame.sit.Text = "Situation/Location:"
	end
	
	local sit = policeFrame.callInfo.Text
	if sit == "" then return end
	local res = game.ReplicatedStorage.PoliceCall:InvokeServer(sit)

	if res == "cd" then
		return msg("Please wait before calling again")
	end	
	if res == "blank" then
		msg("Blank call")
	end	

	msg("Call sent!")
end)

emsFrame.call.MouseButton1Click:Connect(function()
	local function msg(ms)
		emsFrame.sit.Text = ms
		wait(3)
		emsFrame.sit.Text = "Situation/Location:"
	end

	local sit = emsFrame.callInfo.Text
	if sit == "" then return end
	local res = game.ReplicatedStorage.PoliceCall:InvokeServer(sit,"EMS")

	if res == "cd" then
		return msg("Please wait before calling again")
	end	
	if res == "blank" then
		msg("Blank call")
	end	

	msg("Call sent!")
end)

function createOnList(name,parent)
	
	local temp = game.ReplicatedStorage.callListTemplate:Clone()
	temp.Text = name
	temp.Name = name
	temp.Parent = parent
	
	temp.MouseButton1Click:Connect(function()
		local plr2 = game.Players:FindFirstChild(name)
		if plr2 then
			selected.Value = plr2
			normalFrame.description.Text = "#: "..plr2.UserId
		end
	end)
end

function refreshList()
	
	local list = script.Parent.normal.ScrollingFrame
	
	for i,v in pairs(list:GetChildren()) do
		if (v.Name ~= "911" and v.Name ~= "911EMS") and v:IsA("TextButton") then
			v:Destroy()
		end
	end
	
	for i,v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer then
			createOnList(v.Name,list)
		end
	end
	
end
normalFrame.call.MouseButton1Click:Connect(function()
	local function msg(ms)
		normalFrame.description.Text = ms
		wait(3)
		if selected.Value and selected.Value ~= nil then
			normalFrame.description.Text = "#: "..selected.Value.UserId
		else
			normalFrame.description.Text = "#: None"
		end
	end
	print("Calling")
	
	if not selected.Value or selected.Value == "" or (selected.Value == nil or selected.Value == false) then
		return msg("Invalid or no number selected.")
	end
	
	assets.PhoneCalling:Play()
	
	local res = game.ReplicatedStorage.PhoneStuff.PhoneCall:InvokeServer(selected.Value)
	
	if not res or res == "" or res == false or res == nil then
		return "nil"
	end
	
	print("PHONE RESPONSE: "..res)
	
	if res == "off" then
		msg("Player has their phone off.")
		assets.PhoneCalling:Stop()
		assets.PhoneFailure:Play()
	end
	if res == "urotp" then
		msg("You're already on a call!")
		assets.PhoneCalling:Stop()
		assets.PhoneFailure:Play()
	end
	if res == "otp" then
		msg("Player is already on a call!")
		assets.PhoneCalling:Stop()
		assets.PhoneFailure:Play()
	end
	if res == "rec" then
		msg("Player is already receiving a call!")
		assets.PhoneCalling:Stop()
		assets.PhoneFailure:Play()
	end
	if res == "none" then
		msg("Timed out")
		assets.PhoneCalling:Stop()
		assets.PhoneFailure:Play()
	end
	if res == "cooldown" then
		msg("On cooldown!")
		assets.PhoneCalling:Stop()
		assets.PhoneFailure:Play()
	end
	
end)

refreshList()

while wait(refresh) do
	refreshList()
end