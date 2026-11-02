-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("TweenService");
local _ = game:GetService("RunService");
local _ = game:GetService("Lighting");
local _ = game:GetService("Players");
local _ = require(l_ReplicatedStorage_0.Shared.EventTypes);
local v6 = {};
local _ = require(l_ReplicatedStorage_0.Controllers.AnimalController);
local v8 = require(l_ReplicatedStorage_0.Controllers.SoundController);
local _ = require(l_ReplicatedStorage_0.Controllers.EventController);
local v10 = require(l_ReplicatedStorage_0.Controllers.CycleController);
local v11 = require(l_ReplicatedStorage_0.Packages.Trove);
local _ = require(l_ReplicatedStorage_0.Packages.Net);
local v13 = require(l_ReplicatedStorage_0.Shared.VFX);
local _ = script.Name;
local l_Rainbow_0 = workspace.Events.Rainbow;
local v16 = v11.new();
v6.OnStart = function(_) --[[ Line: 25 ]] --[[ Name: OnStart ]]
    -- upvalues: v10 (copy), v8 (copy), v13 (copy), l_Rainbow_0 (copy), v16 (copy)
    v10:Update();
    v8:UpdateOST();
    v13.emit(l_Rainbow_0.Emit);
    v16:Add(task.spawn(function() --[[ Line: 31 ]]
        -- upvalues: v8 (ref), l_Rainbow_0 (ref)
        v8:PlaySound("Sounds.Sfx.RainbowActivatedEffect", l_Rainbow_0.SoundParts.RainbowActivatedEffect.Position);
    end));
    v16:Add(task.spawn(function() --[[ Line: 35 ]]
        -- upvalues: v8 (ref), l_Rainbow_0 (ref)
        v8:PlaySound("Sounds.Sfx.RainbowMachineEnabled", l_Rainbow_0.SoundParts.RainbowMachineEnabled.Position);
    end));
    v16:Add(task.spawn(function() --[[ Line: 39 ]]
        -- upvalues: l_Rainbow_0 (ref)
        local v18 = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1), 
            NumberSequenceKeypoint.new(1, 1)
        });
        local l_Children_0 = l_Rainbow_0.Enabled.RainbowMain.RainbowHandle.Wiggler.Attachment3:GetChildren();
        for _, v21 in l_Children_0 do
            v21.Transparency = v18;
            v21.Enabled = true;
        end;
        local l_workspace_ServerTimeNow_0 = workspace:GetServerTimeNow();
        while true do
            local l_workspace_ServerTimeNow_1 = workspace:GetServerTimeNow();
            local v24 = (l_workspace_ServerTimeNow_1 - l_workspace_ServerTimeNow_0) % 3.5 / 3.5;
            v18 = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1), 
                NumberSequenceKeypoint.new(1 - v24, 1), 
                NumberSequenceKeypoint.new(1, 0)
            });
            if l_workspace_ServerTimeNow_1 - l_workspace_ServerTimeNow_0 < 3.5 then
                for _, v26 in l_Children_0 do
                    v26.Transparency = v18;
                end;
                task.wait();
            else
                break;
            end;
        end;
        for _, v28 in l_Children_0 do
            v28.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0), 
                NumberSequenceKeypoint.new(1, 0)
            });
        end;
    end));
    v13.enable(l_Rainbow_0.Enabled);
    v16:Add(function() --[[ Line: 82 ]]
        -- upvalues: v13 (ref), l_Rainbow_0 (ref)
        v13.disable(l_Rainbow_0.Enabled);
    end);
end;
v6.OnStop = function(_) --[[ Line: 87 ]] --[[ Name: OnStop ]]
    -- upvalues: v16 (copy)
    v16:Destroy();
end;
v6.OnLoad = function(_) --[[ Line: 91 ]] --[[ Name: OnLoad ]]

end;
return v6;