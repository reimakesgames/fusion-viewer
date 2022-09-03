local Fusion = require(script.Parent.Parent.packages.fusion)
local New = Fusion.New
local State = Fusion.State

local Size = State(UDim2.fromOffset(1280, 720))

local TextBoxLabel = require(script.Parent:WaitForChild("textboxlabel"))

local TEXT_ONLY_PATTERN = "%-?%d*"
local NUM_ONLY_PATTERN = "[^%-%d]"

return function(props)
	return New "Frame" {
		AnchorPoint = props.AnchorPoint;

		Position = props.Position;
		Size = props.Size;

		BackgroundTransparency = 1;

		[Fusion.Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(0, 4);
			};

			TextBoxLabel {
				Position = UDim2.new(0, 0, 0, 0);
				Size = UDim2.new(0.5, -8, 1, 0);

				LabelSize = 0.3;
				LabelText = "X:";

				TextChanged = function(text)
					return text:gsub(NUM_ONLY_PATTERN, "")
				end;

				FocusLost = function(enterPressed, inputThatCausedFocusLost, textInput)
					Size:set(UDim2.fromOffset(Size:get().X.Offset, tonumber(textInput)))
					props.SizeChanged(Size:get())
				end
			};

			TextBoxLabel {
				Position = UDim2.new(0.5, 0, 0, 0);
				Size = UDim2.new(0.5, -8, 1, 0);

				LabelSize = 0.3;
				LabelText = "Y:";

				TextChanged = function(text)
					return text:gsub(NUM_ONLY_PATTERN, "")
				end;

				FocusLost = function(enterPressed, inputThatCausedFocusLost, textInput)
					Size:set(UDim2.fromOffset(tonumber(textInput), Size:get().Y.Offset))
					props.SizeChanged(Size:get())
				end
			}
		}
	}
end