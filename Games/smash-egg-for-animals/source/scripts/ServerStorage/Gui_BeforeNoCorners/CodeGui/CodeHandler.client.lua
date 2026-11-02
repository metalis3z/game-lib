-- CodeGui Handler: enter and redeem codes (both static and admin-created)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local gui = script.Parent
local main = gui:WaitForChild("Main")
local header = main:WaitForChild("Header")
local closeBtn = header:WaitForChild("Close")
local codeInput = main:WaitForChild("CodeInput")
local redeemBtn = main:WaitForChild("Redeem")
local resultLabel = main:WaitForChild("Result")

-- Two code systems:
-- 1. Static codes via RemoteFunction: ReplicatedStorage.CodesSystem.RedeemCode
-- 2. Admin-created codes via RemoteEvent: ReplicatedStorage.AdminSystem.Remotes.RedeemCode + CodeResult
local codesFunction = ReplicatedStorage:FindFirstChild("CodesSystem") and ReplicatedStorage.CodesSystem:FindFirstChild("RedeemCode")
local adminRemotes = ReplicatedStorage:FindFirstChild("AdminSystem") and ReplicatedStorage.AdminSystem:FindFirstChild("Remotes")
local adminRedeem = adminRemotes and adminRemotes:FindFirstChild("RedeemCode")
local codeResult = adminRemotes and adminRemotes:FindFirstChild("CodeResult")

local isOpen = false
local successColor = Color3.new(0.4, 1, 0.4)
local errorColor = Color3.new(1, 0.3, 0.3)

-- Show/hide GUI
local function toggle(open)
    if open == nil then
        isOpen = not isOpen
    else
        isOpen = open
    end
    main.Visible = isOpen
    if isOpen then
        codeInput.Text = ""
        resultLabel.Text = ""
        task.wait(0.1)
        codeInput:CaptureFocus()
    end
end

-- Show result text with color
local function showResult(text, success)
    resultLabel.Text = text
    resultLabel.TextColor3 = success and successColor or errorColor
end

-- Listen for admin code results (async)
if codeResult then
    codeResult.OnClientEvent:Connect(function(success, message)
        showResult(message, success)
    end)
end

-- Redeem logic: try both systems
local isBusy = false
local function tryRedeem()
    if isBusy then return end
    local code = codeInput.Text
    if code == "" or code:match("^%s*$") then
        showResult("Please enter a code first.", false)
        return
    end

    isBusy = true
    redeemBtn.Text = "..."
    resultLabel.Text = ""

    -- tout passe par le serveur (codes fixes + codes admin) : il répond avec le résultat
    local success, message = false, "Service unavailable, try again later."
    if codesFunction then
        local ok, retSuccess, retMessage = pcall(function()
            return codesFunction:InvokeServer(code)
        end)
        if ok and type(retSuccess) == "boolean" then
            success = retSuccess
            message = retMessage or (success and "Code redeemed!" or "Invalid code.")
        end
    end

    showResult(message, success)
    if success then codeInput.Text = "" end
    isBusy = false
    redeemBtn.Text = "Redeem"
end


-- Connect to the Codes navigation button (in "left bottom" GUI)
local playerGui = player:WaitForChild("PlayerGui")
local codesButton = playerGui:WaitForChild("left bottom"):WaitForChild("Holder"):WaitForChild("CodesButton")
codesButton.MouseButton1Click:Connect(function()
    toggle()
end)

-- le code s'écrit toujours en MAJUSCULES, même si on tape en minuscules
codeInput:GetPropertyChangedSignal("Text"):Connect(function()
	local upper = string.upper(codeInput.Text)
	if codeInput.Text ~= upper then codeInput.Text = upper end
end)

-- Connect events
redeemBtn.MouseButton1Click:Connect(tryRedeem)
closeBtn.MouseButton1Click:Connect(function()
    toggle(false)
end)

codeInput.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        tryRedeem()
    end
end)

-- Close when pressing Escape
gui:WaitForChild("Main")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Escape and isOpen then
        toggle(false)
    end
end)

-- Expose toggle for external buttons
gui:SetAttribute("CanToggle", true)
local toggleEvent = Instance.new("BindableEvent")
toggleEvent.Name = "Toggle"
toggleEvent.Parent = gui

toggleEvent.Event:Connect(function()
    toggle()
end)

-- Exposed function for other scripts to open the GUI
gui:SetAttribute("IsCodeGui", true)

return toggle