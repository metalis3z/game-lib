-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://sitetest1.lua.expert

local v1 = {}
local v2 = {}
local v3 = {}
local iconsDictionary
local CurrentCamera = workspace.CurrentCamera
local v4 = {}
local v5 = {}
local Utility = require(script.Parent.Parent.Utility)
local v6 = false
local v7 = false
local v8

function v1.start(v9) -- line 17 | captures: iconsDictionary, v6, v8, v1, v2, CurrentCamera, Utility
    v8 = v9
    iconsDictionary = v8.iconsDictionary
    local v10
    for v11, v12 in pairs(v8.container) do
        if v10 == nil and v12.ScreenInsets == Enum.ScreenInsets.TopbarSafeInsets then
            v10 = v12
        end
        for v13, v14 in pairs(v12.Holders:GetChildren()) do
            if v14:GetAttribute("IsAHolder") then
                v2[v14.Name] = v14
            end
        end
    end
    local v15 = false
    local v16 = Utility.createStagger(0.1, function(v17) -- line 32 | captures: v15, v1
        if not v15 then
            return
        end
        if not v17 then
            v1.updateAvailableIcons("Center")
        end
        v1.updateBoundary("Left")
        v1.updateBoundary("Right")
    end)
    task.delay(0.5, function() -- line 42 | captures: v15, v16
        v15 = true
        v16()
    end)
    task.delay(2, function() -- line 46 | captures: v16, v6
        v6 = true
        v16()
    end)
    v8.iconAdded:Connect(v16)
    v8.iconRemoved:Connect(v16)
    v8.iconChanged:Connect(v16)
    CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- line 54 | captures: v16
        v16(true)
    end)
    v10:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- line 58 | captures: v16
        v16(true)
    end)
end

local function getWidth(v18, v19) -- line 62
    local widget = v18.widget
    return widget:GetAttribute("TargetWidth") or widget.AbsoluteSize.X
end

v1.getWidth = getWidth

function v1.getAvailableIcons(v20) -- line 70 | captures: v1, v3
    return v3[v20] or v1.updateAvailableIcons(v20)
end

function v1.updateAvailableIcons(v21) -- line 77 | captures: iconsDictionary, v3, v5
    local v22 = {}
    local v23 = 0
    for v24, v25 in pairs(iconsDictionary) do
        local parentIconUID = v25.parentIconUID
        local v26 = not parentIconUID or v5[parentIconUID]
        local v27 = v5[v25.UID]
        if v26 and v25.alignment == v21 and not v27 then
            table.insert(v22, v25)
            v23 += 1
        end
    end
    if v23 <= 0 then
        return {}
    end
    table.sort(v22, function(v28, v29) -- line 97
        local LayoutOrder = v28.widget.LayoutOrder
        local LayoutOrder_2 = v29.widget.LayoutOrder
        local parentIconUID = v28.parentIconUID
        local parentIconUID_2 = v29.parentIconUID
        if parentIconUID == parentIconUID_2 then
            if LayoutOrder < LayoutOrder_2 then
                return true
            end
            if LayoutOrder_2 < LayoutOrder then
                return false
            end
            return v28.widget.AbsolutePosition.X < v29.widget.AbsolutePosition.X
        end
        if parentIconUID_2 then
            return false
        end
        if parentIconUID then
            return true
        end
        return nil
    end)
    v3[v21] = v22
    return v22
end

function v1.getRealXPositions(v30, v31) -- line 123 | captures: v1, v2, Utility
    local v32 = v30 == "Left"
    local v33 = v2[v30]
    local X = v33.AbsolutePosition.X
    local Offset = v33.UIListLayout.Padding.Offset
    if not v32 then
        X += v33.AbsoluteSize.X
    end
    local v34 = {}
    if v32 then
        Utility.reverseTable(v31)
    end
    local v35 = #v31
    for v36 = v35, 1, -1 do
        local v37 = v31[v36]
        local v38 = v1.getWidth(v37)
        if not v32 then
            X -= v38
        end
        v34[v37.UID] = X
        local v39
        if v32 then
            X += v38
            v39 = Offset
        else
            v39 = -Offset
        end
        X += v39
    end
    return v34
end

function v1.updateBoundary(v40) -- line 160 | captures: v6, v7, v8, v1, v2, v4, v5, Utility
    local v41 = v2[v40]
    local UIListLayout = v41.UIListLayout
    local X = v41.AbsolutePosition.X
    local X_2 = v41.AbsoluteSize.X
    local Offset = UIListLayout.Padding.Offset
    local v42 = v1.updateAvailableIcons(v40)
    local v43 = 0
    local v44 = 0
    for v45, v46 in pairs(v42) do
        v43 += v1.getWidth(v46) + UIListLayout.Padding.Offset
        v44 += 1
    end
    if v44 <= 0 then
        return
    end
    local v47 = v40 == "Center"
    local v48 = v40 == "Left"
    local v49 = not v48
    local v50 = v4[v40]
    local v51
    if v50 then
        v51 = v50
    else
        local v52, v53
        if v47 then
            v51 = v50
            v53 = true
        elseif #v42 > 0 then
            if v48 then
                v52 = -9999999
            else
                v52 = 9999999
            end
            v53 = false
        else
            v51 = v50
            v53 = true
        end
        if not v53 then
            v51 = v8.new()
            v51:setImage(6069276526, "Deselected")
            v51:setName("Overflow" .. v40)
            v51:setOrder(v52)
            v51:setAlignment(v40)
            v51:autoDeselect(false)
            v51.isAnOverflow = true
            v51:select("OverflowStart", v51)
            v51:setEnabled(false)
            v4[v40] = v51
            v5[v51.UID] = true
        end
    end
    local v54 = if v40 == "Left" then "Right" else "Left"
    local v55 = v1.updateAvailableIcons(v54)
    local v56 = if v48 then v55[1] else v49 and v55[#v55]
    local v57 = v4[v54]
    local v58 = if v48 then X + X_2 else X
    if v56 then
        local v59 = v1.getRealXPositions(v54, v55)[v56.UID]
        local v60 = v1.getWidth(v56)
        if v48 then
            v58 = v59 - Offset
        else
            v58 = v59 + v60 + Offset
        end
    end
    local v61 = 0
    local v62

    function v62() -- line 231 | captures: v62, v61, v40, Offset, v42, v48, v49, v6, v7, v1
        local Center = v1.getAvailableIcons("Center")
        local v63 = if v48 then 1 else #Center
        local v64 = Center[v63]

        local function secondaryCheck() -- line 240 | captures: v40, v7, v1
            if not v7 then
                v7 = true
                task.delay(3, v1.updateBoundary, v40)
            end
        end

        local v65, v66
        if v64 then
            if v64.hasRelocatedInOverflow then
                v66 = true
            else
                if v48 then
                    v65 = v42[#v42]
                else
                    v65 = v49 and v42[1]
                end
                v66 = false
            end
        else
            v66 = true
        end
        if v66 then
            return
        end
        local X = v64.widget.AbsolutePosition.X
        local X_2 = v65.widget.AbsolutePosition.X
        local v67 = v1.getWidth(v65)
        local v68 = if v48 then X - Offset else X + v1.getWidth(v64) + Offset
        if v48 then
            X_2 += v67
        end
        if v48 then
            if not (X_2 <= v68) then
                if v6 then
                    v64:align("Left")
                    v64.hasRelocatedInOverflow = true
                    v61 += 1
                    if v61 <= 4 then
                        v1.updateAvailableIcons("Center")
                        v62()
                    end
                elseif not v7 then
                    v7 = true
                    task.delay(3, v1.updateBoundary, v40)
                end
            end
        elseif v49 and not (v68 <= X_2) then
            local v69
            if v6 then
                if X_2 < 0 then
                    v69 = true
                else
                    v64:align("Right")
                    v64.hasRelocatedInOverflow = true
                    v61 += 1
                    if v61 <= 4 then
                        v1.updateAvailableIcons("Center")
                        v62()
                    end
                    v69 = false
                end
            else
                v69 = true
            end
            if not v69 then
                return
            end
            if not v7 then
                v7 = true
                task.delay(3, v1.updateBoundary, v40)
            end
        end
    end

    v62()
    if v51 then
        local Menu = v51:getInstance("Menu")
        local v70 = X + X_2
        local v71
        if Menu and v57 then
            local X_3 = v57.widget.AbsolutePosition.X
            local v72 = v1.getWidth(v57)
            local v73 = if v48 then X_3 - Offset else X_3 + v72 + Offset
            local v74 = v57:getInstance("Menu").AbsoluteCanvasSize.X <= Menu.AbsoluteCanvasSize.X
            local v75 = X + X_2 / 2
            local v76 = if v48 then v75 - Offset / 2 else v75 + Offset / 2
            if not v74 then
                v73 = v76
            end
            if v48 then
                v71 = v73 - X
            else
                v71 = v70 - v73
            end
        else
            v71 = X_2
        end
        local v77 = Menu and Menu:GetAttribute("MaxWidth")
        local v78 = Utility.round(v71)
        if Menu and v77 ~= v78 then
            Menu:SetAttribute("MaxWidth", v78)
        end
    end
    local v79 = v1.getRealXPositions(v40, v42)
    local v80 = #v42
    local v81 = false
    for v82 = v80, 1, -1 do
        local v83 = v42[v82]
        local v84 = v1.getWidth(v83)
        local v85 = v79[v83.UID]
        if v48 then
            if v58 <= v85 + v84 then
            end
        elseif v49 and v85 <= v58 then
            v81 = true
        end
    end
    local v86 = #v42
    for v87 = v86, 1, -1 do
        local v88 = v42[v87]
        if not v5[v88.UID] then
            if v81 then
                if not v88.parentIconUID then
                    v88:joinMenu(v51)
                end
            elseif v88.parentIconUID then
                v88:leave()
            end
        end
    end
    if v51.isEnabled ~= v81 then
        v51:setEnabled(v81)
    end
    if v51.isEnabled and not v51.overflowAlreadyOpened then
        v51.overflowAlreadyOpened = true
        v51:select()
    end
end

return v1
