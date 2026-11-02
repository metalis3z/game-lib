local db = {}

game.ReplicatedStorage.Photo.OnServerEvent:Connect(function(p)
	if p.Character and p.Character:FindFirstChild("Phone") then
		if db[p.UserId] then return end
		db[p.UserId] = true
		local phone = p.Character:FindFirstChild("Phone")
		phone.Handle.cam:Play()
		local lighting = game.Lighting.PhoneFlash:Clone()
		lighting.Parent = phone.Part
		delay(0.9,function()
			lighting:Destroy()
			db[p.UserId] = nil
		end)
	end
end)

local messages = {}

-- POLICE --

local calls = {}
local dbP = {}

-- call construct
--[[
[1] = from (player)
[2] = reason (string)
[3] = call location (vector3)
]]

game.ReplicatedStorage.PoliceCalls.OnServerInvoke = function(p,act,id)
	print("action constructed")
	if p.Team ~= game.Teams.Police and p.Team ~= game.Teams.EMS then return p:Kick("You know why") end

	if act == "rem" then
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Team == game.Teams.Police or v.Team == game.Teams.EMS then
				game.ReplicatedStorage.Client.RemoveCall:FireClient(v,id)
			end
		end
	end
	if act == "accept" then
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Team == game.Teams.Police or v.Team == game.Teams.EMS then
				game.ReplicatedStorage.Client.CallAccepted:FireClient(v,p,"accept",id,calls[id])
			end
		end
	end
	if act == "claim" then
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Team == game.Teams.Police or v.Team == game.Teams.EMS then
				game.ReplicatedStorage.Client.CallAccepted:FireClient(v,p,"claim",id,calls[id])
			end
		end
	end
	
end

game.ReplicatedStorage.PoliceCall.OnServerInvoke = function(calledBy,callerReason,service)
	if callerReason == "" then return "blank" end
	if dbP[calledBy.Name] then return "cd" end
	dbP[calledBy.Name] = true

	delay(8,function()
		dbP[calledBy.Name] = false
	end)

	local FilteredString = game:GetService("Chat"):FilterStringForBroadcast(callerReason, calledBy)
	local CallLocation = calledBy.Character.PrimaryPart.Position

	local callID = #calls+1

	calls[callID] = {calledBy,callerReason,CallLocation}
	
	if service ~= "EMS" then
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Team == game.Teams.Police then
				game.ReplicatedStorage.Client.AddCall:FireClient(v,calledBy.Name,FilteredString,callID,CallLocation)
			end
		end
	else
		for i,v in pairs(game.Players:GetPlayers()) do
			if v.Team == game.Teams.EMS then
				game.ReplicatedStorage.Client.AddCall:FireClient(v,calledBy.Name,FilteredString,callID,CallLocation)
			end
		end
	end
	
end

-- PHONES --

local callDb = {}
local turnedOff = {}
local OTP = {}
local phoneAssets = game.ReplicatedStorage.PhoneStuff

function showChatBubble(phone,msg,color)
	local ChatService = game:GetService("Chat")
	ChatService:Chat(phone, msg, color) 
end

function showMsg(player,msg,long)
	
	local msgType = "lmsg"
	
	if not long then
		msgType = "msg"
	end
	
	game.ReplicatedStorage.server:FireClient(player,msgType,msg)
end

phoneAssets.DisablePhone.OnServerEvent:Connect(function(p,value)
	if value == false then
		print("now blocking calls")
		turnedOff[p] = true
	else
		print("no longer blocking calls")
		turnedOff[p] = nil
	end
end)

function endService(p)
	if OTP[p] and OTP[p] ~= nil then
		showMsg(p,"*Hung up*",false)

		phoneAssets.Phone:FireClient(p,"play",phoneAssets.PhoneEnd)
		local onThePhoneWith = OTP[p]
		OTP[p] = nil
		OTP[onThePhoneWith] = nil
	
		if onThePhoneWith and onThePhoneWith.Character and onThePhoneWith.Character:FindFirstChild("Phone") then
			local phone = onThePhoneWith.Character:FindFirstChild("Phone")
			phoneAssets.Phone:FireClient(onThePhoneWith,"play",phoneAssets.PhoneEnd)
			showMsg(onThePhoneWith,"*Hung up*",false)
		end

	end
end

local callQueue = {}

game.Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg)
		if OTP[p] and OTP[p] ~= nil then
			-- transmit the text
			local OTPWith = OTP[p]
			local FilteredString = game:GetService("Chat"):FilterStringForBroadcast(msg, OTPWith)
			
			if OTPWith and OTPWith.Character and OTPWith.Character:FindFirstChild("Phone") then
				local phone = OTPWith.Character:FindFirstChild("Phone")
				--showChatBubble(phone:FindFirstChild("Part"),p.Name ..": ".. FilteredString,"Green")
				showMsg(OTPWith,p.Name .. ": "..FilteredString,true)
				print("Transmitted!")
			else
				endService(p)
			end
			
		end
	end)
	p.CharacterAdded:Connect(function(c)
		c.ChildRemoved:Connect(function(child)
			--print("caught child remove "..child.Name)
			if child.Name == "Phone" then
				print("ending phone line")
				endService(p)
			end
		end)
		c:WaitForChild("Humanoid").Died:Connect(function()
			print("ending phone line")
			endService(p)
		end)
	end)
end)

game.Players.PlayerRemoving:Connect(function(p)
	endService(p)
end)

-- p being caller, with being called
function startService(p,with)
	OTP[p] = with
	OTP[with] = p
	
	-- show service started
	local phone = p.Character:FindFirstChild("Phone")
	
	if not phone then
		endService(p)
		return
	else
		showMsg(p,"*Picked up*",false)
	end
	
	local phone2 = with.Character:FindFirstChild("Phone")

	if not phone2 then
		endService(p)
		return
	else
		showMsg(with,"*Picked up*",false)
	end
end

phoneAssets.PhoneCall.OnServerInvoke = function(p,callUser)
	print("receiving on server")
	if callDb[p] then
		return "cooldown"
	end
	
	if p == callUser then
		return "off"
	end
	
	if p.Character and p.Character:FindFirstChild("Phone") then
		print("CALL SENT OUT TO "..callUser.Name.. " FROM "..p.Name)
		callDb[p] = true
		delay(3,function()
			callDb[p] = nil
		end)
		
		if turnedOff[callUser] then
			return "off"
		end
		if OTP[p] then
			return "urotp"
		end
		if OTP[callUser] then
			return "otp"
		end
		if callQueue[p] then
			return "rec"
		end
		
		callQueue[callUser] = true
		callQueue[p] = true
		
		local responsed = false
		local acceptCallBind
		acceptCallBind = phoneAssets.Phone.OnServerEvent:Connect(function(plr,action)
			if plr == callUser then
				print("got a response")
				acceptCallBind:Disconnect()
				if action == "accept" then
					responsed = true
					
					callQueue[callUser] = nil
					callQueue[p] = nil
					startService(p,plr)
					phoneAssets.Phone:FireClient(p,"stop",phoneAssets.PhoneCalling)
					--phoneAssets.Phone:FireClient(callUser,"receiveCall",p)
					
					
					return "accepted"
				end
				if action == "decline" then
					responsed = true
					
					callQueue[callUser] = nil
					callQueue[p] = nil
					local phone = p.Character:FindFirstChild("Phone")
					if phone then showMsg(p,"*Declined*",false) end
					phoneAssets.Phone:FireClient(p,"stop",phoneAssets.PhoneCalling)
					
					return "declined"
				end
				
			end
		end)
		phoneAssets.Phone:FireClient(callUser,"receiveCall",p)
		print("Receive call")
		wait(10)
		callQueue[callUser] = nil
		callQueue[p] = nil
		if not responsed then
			if acceptCallBind then acceptCallBind:Disconnect() end
			phoneAssets.Phone:FireClient(callUser,"stopReceiving")
			phoneAssets.Phone:FireClient(p,"stop",phoneAssets.PhoneCalling)
			local phone = p.Character:FindFirstChild("Phone")
			if phone then showMsg(p,"*No response*",false) end
			
			print("no response lol!")
			return "none"
		end
	end	
end

print("loaded call server")