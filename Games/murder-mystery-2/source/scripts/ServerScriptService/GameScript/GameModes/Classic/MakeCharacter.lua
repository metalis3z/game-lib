
local WeldHat = require(script.WeldHat);
local PassFaces = require(game.ServerStorage.Faces)
local Data = require(game.ServerScriptService.GameScript.DataModule);

local Module = function(Player,Color,RoleName,Map,CodeName)
	
	local OwnsAsset = false;
	if not (string.sub(Player.Name,1,6) == "Guest " or string.sub(Player.Name,1,6) == "Player" ) then
		pcall(function()
			OwnsAsset = (game:GetService("MarketplaceService"):PlayerOwnsAsset(Player,143544775) or game:GetService("MarketplaceService"):PlayerOwnsAsset(Player,237848679))
		end)
	end;
	
	game.ReplicatedStorage.RoleSelect:FireClient(Player,RoleName,Color,CodeName,_G.ServerSettings.LockFirstPerson,"Classic");
	
	if _G.ServerSettings.Disguises == true then
		pcall(function()
		
			local NewColors = script.Colors:Clone();
			NewColors.LeftFoot = Color;
			NewColors.LeftHand = Color;
			NewColors.LeftLowerArm = Color;
			NewColors.LeftLowerLeg = Color;
			NewColors.LeftUpperArm = Color;
			NewColors.LeftUpperLeg = Color;
			NewColors.LowerTorso = Color;
			NewColors.RightFoot = Color;
			NewColors.RightHand = Color;
			NewColors.RightLowerArm = Color;
			NewColors.RightLowerLeg = Color;
			NewColors.RightUpperArm = Color;
			NewColors.UpperTorso = Color;
			NewColors.RightUpperLeg = Color;
			NewColors.Parent = Player.Character;	
			
			local Hair = game.ServerStorage.Hair:GetChildren()[math.random(1,#game.ServerStorage.Hair:GetChildren())];
			local Character = Player.Character;		
			WeldHat(Hair:Clone(),Character,Hair);	
			local GameMode = require(script.Parent);
			local Outfits;
			if GameMode.Outfits == "Map" then
				Outfits = game.ServerStorage.Maps[Map.Name].Outfits
			else
				Outfits = GameMode.OutfitFolder;
			end
			
			local Outfit = Outfits:GetChildren()[math.random(1,#Outfits:GetChildren())];
			Outfit.Shirt:Clone().Parent = Player.Character;
			Outfit.Pants:Clone().Parent = Player.Character;	
			
			if (math.random(1,2) == 1) then
				local Accessory = Outfit.Accessories:GetChildren()[math.random(1,#Outfit.Accessories:GetChildren())];
				Accessory.Handle.Anchored = false;
				WeldHat(Accessory:Clone(),Character,Accessory);
			end
			
			pcall(function()
				Player.Character.Head.face.Texture = "rbxasset://textures/face.png";
				
				if OwnsAsset then
					local nFace = math.random(1,#PassFaces);
					local Face = game:GetService("InsertService"):LoadAsset(PassFaces[nFace])
					local Texture = Face:GetChildren()[1].Texture
					Player.Character.Head.face.Texture = Texture
					Face:Destroy()		
				end
				Player.Character.KnifeDisplay:Destroy();
				Player.Character.GunDisplay:Destroy();
			end);
		end);
	end;
end

return Module;
