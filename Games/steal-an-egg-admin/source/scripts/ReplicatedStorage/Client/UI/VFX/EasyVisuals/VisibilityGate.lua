-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {
    ScreenGui = "Enabled",
    BillboardGui = "Enabled",
    SurfaceGui = "Enabled"
}

function v1.Watch(v3, v4, v5) -- line 8 | captures: v2
    local v6 = {}
    if not (typeof(v3) == "Instance" and v3:IsA("GuiBase")) then
        return nil
    end
    local v7 = {}
    local v8

    local function shiftHidden(v9) -- line 15 | captures: v8, v4, v5
        local v10 = v8
        v10.hidden += v9
        if v8.hidden <= 0 or v8.isMuted then
            if v8.hidden == 0 and v8.isMuted then
                v8.isMuted = false
                v5()
            end
        else
            v8.isMuted = true
            v4()
        end
    end

    local v11 = {
        hidden = 0,
        isMuted = false,
        links = v7
    }

    function v11.Destroy() -- line 39 | captures: v8, v7
        for v12, v13 in ipairs(v7) do
            v13:Disconnect()
        end
        table.clear(v8)
    end

    v8 = v11
    local v14 = v3
    local v15 = v6
    local v16
    while true do
        local v17
        if v14 and v14:IsA("GuiBase") then
            v17 = v2[v14.ClassName]
            v15[1] = v17
            if not v17 then
                if v14:IsA("GuiObject") then
                    v15[1] = "Visible"
                    v17 = "Visible"
                else
                    v15[1] = nil
                    v17 = nil
                end
            end
        else
            break
        end
        if v17 then
            if not v14[v17] then
                local v18 = v8.hidden + 1
                v8.hidden = v18
                if v8.hidden <= 0 then
                    if v8.hidden == 0 and v8.isMuted then
                        v8.isMuted = false
                        v5()
                    end
                elseif not v8.isMuted then
                    v8.isMuted = true
                    v4()
                end
            end
            local v19 = #v7 + 1
            local v20 = v14:GetPropertyChangedSignal(v17)
            v16 = v14
            v7[v19] = v20:Connect(((function(v21)
                return function() -- line 75 | captures: v21, v8, v4, v5, v16
                    local v22 = if v16[v21[1]] then -1 else 1
                    local v23 = v8
                    v23.hidden += v22
                    if v8.hidden <= 0 or v8.isMuted then
                        if v8.hidden == 0 and v8.isMuted then
                            v8.isMuted = false
                            v5()
                        end
                    else
                        v8.isMuted = true
                        v4()
                    end
                end
            end)(v15)))
        end
        v14 = v14.Parent
        local v24 = v15[1]
        local v25 = {}
        v25[1] = v24
        v15 = v25
    end
    return v8
end

return table.freeze(v1)
