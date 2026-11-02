--[[
    Written by: Nextix (ne_tix)
    Date: 3/29/2026
    
    Additional Information:
    This module is used as an AntiCheat for the player movement, flagging each weird movement the player might do.
    
    Method:
    This module is called by the module above. (CharacterManager)
]]

-- <- Private Variables -> --
local Movements = {
	LastData = {},
	MaxPosDelta = 35,
	DesyncTimeout = 3
}

-- <- Modules -> --
local AntiCheat = require('../../General/AntiCheat');

-- <- Private Functions -> --
local function IsFiniteVector3(Vector: Vector3)
	return typeof(Vector) == "Vector3" and Vector.X == Vector.X and Vector.Y == Vector.Y and Vector.Z == Vector.Z and math.abs(Vector.X) < 1e6 and math.abs(Vector.Y) < 1e6 and math.abs(Vector.Z) < 1e6
end

local function IsFiniteCFrame(Cframe: CFrame)
	return typeof(Cframe) == 'CFrame' and IsFiniteVector3(Cframe.Position);
end

-- // Try to readjust the current player position to the last one.
local function TryToSetOldPos(Player: Player, Character: Model): ()
	local OldPlayerData = Movements.LastData[Player]
	if not OldPlayerData then
		return
	end

	local LastCFrame = OldPlayerData.CFrame
	if not LastCFrame then
		return
	end

	Character:PivotTo(LastCFrame);
end

-- <- Public Function -> --
return { -- // Incase I add another function to this later on.
	MovementBackend = function(Player: Player, NewCFrame: CFrame, RequestTime: number, Character: Model?): ()
		local ServerTime = workspace:GetServerTimeNow();
		
		if not Player:GetAttribute('LOADED') then
			return
		end
		
		if Player:GetAttribute('FORCED_PLACEMENT') then
			Movements.LastData[Player] = {
				CFrame = NewCFrame,
				Time = ServerTime,
			}
			
			return
		end
		
		local PlayerCharacter = Character
		if not PlayerCharacter then
			return
		end
		
		if PlayerCharacter:GetAttribute('Team') == 'Lobby' then
			return
		end
		
		local Humanoid = PlayerCharacter:FindFirstChildOfClass('Humanoid');
		if not Humanoid then
			return
		end

		local PrimaryPart = PlayerCharacter.PrimaryPart
		if not PrimaryPart then
			return
		end

		if Humanoid.Health <= 0 then
			return
		end

		if not IsFiniteCFrame(NewCFrame) then		
			return
		end

		if math.abs(ServerTime - RequestTime) > Movements.DesyncTimeout then
			return
		end

		local PreviousData = Movements.LastData[Player]
		if PreviousData then
			local Delta = (NewCFrame.Position - PreviousData.CFrame.Position).Magnitude
			if Delta > Movements.MaxPosDelta then
				TryToSetOldPos(Player, Character);
				
				AntiCheat.FlagPlayer(Player, 'Moved too quickly.');

				return
			end
		end

		Movements.LastData[Player] = {
			CFrame = NewCFrame,
			Time = ServerTime,
		}
	end
}