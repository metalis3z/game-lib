-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-17 20:44:09
-- Luau version 6, Types version 3
-- Time taken: 0.002354 seconds

Tool = script.Parent -- Setting global
Handle = Tool:WaitForChild("Handle") -- Setting global
Players = game:GetService("Players") -- Setting global
RunService = game:GetService("RunService") -- Setting global
ServerControl = Tool:WaitForChild("ServerControl") -- Setting global
ClientControl = Tool:WaitForChild("ClientControl") -- Setting global
ToolEquipped = false -- Setting global
function CheckIfAlive() -- Line 14
	if Character and Character.Parent and Humanoid and Humanoid.Parent and 0 < Humanoid.Health and Player and Player.Parent then
		return true
	end
	return false
end
function Equipped(arg1) -- Line 18
	Character = Tool.Parent -- Setting global
	Player = Players:GetPlayerFromCharacter(Character) -- Setting global
	Humanoid = Character:FindFirstChild("Humanoid") -- Setting global
	if not CheckIfAlive() then
	else
		PlayerMouse = Player:GetMouse() -- Setting global
		ToolEquipped = true -- Setting global
	end
end
function Unequipped() -- Line 29
	ToolEquipped = false -- Setting global
end
function InvokeServer(arg1, arg2) -- Line 33
	local var1_upvw
	pcall(function() -- Line 35
		--[[ Upvalues[3]:
			[1]: var1_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: arg2 (readonly)
		]]
		var1_upvw = ServerControl:InvokeServer(arg1, arg2)
	end)
	return var1_upvw
end
function OnClientInvoke(arg1, arg2) -- Line 41
	if not ToolEquipped or not CheckIfAlive() or not arg1 then
	elseif arg1 == "MouseData" then
		return {
			Position = PlayerMouse.Hit.p;
			Target = PlayerMouse.Target;
		}
	end
end
ClientControl.OnClientInvoke = OnClientInvoke
Tool.Equipped:connect(Equipped)
Tool.Unequipped:connect(Unequipped)