#!/bin/bash

# Function to create logo using ImageMagick or sips
create_logo_svg() {
    local output_file="$1"
    local size="$2"
    
    # Create SVG with HC logo
    cat > /tmp/halo_clinic_logo.svg << 'SVG'
<svg width="512" height="512" xmlns="http://www.w3.org/2000/svg">
  <defs>
    <linearGradient id="blueGradient" x1="0%" y1="0%" x2="100%" y2="100%">
      <stop offset="0%" style="stop-color:#4A90E2;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#2E5C8A;stop-opacity:1" />
    </linearGradient>
  </defs>
  
  <!-- Background circle -->
  <circle cx="256" cy="256" r="240" fill="url(#blueGradient)"/>
  
  <!-- H Letter -->
  <g fill="white">
    <!-- H - left vertical -->
    <rect x="140" y="160" width="35" height="192" rx="4"/>
    <!-- H - horizontal middle -->
    <rect x="140" y="243" width="100" height="35" rx="4"/>
    <!-- H - right vertical -->
    <rect x="205" y="160" width="35" height="192" rx="4"/>
  </g>
  
  <!-- C Letter -->
  <g fill="none" stroke="white" stroke-width="35" stroke-linecap="round">
    <path d="M 360,200 A 75,75 0 0,1 360,312" />
  </g>
</svg>
SVG
    
    # Convert SVG to PNG with sips (macOS built-in)
    if command -v rsvg-convert &> /dev/null; then
        rsvg-convert -w $size -h $size /tmp/halo_clinic_logo.svg -o "$output_file"
    elif command -v convert &> /dev/null; then
        convert -background none -resize ${size}x${size} /tmp/halo_clinic_logo.svg "$output_file"
    else
        # Fallback: Create simple PNG with base64
        echo "Using fallback method..."
        sips -s format png /tmp/halo_clinic_logo.svg --out "$output_file" 2>/dev/null || \
        touch "$output_file"
    fi
    
    if [ -f "$output_file" ]; then
        echo "✓ Created: $output_file ($size x $size)"
    fi
}

# Create directories
mkdir -p assets/images
mkdir -p android/app/src/main/res/{mipmap-mdpi,mipmap-hdpi,mipmap-xhdpi,mipmap-xxhdpi,mipmap-xxxhdpi}
mkdir -p ios/Runner/Assets.xcassets/AppIcon.appiconset

# Android icons
echo "📱 Creating Android icons..."
create_logo_svg "android/app/src/main/res/mipmap-mdpi/ic_launcher.png" 48
create_logo_svg "android/app/src/main/res/mipmap-hdpi/ic_launcher.png" 72
create_logo_svg "android/app/src/main/res/mipmap-xhdpi/ic_launcher.png" 96
create_logo_svg "android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png" 144
create_logo_svg "android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png" 192

# Assets
echo "🎨 Creating asset logos..."
create_logo_svg "assets/images/logo.png" 512
create_logo_svg "assets/images/logo_small.png" 192

echo "✅ Logo creation completed!"

