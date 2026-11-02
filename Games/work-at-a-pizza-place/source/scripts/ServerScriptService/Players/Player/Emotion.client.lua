

script:WaitForChild("Amazed")
local player = game.Players.LocalPlayer

debounce = false

local emoteNames = { wave = true, dance = true, dance2 = true, dance3 = true, cheer = true}




function showEmotion(emotion)

	if not debounce then
	
		debounce = true
		if emotion == "Trip" and not player.Character.Humanoid.Jump then
			--print("Traaa")
			pcall(function() player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll) end)
			player.Character.Head.Velocity = player.Character.Head.CFrame.lookVector * 10
			debounce = false
			return
		end
		local torso = player.Character:FindFirstChild("HumanoidRootPart")
		if emotion == "Sleep" and torso  then
			pcall(function() player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics) end)
			

			for _, joint in pairs(torso:GetChildren()) do
			    if joint:IsA("Motor6D") then
			        local w = Instance.new("Rotate")
			        w.Part0 = joint.Part0
			        w.Part1 = joint.Part1
			        w.C0 = joint.C0
			        w.C1 = joint.C1
			        w.Name = joint.Name
			        joint:Destroy()
			        w.Parent = torso
			    end
			end
			wait()
			player.Character.Head.Velocity = player.Character.Head.CFrame.lookVector * -35
			debounce = false
			return
		end
		if emotion == "Wake" and torso then
			pcall(function() player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end)

			for _, joint in pairs(torso:GetChildren()) do
			    if joint:IsA("Rotate") then
			        local w = Instance.new("Motor6D")
			        w.Part0 = joint.Part0
			        w.Part1 = joint.Part1
			        w.C0 = joint.C0
			        w.C1 = joint.C1
			        w.Name = joint.Name
			        joint:Destroy()
			        w.Parent = torso
			    end
			end
			debounce = false
			return
		end
	
		if emoteNames[string.lower(emotion)] then
			
			
			script.Parent.Parent:WaitForChild("Animation",10):WaitForChild("PlayAnimation",10):Invoke(string.lower(emotion))
		
		else
			
			local animation = script:FindFirstChild(emotion)
			if animation ~= nil then
				local face = script.Parent:FindFirstChild("face")
				local newFace = animation:FindFirstChild("Face")
				if face ~= nil and newFace ~= nil then
					workspace.Main.ChangeFace:FireServer(face,newFace)
				end
				local sound = script.Parent:FindFirstChild(animation.Name)
				local animTrack = script.Parent.Parent.Humanoid:LoadAnimation(animation)
				animTrack:Play()
				
				if sound ~= nil then
					sound:Play()
				end
				
			end
			if (emotion == "Hi" or emotion == "Bye") and player.TeamColor == BrickColor.new(21) and player.Character ~= nil and player.Character:FindFirstChild("HumanoidRootPart") then
				--[[for i,v in ipairs(workspace.Customers:GetChildren()) do
					if (emotion == "Hi" and (v.Humanoid.WalkToPart == workspace.Lane1 or v.Humanoid.WalkToPart == workspace.Lane2)) or (emotion == "Bye" and v.Humanoid.WalkToPart == workspace.Entrance) then
						 if (player.Character.Torso.Position - v.Torso.Position).magnitude < 30 then
							wait(1)
							v.InvokeEmotionRemote:FireServer(emotion)
						end
					end
				end]]
			end
		end
		delay(3,function() 
			debounce = false
		end)
	end
end

function isOutdoors()
	for i,area in ipairs(game.ReplicatedStorage.IndoorBounds:GetChildren()) do
		if script.Parent.Position.x > area.Position.x - (area.Size.x/2) then
		if script.Parent.Position.x < area.Position.x + (area.Size.x/2) then
		if script.Parent.Position.z > area.Position.z - (area.Size.z/2) then
		if script.Parent.Position.z < area.Position.z + (area.Size.z/2) then
			return false
		end
		end
		end
		end
	end
	return true
end
	
	
--trip emotion

game.Workspace.Main.TripPlayer.OnClientEvent:connect(function(velocity)
	if isOutdoors() then
		showEmotion("Trip")
		wait()
		if player.Character ~= nil and player.Character:FindFirstChild("Head") then
			player.Character.Head.Velocity = velocity
		end
	end
end)

--hit by a car
game.Workspace.Main.TripPlayer2.OnClientEvent:connect(function(velocity)
	player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
	player.Character.HumanoidRootPart.Velocity = velocity
	wait(1)
	player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Ragdoll)
	
end)

game.Workspace.Main.InvokeEmotion.InvokeEmotion.Event:connect(function(emotion)
	showEmotion(emotion)
end)

game.Workspace.Main.InvokeEmotion.OnClientEvent:connect(function(emotion)
	print("emotion invoke")
	showEmotion(emotion)
end)

local phrases = {
	{"Glee",{"*cheers","woo!","yay","yeah!","woot","omg yes","hooray", "hoorah","@glee@","@sweet","thx", "thank you"}},
	{"Sad",{"whaa","waa","*cries","@awww","@cry@","nooo","nuuu","@sad@","@cry@","DX@"}},
	{"Laugh",{"xd@","lol","rofl","*laughs","haha","lulz","@laugh@","hehe","lele"}},
	{"Angry",{"grr","omg stop","go away","stop it","shut up","stfu","gtfo","@fu@","nooo","@angry@","@mad@","wtf"}},
	{"Scared",{ "ahh","*screams","@run away","gasp","help!","@scared@","@oh no"}},
	{"Amazed",{"wow","woah","@amazing", "cool!", "awesome!","@omg@","@omg!@","@amazed@","holy crap"}},
	{"Hi",{"@hi","hi ", "@hello","@hey","@sup@","@sup" , "@yo " }},
	{"Bye",{"@bye","cya","nice meeting", "so long","see ya","@goodbye","g2g"}},
	{"Confused",{"huh","@confused@"}},
	{"Think",{"hmm","*thinks","@um@","@think@"}},
	{"Point",{"@look at","*points","look!","@point@", "@no u@"}}
	}
	
workspace.Main.Chatted.Chatted.Event:connect(function(msg)
	local msg = "@" .. string.lower(msg) .. "@"
	for i=1,#phrases do
		local emotion = phrases[i][1]
		local words = phrases[i][2]
		for phrase=1,#words do
			if string.match(msg,words[phrase]) then
				showEmotion(emotion)
			end
		end
	end
end)

for _,id in ipairs({182435998,182491037,182491065,182436842,182491248,182491277,182436935,182491368,182491423,42163425}) do
	game:GetService("ContentProvider"):Preload("http://www.roblox.com/asset/?id=" .. id)
end


