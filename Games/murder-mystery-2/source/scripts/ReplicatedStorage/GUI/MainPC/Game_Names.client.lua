local Player = game.Players.LocalPlayer;
local MainGUI = script.Parent.Game;

local Mouse = Player:GetMouse();
local TargetCodeName = MainGUI.TargetCodeName;
local CodeImages = require(game.ReplicatedStorage.CodeImages);
local PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();

local TestServerID = 13027726810;
local MM2ID = 13085716426;
local HardcoreID = 345345;
local HardcoreTestID = 345345;

local IsHardcore = (game.PlaceId == HardcoreTestID or game.PlaceId == HardcoreID);

function Update()
	pcall(function()
		local MouseTarget = Mouse.Target;
		if MouseTarget ~= nil and IsHardcore then
			local Target = game.Players:GetPlayerFromCharacter(MouseTarget.Parent);
			if Target ~= nil then
				
				if PlayerData[Target.Name] ~= nil and PlayerData[Player.Name] ~= nil then
					if PlayerData[Player.Name]["Dead"] == false and MouseTarget.Parent.Torso.Transparency == 0 then
						TargetCodeName.Image = CodeImages[PlayerData[Target.Name]["CodeName"]];
						TargetCodeName.ImageColor3 = PlayerData[Target.Name]["Color"].Color;
						TargetCodeName.Visible = true;
					end
				else
					TargetCodeName.Visible = false;
				end
			else
				TargetCodeName.Visible = false;
			end
		else	
			TargetCodeName.Visible = false;
		end
	end);
end

Mouse.Move:connect(Update);
Mouse.Idle:connect(Update);

while wait(3) do
	PlayerData = game.ReplicatedStorage.GetPlayerData:InvokeServer();
end