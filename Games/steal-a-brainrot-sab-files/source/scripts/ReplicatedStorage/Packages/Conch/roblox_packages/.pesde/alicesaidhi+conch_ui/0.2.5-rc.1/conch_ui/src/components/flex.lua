

local l_create_0 = require("../../roblox_packages/vide").create;
return function()
    local v1 = l_create_0("UIListLayout")({});
    return (setmetatable({
        v1
    }, {
        __index = {
            row = function(v2)
                v1.FillDirection = Enum.FillDirection.Vertical;
                return v2;
            end, 
            column = function(v3)
                v1.FillDirection = Enum.FillDirection.Horizontal;
                return v3;
            end, 
            layout = function(v4)
                v1.SortOrder = Enum.SortOrder.LayoutOrder;
                return v4;
            end, 
            name = function(v5)
                v1.SortOrder = Enum.SortOrder.Name;
                return v5;
            end, 
            none = function(v6, v7)
                if v7 ~= "vertical" then
                    v1.HorizontalFlex = Enum.UIFlexAlignment.None;
                end;
                if v7 ~= "horizontal" then
                    v1.VerticalFlex = Enum.UIFlexAlignment.None;
                end;
                return v6;
            end, 
            even = function(v8, v9)
                if v9 ~= "vertical" then
                    v1.HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly;
                end;
                if v9 ~= "horizontal" then
                    v1.VerticalFlex = Enum.UIFlexAlignment.SpaceEvenly;
                end;
                return v8;
            end, 
            around = function(v10, v11)
                if v11 ~= "vertical" then
                    v1.HorizontalFlex = Enum.UIFlexAlignment.SpaceAround;
                end;
                if v11 ~= "horizontal" then
                    v1.VerticalFlex = Enum.UIFlexAlignment.SpaceAround;
                end;
                return v10;
            end, 
            between = function(v12, v13)
                if v13 ~= "vertical" then
                    v1.HorizontalFlex = Enum.UIFlexAlignment.SpaceBetween;
                end;
                if v13 ~= "horizontal" then
                    v1.VerticalFlex = Enum.UIFlexAlignment.SpaceBetween;
                end;
                return v12;
            end, 
            fill = function(v14, v15)
                if v15 ~= "vertical" then
                    v1.HorizontalFlex = Enum.UIFlexAlignment.Fill;
                end;
                if v15 ~= "horizontal" then
                    v1.VerticalFlex = Enum.UIFlexAlignment.Fill;
                end;
                return v14;
            end, 
            horizontal = function(v16, v17)
                v1.HorizontalAlignment = if v17 == "left" then Enum.HorizontalAlignment.Left else if v17 == "right" then Enum.HorizontalAlignment.Right else Enum.HorizontalAlignment.Center;
                return v16;
            end, 
            vertical = function(v18, v19)
                v1.VerticalAlignment = if v19 == "top" then Enum.VerticalAlignment.Top else if v19 == "bottom" then Enum.VerticalAlignment.Bottom else Enum.VerticalAlignment.Center;
                return v18;
            end, 
            gap = function(v20, v21)
                v1.Padding = UDim.new(0, v21);
                return v20;
            end
        }
    }));
end;