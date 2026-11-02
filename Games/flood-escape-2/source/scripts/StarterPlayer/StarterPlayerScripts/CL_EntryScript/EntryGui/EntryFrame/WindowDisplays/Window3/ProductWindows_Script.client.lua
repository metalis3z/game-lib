-- Decompiled using Krnl
local v6 = (game.Workspace:WaitForChild("Lobby")):WaitForChild("ProductWindows")
local v11, v12, v13 = pairs((script.Parent.Content:WaitForChild("Holder")):GetChildren())
for v51, v16 in v11, v12, v13 do
    local v17 = v16:IsA("TextButton")
    if v17 then
        v17 = spawn
        v17(function()
            while true do
                local v20 = wait()
                if v20 then
                    break
                end
                v20 = v16
                v20.BorderColor3 = Color3.new(math.abs(math.sin(tick())), 0, 0)
            end
        end)
        v16.MouseButton1Click:connect(function()
            local v35 = v16.ProductId.Value
            local v37 = v16:FindFirstChild("IsGamepass")
            if v37 then
                v37 = game
                v37:GetService("MarketplaceService"):PromptGamePassPurchase(game.Players.LocalPlayer, v35)
                return 
            end
            local v40 = game
            game:GetService("MarketplaceService"):PromptProductPurchase(v40.Players.LocalPlayer, v35)
        end)
    end
end
