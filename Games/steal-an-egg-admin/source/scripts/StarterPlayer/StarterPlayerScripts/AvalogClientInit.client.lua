-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = game:GetService("Workspace"):WaitForChild("Avalog", 30)

if v1 then
    local v2 = v1:WaitForChild("Avalog", 10)
    if not (v2 and v2:IsA("ModuleScript")) then
        warn("[AvalogClientInit] Avalog ModuleScript not found")
    else
        local v3, v4 = pcall(require, v2)
        if v3 and type(v4) == "table" then
            local v5 = v1:FindFirstChild("EasyLoader") and v1.EasyLoader:FindFirstChild("Config")
            if v5 then
                local v6, v7 = pcall(require, v5)
                if v6 and type(v7) == "table" then
                    pcall(function() -- line 32 | captures: v4, v7
                        v4.Config:Update(v7)
                    end)
                end
            end
            local v8, v9 = pcall(function() -- line 37 | captures: v4
                v4:Start()
            end)
            if v8 then
                print("[AvalogClientInit] Avalog ready")
            else
                warn("[AvalogClientInit] Avalog:Start() failed: " .. tostring(v9))
            end
        else
            warn("[AvalogClientInit] Failed to require Avalog: " .. tostring(v4))
        end
    end
else
    warn("[AvalogClientInit] Avalog not found in Workspace")
end
