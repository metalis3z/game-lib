local Lib = require(game.ReplicatedStorage:WaitForChild("Lib"))
local cash = Lib.UI.Get("Sanity"):WaitForChild("Frame"):WaitForChild("cash")

Lib.dHandler.Stats.Event:Connect(function() --[[ Line: 5 | Upvalues: cash (copy), Lib (copy) ]]
	cash.Text = "$" .. Lib.Text.AddCommas(Lib.data.Stats.LocalCash)
end)
task.spawn(function() --[[ Line: 9 | Upvalues: cash (copy), Lib (copy) ]]
	cash.Text = "$" .. Lib.Text.AddCommas(Lib.data.Stats.LocalCash)
	cash.parent.class.Text = Lib.data.Stats.Class
end)
Lib.dHandler.UpdateData.Event:Connect(function() --[[ Line: 14 | Upvalues: cash (copy), Lib (copy) ]]
	cash.parent.class.Text = Lib.data.Stats.Class
end)

return {}