-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local v0 = require(script:FindFirstAncestor("HallucinationClass"));
local v1 = {};
v1.__index = v1;
setmetatable(v1, v0);
v1.new = function(...) --[[ Line: 12 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy), v1 (copy)
    return (setmetatable(v0.new(...), v1));
end;
v1.Init = function(v2) --[[ Line: 18 ]] --[[ Name: Init ]]
    local _ = v2.Gui.RoundTimer;
    v2.FakeText = v2.Gui.RoundTimer.Main.Time:Clone();
    v2.FakeText.Parent = v2.Gui.RoundTimer.Main;
    v2.Gui.RoundTimer.Main.Time.Visible = false;
    local function _(v4) --[[ Line: 26 ]] --[[ Name: changeRoundTimerText ]]
        -- upvalues: v2 (copy)
        local v5 = v4 or math.random(1, 300);
        local v6 = v5 // 60;
        v5 = v5 % 60;
        if v5 < 10 then
            v5 = ("0%*"):format((tostring(v5)));
        end;
        v2.FakeText.Text = ("%*:%*"):format(v6, v5);
        return v5;
    end;
    task.spawn(function() --[[ Line: 41 ]]
        -- upvalues: v2 (copy)
        while v2 and v2.Running and v2.FakeText do
            local v8 = math.random(1, 300);
            local v9 = v8 // 60;
            v8 = v8 % 60;
            if v8 < 10 then
                v8 = ("0%*"):format((tostring(v8)));
            end;
            v2.FakeText.Text = ("%*:%*"):format(v9, v8);
            local l_v8_0 = v8;
            for v11 = 1, math.random(4, 9) do
                task.wait(1);
                if v2 and v2.Running and v2.FakeText then
                    local v12 = math.clamp(l_v8_0 - v11, 1, 300) or math.random(1, 300);
                    local v13 = v12 // 60;
                    v12 = v12 % 60;
                    if v12 < 10 then
                        v12 = ("0%*"):format((tostring(v12)));
                    end;
                    v2.FakeText.Text = ("%*:%*"):format(v13, v12);
                else
                    break;
                end;
            end;
        end;
    end);
end;
v1.Destroy = function(v14) --[[ Line: 57 ]] --[[ Name: Destroy ]]
    v14.Running = false;
    v14.FakeText:Destroy();
    v14.Gui.RoundTimer.Main.Time.Visible = true;
    v14:Clean();
end;
return v1;