--OldestFatherEver

ProductID		= 2706921217
ProductPrice	= 5
CurrencyType	= "R$"
Debounce		= true

DS= game:GetService("DataStoreService"):GetDataStore("Donations")
MS= game:GetService("MarketplaceService")

if not DS:GetAsync(CurrencyType.."_Raised") then
DS:SetAsync(CurrencyType.."_Raised",0)
end

Raised = DS:GetAsync(CurrencyType.."_Raised")
script.Parent.SurfaceGui.Raised.ROBUX.Text = CurrencyType.." "..DS:GetAsync(CurrencyType.."_Raised")

function PrintOut(Value)
print(Value)
end

script.Parent.CD.MouseClick:connect(function(Player)
if Debounce then
if Player.userId > 0 then
print 'Player is not a Guest!'
MS:PromptProductPurchase(Player,ProductID)
end
end
end)

MS.PromptProductPurchaseFinished:connect(function(UserId,ProductId,IsPurchased)
if Debounce then
Debounce = false
if IsPurchased then
DS:IncrementAsync(CurrencyType.."_Raised",ProductPrice)
DS:OnUpdate(CurrencyType.."_Raised",PrintOut)
script.Parent.SurfaceGui.Raised.ROBUX.Text = CurrencyType.." "..DS:GetAsync(CurrencyType.."_Raised")
script.Parent.Jingle.Volume = 1
script.Parent.Purchased:play()
script.Parent.Jingle:play()
wait(7)
for i = .5,0,-.05 do
script.Parent.Jingle.Volume = i
wait()
end
script.Parent.Jingle:stop()
end
Debounce = true
end
end)

coroutine.resume(coroutine.create(function()
while wait() do
Raised = DS:GetAsync(CurrencyType.."_Raised")
script.Parent.SurfaceGui.Raised.ROBUX.Text = CurrencyType.." "..DS:GetAsync(CurrencyType.."_Raised")
end
end))