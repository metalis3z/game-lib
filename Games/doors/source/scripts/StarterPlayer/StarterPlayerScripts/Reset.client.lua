-- Decompiled with the Synapse X Luau decompiler.

while true do
	local v1 = pcall(function()
		game.StarterGui:SetCore("BadgesNotificationsActive", false);
		game.StarterGui:SetCore("ResetButtonCallback", false);
	end);
	wait(0.1);
	if v1 then
		break;
	end;
end;
