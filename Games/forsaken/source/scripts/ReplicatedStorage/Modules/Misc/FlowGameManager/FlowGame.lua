-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Debris_0 = game:GetService("Debris");
local v3 = require(game.ReplicatedStorage.Modules.Sounds);
local v4 = require(script.PathFinder);
local v5 = require(script.Generator);
local v6 = require(script.Settings);
local l_defaultButtonColor_0 = v6.defaultButtonColor;
local l_Assets_0 = script.Assets;
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v11 = {
    Line = {
        updown = {
            l_Assets_0.VerticalLine
        }, 
        leftright = {
            l_Assets_0.HorizontalLine
        }, 
        downright = {
            l_Assets_0.HalfLineDown, 
            l_Assets_0.HalfLineRight
        }, 
        downleft = {
            l_Assets_0.HalfLineDown, 
            l_Assets_0.HalfLineLeft
        }, 
        upright = {
            l_Assets_0.HalfLineUp, 
            l_Assets_0.HalfLineRight
        }, 
        upleft = {
            l_Assets_0.HalfLineUp, 
            l_Assets_0.HalfLineLeft
        }, 
        up = {
            l_Assets_0.HalfLineUp
        }, 
        down = {
            l_Assets_0.HalfLineDown
        }, 
        left = {
            l_Assets_0.HalfLineLeft
        }, 
        right = {
            l_Assets_0.HalfLineRight
        }
    }, 
    Circle = {
        up = {
            l_Assets_0.HalfLineUp, 
            l_Assets_0.Circle
        }, 
        down = {
            l_Assets_0.HalfLineDown, 
            l_Assets_0.Circle
        }, 
        left = {
            l_Assets_0.HalfLineLeft, 
            l_Assets_0.Circle
        }, 
        right = {
            l_Assets_0.HalfLineRight, 
            l_Assets_0.Circle
        }, 
        none = {
            l_Assets_0.Circle
        }
    }
};
function getDirection(v12, v13, v14, v15) --[[ Line: 39 ]] --[[ Name: getDirection ]]
    if v14 < v12 then
        return "up";
    elseif v12 < v14 then
        return "down";
    elseif v15 < v13 then
        return "left";
    elseif v13 < v15 then
        return "right";
    else
        return;
    end;
end;
local function v22(v16) --[[ Line: 46 ]] --[[ Name: shuffleTable ]]
    local v17 = table.clone(v16);
    for v18 = #v17, 2, -1 do
        local v19 = math.random(v18);
        local v20 = v17[v19];
        local v21 = v17[v18];
        v17[v18] = v20;
        v17[v19] = v21;
    end;
    return v17;
end;
function isNeighbour(v23, v24, v25, v26) --[[ Line: 55 ]] --[[ Name: isNeighbour ]]
    if v25 == v23 - 1 and v26 == v24 then
        return "up";
    elseif v25 == v23 + 1 and v26 == v24 then
        return "down";
    elseif v25 == v23 and v26 == v24 - 1 then
        return "left";
    elseif v25 == v23 and v26 == v24 + 1 then
        return "right";
    else
        return false;
    end;
end;
function removeAfterCoordinates(v27, v28, v29) --[[ Line: 68 ]] --[[ Name: removeAfterCoordinates ]]
    -- upvalues: v3 (copy)
    local v30 = nil;
    for v31, v32 in ipairs(v27) do
        if v32.row == v28 and v32.col == v29 then
            v30 = v31;
            break;
        end;
    end;
    if v30 then
        for v33 = #v27, v30 + 1, -1 do
            table.remove(v27, v33);
            v3:Play("lineErase");
        end;
    end;
end;
function sameLocation(v34, v35) --[[ Line: 86 ]] --[[ Name: sameLocation ]]
    local l_row_0 = v34.row;
    local l_col_0 = v34.col;
    local l_row_1 = v35.row;
    local l_col_1 = v35.col;
    local v40 = false;
    if l_row_0 == l_row_1 then
        v40 = l_col_0 == l_col_1;
    end;
    return v40;
end;
local function _(v41, v42) --[[ Line: 95 ]] --[[ Name: ColorDifference ]]
    local v43 = v41.R * 255;
    local v44 = v41.G * 255;
    local v45 = v41.B * 255;
    local v46 = v42.R * 255;
    local v47 = v42.G * 255;
    local v48 = v42.B * 255;
    return (math.sqrt((v46 - v43) ^ 2 + (v47 - v44) ^ 2 + (v48 - v45) ^ 2));
end;
local function v67(v50) --[[ Line: 101 ]] --[[ Name: GenerateColor ]]
    local v51 = 0;
    local function v62(v52) --[[ Line: 107 ]] --[[ Name: IsValidColor ]]
        -- upvalues: v51 (ref), v50 (copy)
        local v53 = (v52.R + v52.G + v52.B) / 3;
        if v53 < 0.6 or v53 > 0.8 then
            return false;
        else
            if v51 <= 500 then
                for _, v55 in ipairs(v50) do
                    local v56 = v52.R * 255;
                    local v57 = v52.G * 255;
                    local v58 = v52.B * 255;
                    local v59 = v55.R * 255;
                    local v60 = v55.G * 255;
                    local v61 = v55.B * 255;
                    if math.sqrt((v59 - v56) ^ 2 + (v60 - v57) ^ 2 + (v61 - v58) ^ 2) < 75 then
                        return false;
                    end;
                end;
            end;
            return true;
        end;
    end;
    local v63 = nil;
    repeat
        local v64 = math.random(0, 255);
        local v65 = math.random(0, 255);
        local v66 = math.random(0, 255);
        v63 = Color3.fromRGB(v64, v65, v66);
        v51 = v51 + 1;
    until v62(v63);
    return v63;
end;
local v68 = {};
v68.__index = v68;
v68.new = function(v69, v70, v71) --[[ Line: 141 ]] --[[ Name: new ]]
    -- upvalues: v68 (copy), v6 (copy), v22 (copy)
    local v72 = setmetatable({}, v68);
    v72.id = 0;
    local v73 = v71 or {};
    v73 = setmetatable(table.clone(v73), v6);
    v72.GUI = v69;
    v72.containerFrame = v72.GUI.Container;
    v72.gridHolder = v72.containerFrame.GridHolder;
    v72.gridFrame = v72.gridHolder.Grid;
    v72.gridSize = v70 or v6.DefaultGridSize;
    v72.colors = v22(v6.Colors);
    v72.paths = {};
    v72.targetPairs = {};
    v72.isDrawing = false;
    v72.drawingStart = nil;
    v72.gameEnded = false;
    v72.dragDebounce = {};
    v72.Connections = {};
    v72.Settings = v73;
    v72:Init();
    return v72;
end;
v68.Init = function(v74) --[[ Line: 171 ]] --[[ Name: Init ]]
    -- upvalues: l_Assets_0 (copy), l_UserInputService_0 (copy), v5 (copy), v67 (copy), l_TweenService_0 (copy)
    local v75 = 1 / v74.gridSize;
    v74.gridFrame.UIGridLayout.CellSize = UDim2.fromScale(v75, v75);
    v74.containerFrame.Size = UDim2.fromScale(0, 0);
    v74.containerFrame.Visible = true;
    for v76 = 1, v74.gridSize do
        for v77 = 1, v74.gridSize do
            local v78 = l_Assets_0.CellTemplate:Clone();
            v78.Name = v76 .. "-" .. v77;
            v78.Parent = v74.gridFrame;
            v78.BackgroundTransparency = v74.Settings.ButtonTransparency;
            v78.Button.MouseButton1Down:Connect(function() --[[ Line: 184 ]]
                -- upvalues: v74 (copy), v76 (copy), v77 (copy)
                v74:DragBegin(v76, v77);
            end);
        end;
    end;
    table.insert(v74.Connections, l_UserInputService_0.InputEnded:Connect(function(v79) --[[ Line: 193 ]]
        -- upvalues: v74 (copy)
        if v79.UserInputType == Enum.UserInputType.MouseButton1 or v79.UserInputType == Enum.UserInputType.Touch or v79.KeyCode == Enum.KeyCode.ButtonA then
            v74:DragEnd();
        end;
    end));
    table.insert(v74.Connections, l_UserInputService_0.InputChanged:Connect(function(v80) --[[ Line: 198 ]]
        -- upvalues: v74 (copy)
        if v80.UserInputType == Enum.UserInputType.MouseMovement then
            v74:InputChanged(v80.Position);
        end;
    end));
    table.insert(v74.Connections, l_UserInputService_0.TouchMoved:Connect(function(v81) --[[ Line: 203 ]]
        -- upvalues: v74 (copy)
        v74:InputChanged(v81.Position);
    end));
    local v82, v83, _, v85 = v5(v74.gridSize);
    v74.targetPairs = v82;
    v74.Solution = v83;
    v74.SolutionText = v85;
    for v86 = 1, #v74.targetPairs do
        v74.paths[v86] = {};
        v74.dragDebounce[v86] = 0;
        if not v74.colors[v86] then
            table.insert(v74.colors, (v67(v74.colors)));
        end;
    end;
    v74:updateGui();
    l_TweenService_0:Create(v74.containerFrame, TweenInfo.new(0.45), {
        Size = UDim2.fromScale(0.4, 1)
    }):Play();
end;
v68.DragBeginConsole = function(v87) --[[ Line: 231 ]] --[[ Name: DragBeginConsole ]]
    if require(game.ReplicatedStorage.Modules.Device):GetPlayerDevice() == "Console" then
        task.spawn(function() --[[ Line: 234 ]]
            -- upvalues: v87 (copy)
            while task.wait() and v87.isDrawing and v87.containerFrame.Parent and not v87.gameEnded do
                v87:InputChanged();
            end;
        end);
    end;
end;
v68.DragBegin = function(v88, v89, v90) --[[ Line: 244 ]] --[[ Name: DragBegin ]]
    -- upvalues: v3 (copy)
    if v88.gameEnded then
        return;
    else
        for v91, v92 in ipairs(v88.targetPairs) do
            for _, v94 in ipairs(v92) do
                if v94.row == v89 and v94.col == v90 then
                    if os.clock() - v88.dragDebounce[v91] < 0.25 then
                        return;
                    else
                        v3:Play("dragBegin");
                        v88.isDrawing = true;
                        v88.drawingStart = {
                            row = v89, 
                            col = v90, 
                            color = v91
                        };
                        v88.paths[v91] = {
                            {
                                row = v89, 
                                col = v90
                            }
                        };
                        v88:CircleEffect(v89, v90);
                        v88:CircleEffect(v92[1].row, v92[1].col, true);
                        v88:CircleEffect(v92[2].row, v92[2].col, true);
                        v88:DragBeginConsole();
                        return v88:updateGui();
                    end;
                end;
            end;
        end;
        for v95, v96 in ipairs(v88.paths) do
            for _, v98 in ipairs(v96) do
                if v98.row == v89 and v98.col == v90 then
                    removeAfterCoordinates(v96, v98.row, v98.col);
                    v3:Play("dragBegin");
                    v88.isDrawing = true;
                    v88.drawingStart = {
                        row = v96[1].row, 
                        col = v96[1].col, 
                        color = v95
                    };
                    v88:DragBeginConsole();
                    return v88:updateGui();
                end;
            end;
        end;
        return;
    end;
end;
v68.DragEnd = function(v99) --[[ Line: 279 ]] --[[ Name: DragEnd ]]
	-- upvalues: v3 (copy)
    if v99.isDrawing then
        local l_color_0 = v99.drawingStart.color;
        if #v99.paths[l_color_0] <= 1 then
            v99.paths[l_color_0] = {};
        end;
        if v99.Settings.ConnectToTargetIfNearby and #v99.paths[l_color_0] > 1 and v99.paths[l_color_0][#v99.paths[l_color_0]] then
            local v101 = v99.paths[l_color_0][#v99.paths[l_color_0]];
            local v102 = v99.targetPairs[l_color_0];
            local v103 = sameLocation(v99.drawingStart, v102[1]) and 2 or 1;
            local v104 = sameLocation(v101, v102[v103]);
            local v105 = isNeighbour(v101.row, v101.col, v102[v103].row, v102[v103].col);
            if v104 then
                v99.dragDebounce[l_color_0] = os.clock();
            elseif v105 then
                table.insert(v99.paths[l_color_0], {
                    row = v102[v103].row, 
                    col = v102[v103].col
                });
                v99.dragDebounce[l_color_0] = os.clock();
            end;
        end;
        v99.isDrawing = false;
        v99.drawingStart = nil;
        v99:updateGui();
        v99:checkForWin();
        v3:Play("dragEnd");
    end;
end;
v68.GetCellAtMousePosition = function(v106, _) --[[ Line: 311 ]] --[[ Name: GetCellAtMousePosition ]]
    -- upvalues: l_l_LocalPlayer_0_Mouse_0 (copy), l_LocalPlayer_0 (copy)
    local l_SelectedObject_0 = game.GuiService.SelectedObject;
    if l_SelectedObject_0 and l_SelectedObject_0.Parent then
        for _, v110 in pairs(v106.gridFrame:GetChildren()) do
            if l_SelectedObject_0.Parent == v110 then
                return v110;
            end;
        end;
    end;
    local v111 = Vector2.new(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
    local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(v111.X, v111.Y);
    for _, v114 in pairs(l_GuiObjectsAtPosition_0) do
        if v114.Parent == v106.gridFrame then
            return v114;
        end;
    end;
    return nil;
end;
v68.InputChanged = function(v115, v116) --[[ Line: 336 ]] --[[ Name: InputChanged ]]
    -- upvalues: v3 (copy), v4 (copy)
    if not v115.gameEnded and v115.isDrawing then
        local l_v115_CellAtMousePosition_0 = v115:GetCellAtMousePosition(v116);
        if l_v115_CellAtMousePosition_0 then
            local v118, v119 = l_v115_CellAtMousePosition_0.Name:match("(%d+)-(%d+)");
            v118 = tonumber(v118);
            v119 = tonumber(v119);
            local v120 = v115:getGrid();
            local l_color_1 = v115.drawingStart.color;
            local v122 = v115.paths[l_color_1][#v115.paths[l_color_1]];
            local l_row_2 = v122.row;
            local l_col_2 = v122.col;
            local v125 = v115.paths[l_color_1][1];
            local v126 = false;
            if v120[l_row_2][l_col_2].status == "target" then
                v126 = false;
                if v120[l_row_2][l_col_2].color == l_color_1 then
                    v126 = true;
                    if l_row_2 == v125.row then
                        v126 = l_col_2 ~= v125.col;
                    end;
                end;
            end;
            local v127 = isNeighbour(l_row_2, l_col_2, v118, v119);
            local v128 = true;
            if v120[v118][v119].status ~= "empty" then
                v128 = false;
                if v120[v118][v119].status == "target" then
                    v128 = v120[v118][v119].color == l_color_1;
                end;
            end;
            local v129 = false;
            for _, v131 in ipairs(v115.paths[l_color_1]) do
                if v131.row == v118 and v131.col == v119 then
                    v129 = true;
                    break;
                end;
            end;
            if v127 and v128 and not v126 and not v129 then
                table.insert(v115.paths[l_color_1], {
                    row = v118, 
                    col = v119
                });
                v115:updateGui();
                if v120[v118][v119].status == "target" then
                    v115:CircleEffect(v118, v119);
                    v3:Play("lineConnect");
                    return;
                else
                    v3:Play("lineDraw");
                    return;
                end;
            elseif v129 then
                removeAfterCoordinates(v115.paths[l_color_1], v118, v119);
                v115:updateGui();
                return;
            elseif v128 and not v126 and v115.Settings.PathFinderLengthLimit > 0 then
                local v132 = v4.new(v120, v122, {
                    row = v118, 
                    col = v119
                }, v115.Settings.PathFinderLengthLimit);
                if v132:isPathAvailable() then
                    for _, v134 in ipairs(v132:shortestPath()) do
                        table.insert(v115.paths[l_color_1], v134);
                        v3:Play("lineDraw");
                        v115:updateGui();
                    end;
                end;
            end;
        end;
    end;
end;
v68.getGrid = function(v135, v136) --[[ Line: 388 ]] --[[ Name: getGrid ]]
    local v137 = {};
    for v138 = 1, v135.gridSize do
        v137[v138] = {};
        for v139 = 1, v135.gridSize do
            v137[v138][v139] = {
                status = "empty", 
                color = nil, 
                connections = {}
            };
        end;
    end;
    if v136 then
        return v137;
    else
        for v140, v141 in ipairs(v135.paths) do
            if #v141 > 0 then
                for v142 = 1, #v141 do
                    local v143 = v141[v142 - 1];
                    local v144 = v141[v142];
                    local v145 = v141[v142 + 1];
                    local v146 = {};
                    if v143 then
                        local v147 = getDirection(v144.row, v144.col, v143.row, v143.col);
                        if v147 then
                            v146[v147] = true;
                        end;
                    end;
                    if v145 then
                        local v148 = getDirection(v144.row, v144.col, v145.row, v145.col);
                        if v148 then
                            v146[v148] = true;
                        end;
                    end;
                    v137[v144.row][v144.col].status = "path";
                    v137[v144.row][v144.col].color = v140;
                    v137[v144.row][v144.col].connections = v146;
                end;
            end;
        end;
        for v149, v150 in ipairs(v135.targetPairs) do
            for _, v152 in ipairs(v150) do
                v137[v152.row][v152.col].status = "target";
                v137[v152.row][v152.col].color = v149;
            end;
        end;
        return v137;
    end;
end;
v68.updateGui = function(v153) --[[ Line: 440 ]] --[[ Name: updateGui ]]
    -- upvalues: l_TweenService_0 (copy), l_defaultButtonColor_0 (copy), v6 (copy)
    local v154 = v153:getGrid();
    for v155 = 1, v153.gridSize do
        for v156 = 1, v153.gridSize do
            local l_FirstChild_0 = v153.gridFrame:FindFirstChild(v155 .. "-" .. v156);
            if l_FirstChild_0 then
                local v158 = v154[v155][v156];
                if v158.status == "empty" then
                    v153:clearAssets(v155, v156);
                    l_TweenService_0:Create(l_FirstChild_0.Button, TweenInfo.new(0.15), {
                        BackgroundColor3 = l_defaultButtonColor_0
                    }):Play();
                elseif v158.status == "target" then
                    local v159 = false;
                    for v160, v161 in pairs(v158.connections) do
                        if v161 then
                            v159 = v160;
                            break;
                        end;
                    end;
                    v153:updateAssets(v155, v156, "Circle", v153.colors[v158.color], v158.connections);
                    if v6.showNumbers == true then
                        l_FirstChild_0:FindFirstChild("Circle").Number.Text = v158.color;
                        l_FirstChild_0:FindFirstChild("Circle").Number.Visible = true;
                    else
                        l_FirstChild_0:FindFirstChild("Circle").Number.Visible = false;
                    end;
                    local v162 = false;
                    for _, v164 in ipairs(v153.paths[v158.color]) do
                        if v164.row == v155 and v164.col == v156 then
                            v162 = true;
                            break;
                        end;
                    end;
                    if v162 then
                        l_TweenService_0:Create(l_FirstChild_0.Button, TweenInfo.new(0.15), {
                            BackgroundColor3 = l_defaultButtonColor_0:Lerp(v153.colors[v158.color], 0.3)
                        }):Play();
                    else
                        l_TweenService_0:Create(l_FirstChild_0.Button, TweenInfo.new(0.15), {
                            BackgroundColor3 = l_defaultButtonColor_0
                        }):Play();
                    end;
                elseif v158.status == "path" then
                    v153:updateAssets(v155, v156, "Line", v153.colors[v158.color], v158.connections);
                    l_TweenService_0:Create(l_FirstChild_0.Button, TweenInfo.new(0.15), {
                        BackgroundColor3 = l_defaultButtonColor_0:Lerp(v153.colors[v158.color], 0.3)
                    }):Play();
                end;
            end;
        end;
    end;
end;
v68.clearAssets = function(v165, v166, v167) --[[ Line: 491 ]] --[[ Name: clearAssets ]]
    local l_FirstChild_1 = v165.gridFrame:FindFirstChild(v166 .. "-" .. v167);
    for _, v170 in ipairs(l_FirstChild_1:GetChildren()) do
        if v170.Name ~= "Button" and v170.Name ~= "Effects" then
            v170:Destroy();
        end;
    end;
end;
v68.updateAssets = function(v171, v172, v173, v174, v175, v176) --[[ Line: 500 ]] --[[ Name: updateAssets ]]
    -- upvalues: v11 (copy)
    local v177 = "";
    if v176.up then
        v177 = v177 .. "up";
    end;
    if v176.down then
        v177 = v177 .. "down";
    end;
    if v176.left then
        v177 = v177 .. "left";
    end;
    if v176.right then
        v177 = v177 .. "right";
    end;
    if v177 == "" then
        v177 = "none";
    end;
    local v178 = v11[v174][v177];
    local l_FirstChild_2 = v171.gridFrame:FindFirstChild(v172 .. "-" .. v173);
    if v178 and l_FirstChild_2 then
        v171:clearAssets(v172, v173);
        for _, v181 in v178 do
            local v182 = v181:Clone();
            v182.Parent = l_FirstChild_2;
            v182.BackgroundColor3 = v175;
        end;
        return;
    else
        return;
    end;
end;
v68.EndGame = function(v183, v184) --[[ Line: 521 ]] --[[ Name: EndGame ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_Debris_0 (copy), l_TweenService_0 (copy)
    v183.gameEnded = true;
    v183.isDrawing = false;
    v183.drawingStart = false;
    for _, v186 in pairs(v183.Connections) do
        v186:Disconnect();
    end;
    v183.Connections = {};
    if v183.completedEvent and v184 ~= nil then
        local l_completedEvent_0 = v183.completedEvent;
        v183.completedEvent = nil;
        l_completedEvent_0:Fire(v184 and "finishedPuzzle" or "leaveGenerator");
        l_completedEvent_0:Destroy();
    end;
    if v184 then
        l_LocalPlayer_0:SetAttribute("CompletedGenPuzzle", true);
    end;
    task.spawn(function() --[[ Line: 531 ]]
        -- upvalues: l_Debris_0 (ref), v183 (copy), l_TweenService_0 (ref)
        l_Debris_0:AddItem(v183.GUI, 0.5);
        l_TweenService_0:Create(v183.containerFrame, TweenInfo.new(0.5), {
            Size = UDim2.new()
        }):Play();
    end);
end;
v68.checkForWin = function(v188) --[[ Line: 539 ]] --[[ Name: checkForWin ]]
	if v188:checkWin() then
        v188:EndGame(true);
	end
end;
v68.checkWin = function(v189) --[[ Line: 545 ]] --[[ Name: checkWin ]]
    for v190, v191 in ipairs(v189.targetPairs) do
        local v192 = v189.paths[v190];
        if #v192 < 2 then
            return false;
        elseif not (sameLocation(v192[1], v191[1]) and sameLocation(v192[#v192], v191[2]) or sameLocation(v192[1], v191[2]) and sameLocation(v192[#v192], v191[1])) then
            return false;
        end;
    end;
    if v189.Settings.MustFillEntireGrid then
        local v193 = 0;
        for _, v195 in ipairs(v189.paths) do
            for _, _ in ipairs(v195) do
                v193 = v193 + 1;
            end;
        end;
        if v193 == v189.gridSize * v189.gridSize then
            return true;
        else
            return false;
        end;
    else
        return true;
    end;
end;
v68.CircleEffect = function(v198, v199, v200, v201) --[[ Line: 571 ]] --[[ Name: CircleEffect ]]
    -- upvalues: l_TweenService_0 (copy), l_Debris_0 (copy)
    local l_FirstChild_3 = v198.gridFrame:FindFirstChild(v199 .. "-" .. v200);
    if not l_FirstChild_3 then
        return;
    else
        local l_Circle_0 = l_FirstChild_3:FindFirstChild("Circle");
        if l_Circle_0 then
            local v204 = l_Circle_0:Clone();
            v204:FindFirstChild("Number"):Destroy();
            v204.Parent = l_FirstChild_3.Effects;
            if v201 then
                l_TweenService_0:Create(v204, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, true, 0), {
                    Size = UDim2.fromScale(0.8, 0.8)
                }):Play();
                l_Debris_0:AddItem(v204, 0.4);
                return;
            else
                l_TweenService_0:Create(v204, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Size = UDim2.fromScale(1, 1), 
                    BackgroundTransparency = 1
                }):Play();
                l_Debris_0:AddItem(v204, 0.45);
            end;
        end;
        return;
    end;
end;
return v68;