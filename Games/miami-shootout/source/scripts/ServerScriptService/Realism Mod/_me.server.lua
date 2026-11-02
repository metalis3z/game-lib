local PlayersService = game:GetService("Players")
local ChatService = game:GetService("Chat")
--[[
local Emote_Commands_Function = {
	walks = function(Character) 
		Character.Humanoid.WalkToPoint = Character.Torso.Position + Vector3.new(math.random(-7,7),0,math.random(-7,7)) 
	end,
	sits = function(Character) 
		Character.Humanoid.Sit = true 
	end,
 	jumps = function(Character)
		Character.Humanoid.Jump = true
	end,
	dies = function(Character)
		Character.Humanoid.PlatformStand = true 
	end,
}
--]]
local cache = require(game.ServerScriptService.ProfileCache)

local customs = {
	["Baton"] = "Takes out tool from utility belt",
	["Handcuffs"] = "Takes out tool from utility belt",
	["Taser"] = "Reaches for the side of their leg, grabbing their Taser",
	["Gun"] = {"Reaches for {NAME}","Grabs {NAME} from holster","Quickly pulls out {NAME}"}
}

function createRP(head,text,timer)
	if head:FindFirstChild("Emote") then
		head.Emote:Destroy()
	end
	local gui = script.Emote:Clone()
	
	gui.MainFrame.rank.Text = "[RP]: **"..	string.sub(text,1,80).."**"
	gui.Parent = head
			--[[
			for i,v in pairs(Emote_Commands_Function) do
				if string.lower(msg) == "/me "..string.lower(i) then
					Emote_Commands_Function[string.lower(i)](Player.Character)
				end
			end
			--]]
	wait(timer)
	if gui then
		gui:Destroy()
	end
end

local spitDb = {}

PlayersService.PlayerAdded:Connect(function(Player)
	Player.Chatted:Connect(function(msg,Targ)
		local first = string.sub(msg, 1,3)
		if string.lower(msg) == "/spit" or string.lower(msg) == "/spits" or string.lower(msg) == "/e spits" or string.lower(msg) == "/e spit" or string.lower(msg) == "/me spit" or string.lower(msg) == "/me spits" then
			if spitDb[Player] then return end
			spitDb[Player] = true
			delay(2,function()
				spitDb[Player] = nil
			end)
			
			local sound = script.Emotes.Spit.Sound:Clone()
			sound.Parent = Player.Character.Head
			sound:Play()
			game.Debris:AddItem(sound,sound.TimeLength)
			
			local animation = Player.Character.Humanoid:LoadAnimation(script.Emotes.Spit.Animation)
			animation:Play()
		end
		if string.lower(first) == "/me" and Player.Character:FindFirstChild('Humanoid') and Player.Character:FindFirstChild('Humanoid').Health ~= 0 then
			local FilteredText = ChatService:FilterStringAsync(msg, Player, Player)
			if FilteredText == "" then return end
			createRP(Player.Character.Head,string.sub(FilteredText,5,80),7)
		end
	end)
	Player.CharacterAdded:Connect(function(c)
		c.ChildAdded:Connect(function(t)
			if t:IsA("Tool") then
				--	print(cache[Player].Data.autoRP)
				if cache[Player].Data.autoRP == true then
					if customs[t.Name] then
						createRP(Player.Character.Head,customs[t.Name],4.5)
					elseif t:FindFirstChild("GunScript_Server") and t.Name ~= "RiotShield" then
						createRP(Player.Character.Head,string.gsub(customs["Gun"][math.random(1,#customs["Gun"])],"{NAME}",t.Name),4.5)
					end
				end
			end
		end)	
	end)
end)