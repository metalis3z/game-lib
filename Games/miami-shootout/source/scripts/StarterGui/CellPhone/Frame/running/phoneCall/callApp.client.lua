local phoneAssets = game.ReplicatedStorage.PhoneStuff

local receivingCall = false
local placeHolder = "rbxassetid://837701510"

function hideApps()
	for i,v in pairs(script.Parent.Parent.Parent.apps:GetChildren()) do
		if v.Visible then
			v.Visible = false
		end
	end
end

function showApps()
	for i,v in pairs(script.Parent.Parent.Parent.apps:GetChildren()) do
		if not v.Visible then
			v.Visible = true
		end
	end
end

function hideOtherRunnings(except)
	for i,v in pairs(script.Parent.Parent.Parent.running:GetChildren()) do
		if v.Visible and v.Name ~= except then
			v.Visible = false
		end
	end
end

function hideCall()
	script.Parent.Visible = false
	showApps()
end

function acceptIncoming()
	phoneAssets.PhoneRinging:Stop()
	if receivingCall then
		receivingCall = false
		phoneAssets.Phone:FireServer("accept")
		hideCall()
	end
end

function declineIncoming(userInput)
	phoneAssets.PhoneRinging:Stop()
	if receivingCall then
		receivingCall = false
		if userInput == false then
			hideCall()
		elseif userInput == true then
			hideCall()
			phoneAssets.Phone:FireServer("decline")
			phoneAssets.PhoneEnd:Play()
		end
	end
end

function openIncoming(from)
	print("OPENING AN INCOMING CALL")
	hideOtherRunnings(script.Parent.Name)
	hideApps()
	script.Parent.Visible = true
	receivingCall = true
	phoneAssets.PhoneRinging:Play()
	spawn(function()
		local content, isReady = game.Players:GetUserThumbnailAsync(from.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
		local icon = script.Parent.callIcon
		icon.Image = (isReady and content) or placeHolder
	end)
	script.Parent.callerName.Text = from.Name
end

script.Parent.accept.MouseButton1Click:Connect(function()
	acceptIncoming()
end)

script.Parent.decline.MouseButton1Click:Connect(function()
	declineIncoming(true)
end)

script.Parent.Parent.Parent.home.MouseButton1Click:Connect(function()
	if receivingCall then
		declineIncoming(true)
	end
end)

game.ReplicatedStorage.PhoneStuff:WaitForChild("Phone").OnClientEvent:Connect(function(action,extra)
	print("action "..action)
	if action == "play" then
		extra:Play()
	end
	if action == "stop" then
		extra:Stop()
	end
	if action == "receiveCall" then
		openIncoming(extra)
		print("received")
	end
	if action == "stopReceiving" then
		declineIncoming(false)
	end
end)

print("call app loaded")