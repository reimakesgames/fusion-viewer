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

local PropsModule

local Widget = plugin:CreateDockWidgetPluginGui("reimakesgames_fusion-viewer", WIDGET_INFO)
Widget.Title = "fusion-viewer"

function CreateBindable(type, name, handler)
	local Event = Instance.new("Bindable" .. type)
	Event.Name = name
	Event.Parent = script.Parent

	if handler then
		if type == "Event" then
			Event.Event:Connect(handler)
		elseif type == "Function" then
			Event.OnInvoke = handler
		end
	end

	return Event
end

function GetSavedProps()
	local Props = plugin:GetSetting("props")
	print("Loaded Props: " .. Props)
	return Props
end

function SetSavedProps()
	plugin:SetSetting("props", PropsModule.Source)
end

function ReloadPropsModule()
	if PropsModule then
		SetSavedProps()
		PropsModule:Destroy()
	end

	PropsModule = Instance.new("ModuleScript", script)
	PropsModule.Name = "props"
	PropsModule.Source = GetSavedProps() or [[return {
		-- Add your props here
		-- This will save your props whenever you:
		--   Re-focus on the widget
		--   Close the widget
		--   Click Select component
		--   Close the props script then reopen it using the Change Props button
	}
	]]

	return PropsModule
end
PropsModule = ReloadPropsModule()

local function OnViewButtonClicked()
	Widget.Enabled = not Widget.Enabled
end

CreateBindable("Event", "OpenScript", function()
	plugin:OpenScript(PropsModule)
end)
CreateBindable("Function", "ReloadProps", ReloadPropsModule)
local ReloadTree = CreateBindable("Event", "ReloadTree")


local view = require(script.Parent.components.view)
view {
	Parent = Widget;
	ReloadTree = ReloadTree.Event;
}

ViewButton.Click:Connect(OnViewButtonClicked)

Widget.WindowFocused:Connect(function()
	ReloadTree:Fire()
end)
Widget:BindToClose(function()
	SetSavedProps()
end)
plugin.Unloading:Connect(function()
	SetSavedProps()
end)
