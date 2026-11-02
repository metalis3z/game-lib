local vide = require "../roblox_packages/vide"
local source = vide.source

return {
    background = source(Color3.fromHex "#0f1117"),
    background_transparency = source(0.02),
    stroke = source(Color3.fromHex "#7c3aed"),
    text = source(Color3.fromHex "#e2e8f0"),
    text_error = source(Color3.fromHex "#f87171"),
    text_info = source(Color3.fromHex "#60a5fa"),
    text_warn = source(Color3.fromHex "#fbbf24"),
    text_transparency = source(0.3),
    font = source(Font.fromId(16658246179)),
}
