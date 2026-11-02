--!strict
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataManager       = require(script.Parent.DataManager)
local ItemConfigurations = require(ReplicatedStorage.Modules.ItemConfigurations)
local NumberFormatter   = require(ReplicatedStorage.Modules.NumberFormatter)
local Events            = ReplicatedStorage:WaitForChild("Events")
local RequestSell       = Events:WaitForChild("RequestSell")
local ShowNotification  = Events:WaitForChild("ShowNotification")
local ShowCashPopUp     = Events:WaitForChild("ShowCashPopUp")

local MUTATION_MULT = {Normal=1,Golden=2,Diamond=3,Ruby=4,Neon=5}

local function calcValue(name:string,mutation:string,level:number):number
    local cfg = ItemConfigurations.GetItemData(name)
    if not cfg then return 0 end
    return math.floor((cfg.Income or 0)*(MUTATION_MULT[mutation] or 1)*(1.125^((level or 1)-1)))
end

RequestSell.OnServerEvent:Connect(function(player:Player, sellType:string)
    if type(sellType) ~= "string" then return end
    local char = player.Character
    if sellType == "Equipped" then
        local tool = char and char:FindFirstChildWhichIsA("Tool")
        if not tool then ShowNotification:FireClient(player,"Nothing equipped!","Info"); return end
        local val = calcValue(
            tool:GetAttribute("OriginalName") or "",
            tool:GetAttribute("Mutation") or "Normal",
            tool:GetAttribute("Level") or 1)
        tool:Destroy()
        DataManager.addMoney(player, val)
        ShowCashPopUp:FireClient(player, val)
        ShowNotification:FireClient(player,"Sold for $"..NumberFormatter.Format(val),"Success")
    end
end)
print("[SellHandler] Active")
local SellHandler={}; return SellHandler
