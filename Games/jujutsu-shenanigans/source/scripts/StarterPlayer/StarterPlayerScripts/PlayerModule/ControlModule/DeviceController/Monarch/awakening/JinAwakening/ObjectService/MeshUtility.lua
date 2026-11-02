-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
v0.__index = v0;
local _ = game:GetService("ReplicatedStorage");
local v2 = require(script.Presets);
local _ = require(script.Parent.Tweening);
v0.new = function(v4) --[[ Line: 9 ]] --[[ Name: new ]]
    local v5 = setmetatable({}, v0);
    v5.Object = v4.Object;
    return v5;
end;
v0.PlayPreset = function(_, v7, ...) --[[ Line: 15 ]] --[[ Name: PlayPreset ]]
    v2[v7](...);
end;
v0.PlayFlipbook = function(v8, v9) --[[ Line: 19 ]] --[[ Name: PlayFlipbook ]]
    local v10 = 1 / v9;
    for _, v12 in pairs(v8.Object:GetDescendants()) do
        if v12.Name == "Flip" and v12:IsA("Folder") then
            local l_Parent_0 = v12.Parent;
            task.spawn(function() --[[ Line: 26 ]]
                for v14 = 1, #v12:GetChildren() - 1 do
                    l_Parent_0.Mesh.TextureId = v12:FindFirstChild(v14).Texture;
                    task.wait(v10);
                end;
                l_Parent_0:Destroy();
            end);
        end;
    end;
end;
return v0;