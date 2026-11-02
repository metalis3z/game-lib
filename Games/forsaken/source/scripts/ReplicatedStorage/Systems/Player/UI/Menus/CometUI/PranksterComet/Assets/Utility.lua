-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_Players_0 = game:GetService("Players");
local l_Main_0 = script.Parent.Parent.Main;
local l_Assets_0 = script.Parent.Parent.Assets;
local _ = l_Main_0.Innings;
local l_Segments_0 = l_Main_0.Segments;
local v6 = require(game.ReplicatedStorage.Modules.Network);
v0.ToVector3 = function(_, v8) --[[ Line: 12 ]] --[[ Name: ToVector3 ]]
    local v9 = {};
    v8:gsub("%d+", function(v10) --[[ Line: 14 ]]
        -- upvalues: v9 (copy)
        table.insert(v9, (tonumber(v10)));
    end);
    if #v9 ~= 3 then
        warn("invalid vector3");
        return nil;
    else
        return (Vector3.new(v9[1], v9[2], v9[3]));
    end;
end;
v0.GetPlayersFromSelection = function(_) --[[ Line: 21 ]] --[[ Name: GetPlayersFromSelection ]]
    -- upvalues: l_Segments_0 (copy), l_Assets_0 (copy), l_Players_0 (copy)
    local l_SelectPlayer_0 = l_Segments_0.SelectPlayer;
    local l_Mode_0 = require(l_Assets_0.Segments.SelectPlayer).Mode;
    local l_Text_0 = l_SelectPlayer_0.Parameter.Text;
    if l_Mode_0 == "All" then
        return l_Players_0:GetPlayers();
    elseif l_Mode_0 == "Random" then
        local l_l_Players_0_Players_0 = l_Players_0:GetPlayers();
        local v16 = {};
        for _ = 1, tonumber(l_Text_0) do
            if next(l_l_Players_0_Players_0) then
                local v18 = math.random(1, #l_l_Players_0_Players_0);
                table.insert(v16, l_l_Players_0_Players_0[v18]);
                table.remove(l_l_Players_0_Players_0, v18);
            else
                break;
            end;
        end;
        return v16;
    elseif l_Mode_0 == "Player" then
        return {
            l_Players_0:FindFirstChild(l_Text_0)
        };
    elseif l_Mode_0 == "Team" then
        local v19 = {};
        for _, v21 in ipairs(l_Players_0:GetPlayers()) do
            local l_Character_0 = v21.Character;
            if l_Character_0 and l_Character_0.Parent.Name == l_Text_0 then
                table.insert(v19, v21);
            end;
        end;
        return v19;
    else
        return;
    end;
end;
v0.Fire = function(_, v24) --[[ Line: 57 ]] --[[ Name: Fire ]]
    -- upvalues: v0 (copy), v6 (copy)
    v24.CommandName = v24.CommandName or v0.SelectedModule;
	v6:FireServerConnection("Starman", "REMOTE_EVENT", v24);
end;
v0.OffColor = Color3.new(1, 0.164706, 0.164706);
v0.OnColor = Color3.new(0.117647, 1, 0.25098);
v0.SelectedModule = "KillPlayer";
return v0;