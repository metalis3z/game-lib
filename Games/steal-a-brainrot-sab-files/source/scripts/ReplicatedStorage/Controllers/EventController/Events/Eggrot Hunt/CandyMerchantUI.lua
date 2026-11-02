
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local InterfaceController = require(ReplicatedStorage.Controllers.InterfaceController)
local NotificationController = require(ReplicatedStorage.Controllers.NotificationController)
local SoundController = require(ReplicatedStorage.Controllers.SoundController)
local AnimatedButton = require(ReplicatedStorage.Classes.AnimatedButton)
local Synchronizer = require(ReplicatedStorage.Packages.Synchronizer)
local Observers = require(ReplicatedStorage.Packages.Observers)
local Trove = require(ReplicatedStorage.Packages.Trove)
local Timer = require(ReplicatedStorage.Packages.Timer)
local Net = require(ReplicatedStorage.Packages.Net)
local NumberUtils = require(ReplicatedStorage.Utils.NumberUtils)
local TimeUtils = require(ReplicatedStorage.Utils.TimeUtils)
local CandyMerchantData = require(ReplicatedStorage.Datas.CandyMerchantData)
local v15 = Net:RemoteFunction("EggrotHunt/CandyMerchant/Buy")
local LocalPlayer = Players.LocalPlayer
local CandyShop = LocalPlayer.PlayerGui:WaitForChild("CandyShop").CandyShop
local v18 = InterfaceController:Register("EggrotCandyShop", CandyShop, "TopQuint")

v18:AttachCloseButton(CandyShop.Header.Close)
v18:Close()

return {
	Start = function(_)
		local v20 = Trove.new()
		local Main = CandyShop.Main
		local Template = Main:FindFirstChild("Template")
		local u23 = nil

		local function updateStock()
			if u23 then
				u23:Destroy()
			end

			local v26 = Trove.new()

			u23 = v26
			v20:Add(v26)

			local EggrotCandyStock = ReplicatedStorage:GetAttribute("EggrotCandyStock")

			if typeof(EggrotCandyStock) ~= "string" or EggrotCandyStock == "" then
				return
			end

			local parts = string.split(EggrotCandyStock, "|")

			Synchronizer:Get(LocalPlayer)

			for _, v30 in parts do
				if Template then
					local v31 = CandyMerchantData[v30]

					if v31 then
						local clone = Template:Clone()

						clone.Name = v30
						clone.Visible = true

						local Name = clone:FindFirstChild("Name")

						if Name and Name:IsA("TextLabel") then
							Name.Text = v30
						end

						local Icon = clone:FindFirstChild("Icon")

						if Icon and Icon:IsA("ImageLabel") then
							Icon.Image = v31.Icon
						end

						local Buy = clone:FindFirstChild("Buy")

						if Buy and Buy:IsA("GuiButton") then
							local Function = Buy:FindFirstChild("Function")

							if Function and Function:IsA("TextLabel") then
								Function.Text = `${ NumberUtils:ToString(v31.Price, 2) }`
							end

							local v37 = AnimatedButton.new(Buy)

							v37:Animate()
							v26:Add(v37.OnActivated:Connect(function()
								local v41, v42 = v15:InvokeServer(v30)

								if v41 then
									NotificationController:Success(v42 or "Purchased!")
									SoundController:PlaySound("Sounds.Sfx.Success")

									return
								end

								NotificationController:Error(v42 or "Purchase failed.")
								SoundController:PlaySound("Sounds.Sfx.Error")
							end))
						end

						clone.Parent = Main
						v26:Add(clone)
					end
				end
			end
		end

		v20:Add(ReplicatedStorage:GetAttributeChangedSignal("EggrotCandyStock"):Connect(updateStock))
		task.spawn(updateStock)

		local Title = CandyShop:FindFirstChild("Title")

		if Title and Title:IsA("TextLabel") then
			v20:Add(Timer.Simple(1, function()
				local v38 = 300 - workspace:GetServerTimeNow() % 300

				Title.Text = `Shop refreshes in <font color="rgb(250, 111, 255)">{ TimeUtils:E((math.max(v38 // 1, 0))) }</font>`
			end, true))
		end

		v20:Add(Observers.observeTag("EggrotCandyMerchantPrompt", function(p2)
			if not p2:IsA("ProximityPrompt") then
				return nil
			end

			local connection = p2.Triggered:Connect(function()
				InterfaceController:Toggle("EggrotCandyShop")
			end)

			return function()
				connection:Disconnect()
			end
		end, { workspace }))

		return function()
			if u23 then
				u23:Destroy()
			end

			v20:Destroy()
		end
	end
}
