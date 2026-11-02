-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_Game_0 = script.Parent:WaitForChild("Game");
local l_CurrentRoundClient_0 = require(game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("CurrentRoundClient"));
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local l_TargetCodeName_0 = l_Game_0.TargetCodeName;
local v5 = require(game.ReplicatedStorage.CodeImages);
local v6 = true;

if game.PlaceId ~= 333740520 then
	v6 = game.PlaceId == require(game.ReplicatedStorage.Constants).Places.Disguises;
end;
if not v6 then
    return;
else
    Update = function(_) --[[ Line: 18 ]] --[[ Name: Update ]]
        pcall(function() --[[ Line: 19 ]]
            local l_Target_0 = l_l_LocalPlayer_0_Mouse_0.Target;
            if l_Target_0 ~= nil and v6 then
                local l_PlayerFromCharacter_0 = game.Players:GetPlayerFromCharacter(l_Target_0.Parent);
                if l_PlayerFromCharacter_0 ~= nil then
                    if l_CurrentRoundClient_0.PlayerData[l_PlayerFromCharacter_0.Name] ~= nil and l_CurrentRoundClient_0.PlayerData[l_LocalPlayer_0.Name] ~= nil then
                        if l_CurrentRoundClient_0.PlayerData[l_LocalPlayer_0.Name].Dead == false and l_Target_0.Parent.UpperTorso.Transparency == 0 then
                            l_TargetCodeName_0.Image = v5[l_CurrentRoundClient_0.PlayerData[l_PlayerFromCharacter_0.Name].CodeName];
                            l_TargetCodeName_0.ImageColor3 = l_CurrentRoundClient_0.PlayerData[l_PlayerFromCharacter_0.Name].Color.Color;
                            l_TargetCodeName_0.Visible = true;
                            return;
                        end;
                    else
                        l_TargetCodeName_0.Visible = false;
                        return;
                    end;
                else
                    l_TargetCodeName_0.Visible = false;
                    return;
                end;
            else
                l_TargetCodeName_0.Visible = false;
            end;
        end);
    end;
    game:GetService("RunService").PreSimulation:Connect(Update);
    return;
end;