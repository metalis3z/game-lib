-- Reference copy for study. Game: Hiroshima Expressway (hiroshima-expressway)
-- Original: StarterPlayer/StarterPlayerScripts/EchoSound.client.lua
-- What it does: Turns on SoundService.AmbientReverb (ConcertHall) while the player is inside any invisible TunnelArea part, using a cheap box check on Heartbeat and only changing the property when the state flips.

--[[

							                                        
					 .'..'..'..'.              .'..'..'..'. 
					 .ko'xo'xo'xo             .dd'dd'dd'dx. 
					  ,Oc;k:;kc;kc            lk,lk,lk,lk'  
					   cO;:k;:O;:O,          :O;:O;:k;:O;   
					    ok,ok,ok,ok.        ,Oc;Oc,kc,kc    
					    .xd,xd'xd,xd.      .ko,xo'xo,xd.    
					     'kl,kl,kl,ko     .dx,dx'dx,dx.     
					      ;O:;k:;k:;O:    lk,lk,lk,lO'      
					       ck;ck,cO;cO,  ;O::O::O::O:       
					        ok,ox,ox,ol,okl,kl,kl,kl        
					        .xd,xd,xd.,kNd,xd'xd,xd.        
					         'kl,kl;d:ok:,ox'ox,ok.         
					          ;O:;k:.lk, ck,ck;cO,          
					           lk,cc:k:;kO:;k:;O:           
					           .dx.,kl,kXl,kl,ko            
					            .xkkd,dd''xd'xd.            
					             'do.,o. ,o.,o.  
					                   v4
					            VENORA Development
					                  07mca
--]]					             

-- Cache TunnelArea parts on game start
local tunnelAreas = {}
local function cacheTunnelAreas()
	for _, part in ipairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and part.Name == "TunnelArea" then
			part.Transparency = 1
			table.insert(tunnelAreas, part)
		end
	end
end

cacheTunnelAreas()

-- Track player state to avoid unnecessary changes
local player = game.Players.LocalPlayer
local lastState = false

-- Optimized check function
local function checkPlayerInArea()
	local character = player.Character
	if not character then return false end

	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then return false end

	local hrpPosition = humanoidRootPart.Position

	for _, part in ipairs(tunnelAreas) do
		if part:IsDescendantOf(workspace) then -- Ensure part still exists
			local size = part.Size
			local cf = part.CFrame
			-- Simple AABB check is faster than GetTouchingParts
			if (hrpPosition.X > cf.X - size.X/2 and hrpPosition.X < cf.X + size.X/2) and
				(hrpPosition.Y > cf.Y - size.Y/2 and hrpPosition.Y < cf.Y + size.Y/2) and
				(hrpPosition.Z > cf.Z - size.Z/2 and hrpPosition.Z < cf.Z + size.Z/2) then
				return true
			end
		end
	end
	return false
end

-- Use Heartbeat instead of RenderStepped (less frequent)
game:GetService("RunService").Heartbeat:Connect(function()
	local currentState = checkPlayerInArea()
	if currentState ~= lastState then
		lastState = currentState
		game.SoundService.AmbientReverb = currentState and "ConcertHall" or "NoReverb"
	end
end)

-- Optional: Re-cache if new TunnelArea parts are added dynamically
workspace.DescendantAdded:Connect(function(part)
	if part:IsA("BasePart") and part.Name == "TunnelArea" then
		part.Transparency = 1
		table.insert(tunnelAreas, part)
	end
end)

