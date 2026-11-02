

local v0 = require("./background");
local v1 = require("./container");
local v2 = require("./flex");
local v3 = require("./padding");
local v4 = require("./text");
local v5 = require("../../roblox_packages/vide");
local l_show_0 = v5.show;
local l_indexes_0 = v5.indexes;
local l_source_0 = v5.source;
local l_effect_0 = v5.effect;
return function(v10)
    local v11 = l_source_0(v10.selected());
    l_effect_0(function()
        local v12 = v10.selected();
        local v13 = v11();
        local v14 = v11() + 10 - 1;
        if v14 < v12 then
            local v15 = v12 - v14;
            v11(v11() + v15);
            return;
        else
            if v12 < v13 then
                local v16 = v12 - v13;
                v11(v11() + v16);
            end;
            return;
        end;
    end);
    return v1({
        x = v10.x, 
        y = v10.y, 
        width = 300, 
        auto = "Y", 
        anchor = {
            0, 
            1
        }, 
        zindex = 10000; 
        v2():column():gap(4):vertical("bottom"), 
        l_show_0(v10.analyzing, function()
            local function _()
                return v10.analyzing() or {
                    kind = "", 
                    name = "", 
                    description = "", 
                    optional = false
                };
            end;
            return v0({
                width = 300, 
                layout = 10, 
                auto = Enum.AutomaticSize.Y; 
                {
                    BackgroundTransparency = 0
                }, 
                v2(), 
                v0({
                    height = 24, 
                    width = 300; 
                    v2():column():between("horizontal"):vertical("center"), 
                    v3({
                        x = 4
                    }), 
                    v4({
                        text = function()
                            if (v10.analyzing() or {
                                kind = "", 
                                name = "", 
                                description = "", 
                                optional = false
                            }).kind == "variadic" then
                                return "...";
                            else
                                return (v10.analyzing() or {
                                    kind = "", 
                                    name = "", 
                                    description = "", 
                                    optional = false
                                }).name or "";
                            end;
                        end, 
                        text_size = 20, 
                        weight = Enum.FontWeight.Bold
                    }), 
                    v4({
                        text = function()
                            return ("%*%*"):format((v10.analyzing() or {
                                kind = "", 
                                name = "", 
                                description = "", 
                                optional = false
                            }).type, (v10.analyzing() or {
                                kind = "", 
                                name = "", 
                                description = "", 
                                optional = false
                            }).optional and "?" or "") or "";
                        end, 
                        text_size = 18, 
                        weight = Enum.FontWeight.Light
                    })
                }), 
                v4({
                    v3({
                        padding = 4
                    }); 
                    width = 300, 
                    wrapped = true, 
                    text_size = 16, 
                    xalignment = Enum.TextXAlignment.Left, 
                    text = function()
                        return (v10.analyzing() or {
                            kind = "", 
                            name = "", 
                            description = "", 
                            optional = false
                        }).description or "";
                    end
                })
            });
        end), 
        l_show_0(function()
            return v10.suggestions()[1] ~= nil;
        end, function()
            return v0({
                ys = 1, 
                width = 200, 
                height = 0, 
                anchor = {
                    0, 
                    1
                }, 
                auto = Enum.AutomaticSize.Y; 
                {
                    BackgroundTransparency = 0
                }, 
                v2():vertical("bottom"), 
                l_indexes_0(function()
                    local v18 = v10.suggestions();
                    table.sort(v18, function(v19, v20)
                        return v19.name < v20.name;
                    end);
                    local v21 = {};
                    for v22 = v11(), v11() + 10 - 1 do
                        v21[v22 - v11() + 1] = v18[v22];
                    end;
                    return v21;
                end, function(v23, v24)
                    return v4({
                        width = 200, 
                        height = 20, 
                        order = v24, 
                        text_size = 16, 
                        xalignment = Enum.TextXAlignment.Left, 
                        text = function()
                            return v23().name;
                        end, 
                        text_style = function()
                            if v24 == v10.selected() - v11() + 1 then
                                return "info";
                            else
                                return "normal";
                            end;
                        end; 
                        v3({
                            left = 4
                        })
                    });
                end)
            });
        end)
    });
end;