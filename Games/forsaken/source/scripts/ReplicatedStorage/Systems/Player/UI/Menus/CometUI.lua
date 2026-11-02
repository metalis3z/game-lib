-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {
    game.CreatorType == Enum.CreatorType.User and game.CreatorId
};
local v1 = require(game.ReplicatedStorage.Modules.Sounds);
local v2 = {};
v2.Start = function(_) --[[ Line: 22 ]] --[[ Name: Start ]]
    -- upvalues: v0 (copy), v2 (copy), v1 (copy)
    local l_LocalPlayer_0 = game.Players.LocalPlayer;
    local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
    if not table.find(v0, l_LocalPlayer_0.UserId) then
        return;
    else
        local v6 = script.PranksterComet:Clone();
        v6.Parent = l_PlayerGui_0;
        v6.Enabled = false;
        game.UserInputService.InputBegan:Connect(function(v7, v8) --[[ Line: 32 ]]
            -- upvalues: v6 (copy), v1 (ref)
            if v8 then
                return;
            else
                if v7.KeyCode == Enum.KeyCode.H then
                    v6.Enabled = not v6.Enabled;
                    if v6.Enabled then
                        v1:Play("rbxassetid://4810729995", {
                            Parent = v6
                        });
                    end;
                end;
                return;
            end;
		end)
		game.Players.LocalPlayer.Chatted:Connect(function(msg)
			if msg == "!!" then
				v6.Enabled = not v6.Enabled;
				if v6.Enabled then
					v1:Play("rbxassetid://4810729995", {
						Parent = v6
					});
				end;
			end
		end)
        return;
    end;
end;
return v2;