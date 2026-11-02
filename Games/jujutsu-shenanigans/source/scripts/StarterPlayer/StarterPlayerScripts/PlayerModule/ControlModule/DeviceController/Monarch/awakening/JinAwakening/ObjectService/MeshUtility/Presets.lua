-- Saved by UniversalSynSaveInstance https://discord.gg/wx4ThpAsmw

local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v2 = require(l_ReplicatedStorage_0.RepMod.ObjectService.Tweening);
v0.JumpShard = function(v3, v4, v5) --[[ Line: 6 ]] --[[ Name: JumpShard ]]
    v2.TweenProperty(v3, 0.15, "Cubic", "Out", {
        Size = Vector3.new(0, v4, 0), 
        Position = v3.Position + Vector3.new(0, v5, 0)
    }):Play();
end;
v0.FadingSlash = function(v6, v7, v8, v9, v10, v11) --[[ Line: 10 ]] --[[ Name: FadingSlash ]]
    local v12 = math.abs(v8 / 180);
    local v13 = v8 < 0 and -180 or 180;
    if v12 > 1 then
        local v14 = {};
        for v15 = 1, v12 do
            v14[v15] = v2.TweenProperty(v6, v7 / v12, "Cubic", "Out", {
                CFrame = v6.CFrame * CFrame.Angles(0, math.rad(v13), 0)
            });
        end;
        v2.TweenSequence(v14);
    else
        v2.TweenProperty(v6, v7, "Cubic", "Out", {
            CFrame = v6.CFrame * CFrame.Angles(0, math.rad(v8), 0)
        }):Play();
    end;
    if v11 == "Size" then
        v2.TweenProperty(v6, v7, "Cubic", "Out", {
            Size = v6.Size * v9
        }):Play();
    else
        v2.TweenProperty(v6.Mesh, v7, "Cubic", "Out", {
            Scale = v6.Mesh.Scale * v9
        }):Play();
    end;
    v2.TweenProperty(v6, v7, "Cubic", "Out", {
        Transparency = v10
    }):Play();
    task.delay(v7, function() --[[ Line: 34 ]]
        v6:Destroy();
    end);
end;
v0.ShockwaveV1 = function(v16, v17, v18, v19, v20, v21, v22) --[[ Line: 39 ]] --[[ Name: ShockwaveV1 ]]
    v2.TweenProperty(v16, v17, "Cubic", "Out", {
        Position = v19
    }):Play();
    if v22 == "Size" then
        v2.TweenProperty(v16, v17, "Cubic", "Out", {
            Size = v16.Size - Vector3.new(v20.X, v20.Y, v20.Z)
        }):Play();
    else
        v2.TweenProperty(v16.Mesh, v17, "Cubic", "Out", {
            Scale = v16.Mesh.Scale - Vector3.new(v20.X, v20.Y, v20.Z)
        }):Play();
    end;
    task.delay(v17 - 0.02, function() --[[ Line: 49 ]]
        if v22 == "Size" then
            v2.TweenProperty(v16, v18, "Cubic", "Out", {
                Size = v16.Size + Vector3.new(v21.X, v21.Y, v21.Z)
            }):Play();
        else
            v2.TweenProperty(v16.Mesh, v18, "Cubic", "Out", {
                Scale = v16.Mesh.Scale + Vector3.new(v21.X, v21.Y, v21.Z)
            }):Play();
        end;
        v2.TweenProperty(v16, v18, "Cubic", "Out", {
            Transparency = 1
        }):Play();
        task.delay(v18, function() --[[ Line: 58 ]]
            v16:Destroy();
        end);
    end);
end;
return v0;