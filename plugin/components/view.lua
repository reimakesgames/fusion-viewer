local Selection = game:GetService("Selection")

local Fusion = require(script.Parent.Parent.packages.fusion)
local New = Fusion.New
local State = Fusion.State

local XYTextBox = require(script.Parent:WaitForChild("xytextbox"))
local Button = require(script.Parent:WaitForChild("button"))

local ViewportSize = State(UDim2.fromOffset(1280, 720))
local Selected = State(nil)

local LoadedComponent = State(New "Frame" {
	AnchorPoint = Vector2.new(0, 0);
	Position = UDim2.fromScale(0.5, 0.5)
})

return function(props)
	props.ReloadTree:Connect(function()
		local Props = require(script.Parent.Parent.ReloadProps:Invoke())
		print(Props)
		LoadedComponent:get():Destroy()
		LoadedComponent:set(require(Selected:get())(Props))
	end);

	New "Frame" {
		Parent = props.Parent;

		AnchorPoint = Vector2.new(0, 0);
		Position = UDim2.fromScale(0, 0);

		Size = UDim2.fromScale(1, 1);
		BackgroundColor3 = Color3.fromRGB(32, 32, 32);

		[Fusion.Children] = {
			New "ImageLabel" {
				Size = UDim2.fromScale(1, 1);

				BackgroundColor3 = Color3.fromRGB(32, 32, 32);

				Image = "rbxassetid://9554431864"; --3601030945
				ImageTransparency = 0.9;
			};

			New "Frame" {
				AnchorPoint = Vector2.new(0.5, 0.5);

				Position = UDim2.fromScale(0.5, 0.5);
				Size = ViewportSize;

				BackgroundTransparency = 1;
				[Fusion.Children] = {
					New "Frame" {
						AnchorPoint = Vector2.new(0.5, 0.5);
						Position = UDim2.new(0.5, 0, 0, -1);
						Size = UDim2.new(1, 4, 0, 2)
					};
					New "Frame" {
						AnchorPoint = Vector2.new(0.5, 0.5);
						Position = UDim2.new(0.5, 0, 1, 1);
						Size = UDim2.new(1, 4, 0, 2)
					};
					New "Frame" {
						AnchorPoint = Vector2.new(0.5, 0.5);
						Position = UDim2.new(0, -1, 0.5, 0);
						Size = UDim2.new(0, 2, 1, 4)
					};
					New "Frame" {
						AnchorPoint = Vector2.new(0.5, 0.5);
						Position = UDim2.new(1, 1, 0.5, 0);
						Size = UDim2.new(0, 2, 1, 4)
					};
					LoadedComponent;
				};
			};

			XYTextBox {
				AnchorPoint = Vector2.new(0, 1);

				Position = UDim2.new(0, 32, 1, -8);
				Size = UDim2.new(0, 168, 0, 24);

				SizeChanged = function(NewSize)
					ViewportSize:set(NewSize)
				end
			};

			Button {
				AnchorPoint = Vector2.new(1, 1);

				Position = UDim2.new(1, -32, 1, -8);
				Size = UDim2.new(0, 160, 0, 24);

				Font = Enum.Font.Arial;
				Text = "Select Component";
				TextSize = 16;

				OnActivated = function()
					local CurrentlySelected = Selection:Get()
					print(CurrentlySelected)
					Selected:set(CurrentlySelected[1])
					if Selected:get():IsA("ModuleScript") then
						local Props = require(script.Parent.Parent.ReloadProps:Invoke())
						print(Props)
						LoadedComponent:get():Destroy()
						LoadedComponent:set(require(Selected:get())(Props))
					end
				end
			};

			Button {
				AnchorPoint = Vector2.new(1, 1);

				Position = UDim2.new(1, -200, 1, -8);
				Size = UDim2.new(0, 160, 0, 24);

				Font = Enum.Font.Arial;
				Text = "Change Props";
				TextSize = 16;

				OnActivated = function()
					script.Parent.Parent.OpenScript:Fire();
				end
			}
		}
	}
end

