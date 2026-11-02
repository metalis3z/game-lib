local id = 204143610
local nam = "Normal VIP"
local cost = 450
local desc = "This VIP Includes:An assault rifle on start, a bonus $1,500 cash on start, and a SpeedCoil.."
local p = script.Parent.Parent


function click()
	p.Cost1.Text = "Cost: "..cost
	p.Item.Text = "Item: "..nam
	p.Description1.Text = "Description: "..desc
	p.ID.Value = id
end

script.Parent.MouseButton1Down:connect(click)