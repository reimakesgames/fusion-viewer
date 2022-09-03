local Fusion = require(script.Parent.Parent.packages.fusion)
local New = Fusion.New
local OnEvent = Fusion.OnEvent

return function(props)
	return New "TextButton" {
		AnchorPoint = props.AnchorPoint;

		Position = props.Position;
		Size = props.Size;

		BackgroundColor3 = props.BackgroundColor;

		Text = props.Text;

		[Fusion.Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 8)
			}
		};

		[OnEvent "MouseButton1Click"] = props.OnActivated
	}
end