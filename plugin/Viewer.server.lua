local Fusion = require(script.Parent.packages.fusion)

local PluginToolbar = plugin:CreateToolbar("reimakesgames")
local ViewButton = PluginToolbar:CreateButton("View", "Open the fusion-viewer", "rbxassetid://10586151186")
ViewButton.ClickableWhenViewportHidden = true

local WIDGET_INFO = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	false,
	false,
	300,
	200,
	300,
	200
)

local SavedProps = plugin:GetSetting("props")
if SavedProps then
	print("Loaded Props: " .. SavedProps)
end

local PropsModule = Instance.new("ModuleScript", script)
PropsModule.Name = "props"
PropsModule.Source = SavedProps or [[return {
	-- Add your props here
}
]]

plugin.Unloading:Connect(function()
	plugin:SetSetting("props", PropsModule.Source)
end)

local OpenScript = Instance.new("BindableEvent", script.Parent)
OpenScript.Name = "OpenScript"
OpenScript.Event:Connect(function()
	plugin:OpenScript(PropsModule)
end)

local Widget = plugin:CreateDockWidgetPluginGui("reimakesgames_fusion-viewer", WIDGET_INFO)
Widget.Title = "fusion-viewer"

local view = require(script.Parent.components.view)
view {Parent = Widget}

local function OnViewButtonClicked()
	Widget.Enabled = not Widget.Enabled
end

ViewButton.Click:Connect(OnViewButtonClicked)
