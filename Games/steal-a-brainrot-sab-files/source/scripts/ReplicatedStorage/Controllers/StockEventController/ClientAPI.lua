
local v_u_1 = game:GetService("ReplicatedStorage")
require(v_u_1.Shared.StockMachineTypes)
local v2 = require(v_u_1.Packages.Net)
local v_u_3 = v2:RemoteEvent("StockEventService/SetFocused")
local v_u_4 = v2:RemoteEvent("StockEventService/Return")
local v_u_5 = v2:RemoteEvent("StockEventService/Redeem")
local v_u_6 = v2:RemoteFunction("StockEventService/ListItems")
v2:RemoteFunction("StockEventService/Delivery")
local v_u_7 = {}
local v_u_21 = {
    ["GetStock"] = function(_, p8)
        return v_u_1:GetAttribute((("StockEvent_%*"):format((string.gsub(p8, "%s", "_")))))
    end,
    ["OnStockChange"] = function(_, p9, p10)
        return v_u_1:GetAttributeChangedSignal((("StockEvent_%*"):format((string.gsub(p9, "%s", "_"))))):Connect(p10)
    end,
    ["Redeem"] = function(p11, p12)
        v_u_5:FireServer(p11.MachineName, p12)
    end,
    ["Return"] = function(p13, p14)
        v_u_4:FireServer(p13.MachineName, p14)
    end,
    ["SetOpen"] = function(p15, p16)
        v_u_3:FireServer("30343105-9fc1-45c9-a2b1-18a5b13a4e2f", p15.MachineName, p16)
    end,
    ["ListItems"] = function(p17)
        if v_u_7[p17.MachineName] then
            return true, v_u_7[p17.MachineName]
        end
        local v18 = 3
        while true do
            local v19, v20 = v_u_6:InvokeServer("159077bd-12e0-4fd9-8fb8-12f42bb0b78f", p17.MachineName)
            if v19 then
                break
            end
            task.wait(3)
            if v20 ~= "Retry" then
                if v18 <= 0 then
                    break
                end
                v18 = v18 - 1
            end
        end
        if v19 and typeof(v20) == "table" then
            v_u_7[p17.MachineName] = v20
        end
        return v19, v20
    end
}
return {
    ["create"] = function(p22)
        local v23 = {
            ["__index"] = v_u_21
        }
        return setmetatable({
            ["MachineName"] = p22
        }, v23)
    end
}