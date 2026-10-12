#!/bin/bash

# Free Fire Cheat UI All-in-One Installer for macOS
# This script installs the Python-based UI application on macOS

echo "Free Fire Pro Max Plus Ultra All-in-One Installer"
echo "================================================="
echo ""
echo "NOTE: This installer creates a Python-based GUI application."
echo "  If you encounter any issues, you may need to:"
echo "  1. Ensure you have Python 3 installed"
echo "  2. Install tkinter (usually included with Python)"
echo "  3. Ensure Xcode Command Line Tools are installed: xcode-select --install"
echo ""

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This installer is only for macOS."
    exit 1
fi

echo "Checking for required dependencies..."

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Python 3 not found. Installing Python 3 via Homebrew..."
    
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    
    # Install Python 3
    brew install python3
else
    echo "Python 3 already installed."
fi

echo ""
echo "Creating application directory..."
APP_NAME="FreeFireCheatUI"
APP_DIR="$HOME/Applications/$APP_NAME"
mkdir -p "$APP_DIR"

echo "Creating Python GUI application..."

# Create the main Python script
cat > "$APP_DIR/freefire_gui.py" << 'EOF'
import tkinter as tk
from tkinter import ttk, messagebox

class FreeFireCheatUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Free Fire Pro Max Plus Ultra")
        self.root.geometry("800x500")
        self.root.resizable(False, False)
        
        # Configure styles
        self.setup_styles()
        
        # Create main frames
        self.create_widgets()
        
        # Show first tab by default
        self.show_frame("ESP")

    def setup_styles(self):
        self.style = ttk.Style()
        self.style.theme_use('clam')
        
        # Configure custom styles
        self.style.configure('TFrame', background='#2a2a2a')
        self.style.configure('TLabel', background='#2a2a2a', foreground='white')
        self.style.configure('TCheckbutton', background='#2a2a2a', foreground='white')
        self.style.configure('TRadiobutton', background='#2a2a2a', foreground='white')
        self.style.configure('TButton', background='#4a4a4a', foreground='white')
        
        # Custom style for tab buttons
        self.style.configure('Tab.TButton', background='#3a3a3a', foreground='white', 
                            borderwidth=0, padding=(10, 10))
        self.style.map('Tab.TButton', background=[('active', '#5a5a5a'), ('selected', '#1e90ff')])

    def create_widgets(self):
        # Main container
        self.main_frame = ttk.Frame(self.root)
        self.main_frame.pack(fill=tk.BOTH, expand=True)
        
        # Sidebar frame for tabs
        self.sidebar = ttk.Frame(self.main_frame, width=150, relief='raised')
        self.sidebar.pack(side=tk.LEFT, fill=tk.Y)
        self.sidebar.pack_propagate(False)
        
        # Content frame for tab contents
        self.content_frame = ttk.Frame(self.main_frame)
        self.content_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)
        
        # Create navigation tabs
        self.create_tabs()
        
        # Container for tab frames
        self.container = ttk.Frame(self.content_frame)
        self.container.pack(fill=tk.BOTH, expand=True)
        
        # Create frames for each tab
        self.frames = {}
        self.create_tab_frames()

    def create_tabs(self):
        tabs = ["ESP", "Aimbot", "Misc", "Settings"]
        self.tab_buttons = {}
        
        for i, tab_name in enumerate(tabs):
            btn = ttk.Button(
                self.sidebar, 
                text=tab_name,
                style='Tab.TButton',
                command=lambda t=tab_name: self.show_frame(t)
            )
            btn.pack(fill=tk.X, pady=2, padx=5)
            self.tab_buttons[tab_name] = btn

    def create_tab_frames(self):
        # ESP Frame
        esp_frame = ttk.Frame(self.container)
        self.create_esp_content(esp_frame)
        self.frames["ESP"] = esp_frame
        
        # Aimbot Frame
        aimbot_frame = ttk.Frame(self.container)
        self.create_aimbot_content(aimbot_frame)
        self.frames["Aimbot"] = aimbot_frame
        
        # Misc Frame
        misc_frame = ttk.Frame(self.container)
        self.create_misc_content(misc_frame)
        self.frames["Misc"] = misc_frame
        
        # Settings Frame
        settings_frame = ttk.Frame(self.container)
        self.create_settings_content(settings_frame)
        self.frames["Settings"] = settings_frame

    def create_esp_content(self, parent):
        # Player ESP Section
        player_frame = ttk.LabelFrame(parent, text="Player ESP", padding=10)
        player_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(player_frame, text="Box ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(player_frame, text="Line ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(player_frame, text="Name ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(player_frame, text="Distance ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(player_frame, text="Health ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(player_frame, text="Skeleton ESP").pack(anchor=tk.W, pady=2)
        
        # Item ESP Section
        item_frame = ttk.LabelFrame(parent, text="Item ESP", padding=10)
        item_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(item_frame, text="Weapon ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(item_frame, text="Ammo ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(item_frame, text="Medkit ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(item_frame, text="Helmet ESP").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(item_frame, text="Vest ESP").pack(anchor=tk.W, pady=2)

    def create_aimbot_content(self, parent):
        # Aim Settings
        aim_frame = ttk.LabelFrame(parent, text="Aim Settings", padding=10)
        aim_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(aim_frame, text="Enable Aimbot").pack(anchor=tk.W, pady=2)
        
        # Aim Key Selection
        ttk.Label(aim_frame, text="Aim Key:").pack(anchor=tk.W, pady=(10, 2))
        aim_key_var = tk.StringVar(value="Right Mouse")
        aim_key_combo = ttk.Combobox(aim_frame, textvariable=aim_key_var, 
                                    values=["Right Mouse", "Left Mouse", "Shift", "Ctrl"], 
                                    state="readonly", width=15)
        aim_key_combo.pack(anchor=tk.W, pady=2)
        
        # Smoothness Slider
        ttk.Label(aim_frame, text="Smoothness:").pack(anchor=tk.W, pady=(10, 2))
        smooth_slider = ttk.Scale(aim_frame, from_=1, to=20, orient=tk.HORIZONTAL, length=200)
        smooth_slider.set(10)
        smooth_slider.pack(anchor=tk.W, pady=2)
        smooth_label = ttk.Label(aim_frame, text="Value: 10")
        smooth_label.pack(anchor=tk.W, pady=2)
        
        # Update slider label
        smooth_slider.configure(command=lambda x: smooth_label.config(text=f"Value: {int(float(x))}"))
        
        # Aim Position
        ttk.Label(aim_frame, text="Aim Position:").pack(anchor=tk.W, pady=(10, 2))
        position_var = tk.StringVar(value="Head")
        position_combo = ttk.Combobox(aim_frame, textvariable=position_var, 
                                     values=["Head", "Body", "Legs"], 
                                     state="readonly", width=15)
        position_combo.pack(anchor=tk.W, pady=2)
        
        ttk.Checkbutton(aim_frame, text="Auto Fire").pack(anchor=tk.W, pady=(10, 2))
        ttk.Checkbutton(aim_frame, text="Auto Wallbang").pack(anchor=tk.W, pady=2)
        
        # FOV Settings
        fov_frame = ttk.LabelFrame(parent, text="FOV Settings", padding=10)
        fov_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(fov_frame, text="Draw FOV Circle").pack(anchor=tk.W, pady=2)
        
        # FOV Size Slider
        ttk.Label(fov_frame, text="FOV Size:").pack(anchor=tk.W, pady=(10, 2))
        fov_slider = ttk.Scale(fov_frame, from_=10, to=500, orient=tk.HORIZONTAL, length=200)
        fov_slider.set(100)
        fov_slider.pack(anchor=tk.W, pady=2)
        fov_label = ttk.Label(fov_frame, text="Value: 100")
        fov_label.pack(anchor=tk.W, pady=2)
        
        # Update FOV slider label
        fov_slider.configure(command=lambda x: fov_label.config(text=f"Value: {int(float(x))}"))

    def create_misc_content(self, parent):
        # Movement Hacks
        move_frame = ttk.LabelFrame(parent, text="Movement Hacks", padding=10)
        move_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(move_frame, text="Speed Hack").pack(anchor=tk.W, pady=2)
        
        # Speed Value
        ttk.Label(move_frame, text="Speed Value:").pack(anchor=tk.W, pady=(10, 2))
        speed_slider = ttk.Scale(move_frame, from_=1, to=5, orient=tk.HORIZONTAL, length=200)
        speed_slider.set(2)
        speed_slider.pack(anchor=tk.W, pady=2)
        speed_label = ttk.Label(move_frame, text="Value: 2")
        speed_label.pack(anchor=tk.W, pady=2)
        
        # Update speed slider label
        speed_slider.configure(command=lambda x: speed_label.config(text=f"Value: {int(float(x))}"))
        
        ttk.Checkbutton(move_frame, text="No Recoil").pack(anchor=tk.W, pady=(10, 2))
        ttk.Checkbutton(move_frame, text="No Spread").pack(anchor=tk.W, pady=2)
        
        # Visual Hacks
        visual_frame = ttk.LabelFrame(parent, text="Visual Hacks", padding=10)
        visual_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(visual_frame, text="FPS Boost").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(visual_frame, text="No Fog").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(visual_frame, text="Night Mode").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(visual_frame, text="Crosshair").pack(anchor=tk.W, pady=2)
        
        # Gameplay Hacks
        gameplay_frame = ttk.LabelFrame(parent, text="Gameplay Hacks", padding=10)
        gameplay_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(gameplay_frame, text="Instant Medkit").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(gameplay_frame, text="No Reload").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(gameplay_frame, text="Infinite Ammo").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(gameplay_frame, text="Rapid Fire").pack(anchor=tk.W, pady=2)

    def create_settings_content(self, parent):
        # General Settings
        general_frame = ttk.LabelFrame(parent, text="General Settings", padding=10)
        general_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Checkbutton(general_frame, text="Start With Windows").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(general_frame, text="Minimize To Tray").pack(anchor=tk.W, pady=2)
        ttk.Checkbutton(general_frame, text="Anti-Cheat Bypass").pack(anchor=tk.W, pady=2)
        
        # Keybinds
        keybinds_frame = ttk.LabelFrame(parent, text="Keybinds", padding=10)
        keybinds_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Label(keybinds_frame, text="Menu Key: Insert").pack(anchor=tk.W, pady=2)
        ttk.Label(keybinds_frame, text="Panic Key: Delete").pack(anchor=tk.W, pady=2)
        
        # Config Buttons
        config_frame = ttk.LabelFrame(parent, text="Config", padding=10)
        config_frame.pack(fill=tk.X, padx=10, pady=5)
        
        button_frame = ttk.Frame(config_frame)
        button_frame.pack()
        
        ttk.Button(button_frame, text="Save Config", command=self.save_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Load Config", command=self.load_config).pack(side=tk.LEFT, padx=5)
        ttk.Button(button_frame, text="Reset Config", command=self.reset_config).pack(side=tk.LEFT, padx=5)
        
        # About Section
        about_frame = ttk.LabelFrame(parent, text="About", padding=10)
        about_frame.pack(fill=tk.X, padx=10, pady=5)
        
        ttk.Label(about_frame, text="Free Fire Pro Max Plus Ultra v2.0", font=("Arial", 10, "bold")).pack()
        ttk.Label(about_frame, text="For Educational Purposes Only", foreground="gray").pack()

    def save_config(self):
        messagebox.showinfo("Config", "Configuration saved!")

    def load_config(self):
        messagebox.showinfo("Config", "Configuration loaded!")

    def reset_config(self):
        result = messagebox.askyesno("Config", "Reset all settings to default?")
        if result:
            messagebox.showinfo("Config", "Configuration reset!")

    def show_frame(self, frame_name):
        # Hide all frames
        for frame in self.frames.values():
            frame.place_forget()
        
        # Show selected frame
        self.frames[frame_name].place(relwidth=1, relheight=1)
        
        # Update button states
        for name, button in self.tab_buttons.items():
            if name == frame_name:
                button.state(['pressed'])
            else:
                button.state(['!pressed'])

def main():
    root = tk.Tk()
    app = FreeFireCheatUI(root)
    root.mainloop()

if __name__ == "__main__":
    main()
EOF

echo "Creating application bundle structure..."
BUNDLE_DIR="$APP_DIR/FreeFireCheatUI.app"
CONTENTS_DIR="$BUNDLE_DIR/Contents"
MACOS_DIR="$CONTENTS_DIR/MacOS"
RESOURCES_DIR="$CONTENTS_DIR/Resources"

mkdir -p "$MACOS_DIR"
mkdir -p "$RESOURCES_DIR"

echo "Creating Info.plist..."
cat > "$CONTENTS_DIR/Info.plist" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>English</string>
    <key>CFBundleExecutable</key>
    <string>launcher</string>
    <key>CFBundleIconFile</key>
    <string>app.icns</string>
    <key>CFBundleIdentifier</key>
    <string>com.freefire.cheatui</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>Free Fire Cheat UI</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleSignature</key>
    <string>????</string>
    <key>CFBundleVersion</key>
    <string>1.0</string>
    <key>LSMinimumSystemVersion</key>
    <string>10.12</string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
EOF

echo "Creating launcher script..."
cat > "$MACOS_DIR/launcher" << 'EOF'
#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
APP_ROOT="$(dirname "$DIR")"
cd "$APP_ROOT"

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required to run this application."
    echo "Please install Python 3 from https://www.python.org/downloads/"
    osascript -e 'display dialog "Python 3 is required to run this application. Please install Python 3 from https://www.python.org/downloads/" with icon stop'
    exit 1
fi

# Run the application
python3 "./freefire_gui.py"
EOF

chmod +x "$MACOS_DIR/launcher"

echo "Creating run script for terminal execution..."
cat > "$APP_DIR/run.sh" << 'EOF'
#!/bin/bash
cd "$(dirname "$0")"

# Check if Python 3 is installed
if ! command -v python3 &> /dev/null; then
    echo "Error: Python 3 is required to run this application."
    echo "Please install Python 3 from https://www.python.org/downloads/"
    exit 1
fi

echo "Starting Free Fire Pro Max Plus Ultra..."
python3 "./freefire_gui.py"
EOF

chmod +x "$APP_DIR/run.sh"

echo "Creating uninstall script..."
cat > "$APP_DIR/uninstall.sh" << EOF
#!/bin/bash
echo "Uninstalling Free Fire Cheat UI..."
rm -rf "$APP_DIR"
echo "Uninstallation complete."
EOF

chmod +x "$APP_DIR/uninstall.sh"

echo ""
echo "Installation completed!"
echo ""
echo "To run the application, you can either:"
echo "1. Double-click the application in Finder (located at $BUNDLE_DIR)"
echo "2. Open Terminal and navigate to: $APP_DIR"
echo "3. Run: ./run.sh"
echo ""
echo "To uninstall, run: $APP_DIR/uninstall.sh"
echo ""
echo "Note: This is for educational purposes only."
echo "Actual cheat functionality is not implemented."
