local mouse = game.Players.LocalPlayer:GetMouse()
local GuyLocation = script.Parent.Name
local user = game.Players:WaitForChild("" .. GuyLocation .. "")
local char = user.Character
local humanoid = char:WaitForChild("Humanoid")
Toggle = false
local animation = Instance.new("Animation", char)
animation.Name = "Actions"
animation.AnimationId = "http://www.roblox.com/Asset?ID=431926970"
local anim = humanoid:LoadAnimation(animation)
user.Chatted:connect(function(msg)
if msg:sub(1, 8) == "/kneel" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877166475"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
    elseif msg:sub(1, 12) == "/squat" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877167695"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "/sit" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877169410"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "/tie" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877171629"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "/e pray" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877172685"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "/turnup" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877173612"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	elseif msg:sub(1, 12) == "/crawl" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid:///13877174633"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   
	   elseif msg:sub(1, 12) == "/moneybop" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877178179"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "s" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877179693"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "/shoot" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877180807"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	   elseif msg:sub(1, 12) == "/hips" then
        if Toggle == false then
            Toggle = true
            anim:Stop()
			animation.AnimationId = "rbxassetid://13877181886"
            anim1 = humanoid:LoadAnimation(animation)
            anim1:Play()
        else
            Toggle = false
            anim1:Stop()
        end
	elseif msg:sub(1, 12) == "/lean" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877162348"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/shottaflow2" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877160996"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/hands" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877158073"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/arms" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877159490"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/woowalk" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877164128"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/shottaflow" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877183023"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/bloodwalk" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877184017"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/zeze" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877186505"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/thewoo" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877187963"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/hiphop" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877189554"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/brook" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877190567"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
		elseif msg:sub(1, 12) == "/jiggy" then
			if Toggle == false then
				Toggle = true
				anim:Stop()
			animation.AnimationId = "rbxassetid://13877191672"
				anim1 = humanoid:LoadAnimation(animation)
				anim1:Play()
			else
				Toggle = false
				anim1:Stop()
			end
	elseif msg:sub(1, 12) == "/shakedat" then
		if Toggle == false then
			Toggle = true
			anim:Stop()
			animation.AnimationId = "rbxassetid://13877193502"
			anim1 = humanoid:LoadAnimation(animation)
			anim1:Play()
		else
			Toggle = false
			anim1:Stop()
			end	
		end
	end)



