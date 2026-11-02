local tool = script.Parent
local used = false

local Ammo = math.huge

tool.Activated:Connect(function()
	if used then return end
	used = true
	
	local player = game.Players:GetPlayerFromCharacter(tool.Parent)
	if player then
		
		--local snd = script.Sound:Clone()
		--snd.Parent = player.Character.PrimaryPart
		--snd:Play()
		--game.Debris:AddItem(snd,snd.TimeLength)
		
		local gunInfo = require(game.ServerScriptService.GunStuff.GunsAmmo)
		local dones = 0

		for Index,Gun in pairs(player.Backpack:GetChildren()) do
			
			if gunInfo[Gun.Name] == tool.Name then
				local GunScript = Gun:FindFirstChild("GunScript_Server")
				local Module = Gun:FindFirstChild("Setting")
				if GunScript and Module then
					local	Module = require(Module)
					if GunScript.Ammo.Value < Module.MaxAmmo and Module.LimitedAmmoEnabled then
						local ChangedAmmo = (Ammo == math.huge or GunScript.Ammo.Value+Ammo >= Module.Ammo) and Module.Ammo or (GunScript.Ammo.Value + Ammo)
						GunScript.Ammo.Value = ChangedAmmo
						GunScript.ChangeMagAndAmmo:FireClient(player,Module.AmmoPerMag,ChangedAmmo)
						dones += 1
					end
				end
			end
			
		end
		
		local extra = "s"
		
		if dones == 1 then
			extra = ""
		end
		
		tool.Handle.Sound:Play()
		
		game.ReplicatedStorage.server:FireClient(player,"lmsg","Refilled "..dones.." gun"..extra..".")
		player.Character:FindFirstChild"Humanoid":UnequipTools()
		
		wait()
		
		
		print("GAVE AMMO")
		tool:Destroy()
	end
end)