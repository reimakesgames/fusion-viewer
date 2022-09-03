local Fusion = require(script.Parent.Parent.packages.fusion)
local New = Fusion.New
local State = Fusion.State
local OnEvent = Fusion.OnEvent
local OnChange = Fusion.OnChange

return function(props)
	local LocalText = State("")

	return New "Frame" {
		Position = props.Position;
		Size = props.Size;

		BackgroundTransparency = 0.5;

		[Fusion.Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 8);
			};

			New "TextLabel" {
				Position = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(props.LabelSize, 0, 1, 0);

				Text = props.LabelText;
				Font = Enum.Font.Arial;
				TextSize = 16;

				BackgroundTransparency = 1;
			};

			New "TextBox" {
				Position = UDim2.new(props.LabelSize, 0, 0, 0);
				Size = UDim2.new(1 - props.LabelSize, 0, 1, 0);

				Text = LocalText;
				Font = Enum.Font.Arial;
				TextSize = 16;

				BackgroundTransparency = 1;

				[OnEvent "FocusLost"] = function(enterPressed, inputThatCausedFocusLost)
					props.FocusLost(enterPressed, inputThatCausedFocusLost, LocalText:get())
				end;

				[OnChange "Text"] = function(newText)
					LocalText:set(props.TextChanged(newText))
				end
			}
		}
	};
end