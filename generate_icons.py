#!/usr/bin/env python3
"""
生成iOS应用所需的所有图标尺寸
"""
from PIL import Image
import json
import os

# 图标尺寸定义 (文件名: 尺寸)
ICON_SIZES = {
    "AppIcon20x20@2x.png": 40,
    "AppIcon20x20@3x.png": 60,
    "AppIcon29x29@2x.png": 58,
    "AppIcon29x29@3x.png": 87,
    "AppIcon40x40@2x.png": 80,
    "AppIcon40x40@3x.png": 120,
    "AppIcon60x60@2x.png": 120,
    "AppIcon60x60@3x.png": 180,
    "AppIcon76x76@2x.png": 152,
    "AppIcon83.5x83.5@2x.png": 167,
    "AppIcon1024x1024@1x.png": 1024,
}

# Contents.json 结构
CONTENTS_JSON = {
    "images": [
        {"idiom": "iphone", "scale": "2x", "size": "20x20", "filename": "AppIcon20x20@2x.png"},
        {"idiom": "iphone", "scale": "3x", "size": "20x20", "filename": "AppIcon20x20@3x.png"},
        {"idiom": "iphone", "scale": "2x", "size": "29x29", "filename": "AppIcon29x29@2x.png"},
        {"idiom": "iphone", "scale": "3x", "size": "29x29", "filename": "AppIcon29x29@3x.png"},
        {"idiom": "iphone", "scale": "2x", "size": "40x40", "filename": "AppIcon40x40@2x.png"},
        {"idiom": "iphone", "scale": "3x", "size": "40x40", "filename": "AppIcon40x40@3x.png"},
        {"idiom": "iphone", "scale": "2x", "size": "60x60", "filename": "AppIcon60x60@2x.png"},
        {"idiom": "iphone", "scale": "3x", "size": "60x60", "filename": "AppIcon60x60@3x.png"},
        {"idiom": "ipad", "scale": "2x", "size": "76x76", "filename": "AppIcon76x76@2x.png"},
        {"idiom": "ipad", "scale": "2x", "size": "83.5x83.5", "filename": "AppIcon83.5x83.5@2x.png"},
        {"idiom": "ios-marketing", "scale": "1x", "size": "1024x1024", "filename": "AppIcon1024x1024@1x.png"},
    ],
    "info": {
        "author": "xcode",
        "version": 1
    }
}

def generate_icons(source_path, output_dir):
    """生成所有图标尺寸"""
    os.makedirs(output_dir, exist_ok=True)
    
    # 打开原图
    with Image.open(source_path) as img:
        # 确保是RGBA模式
        if img.mode != 'RGBA':
            img = img.convert('RGBA')
        
        # 生成各个尺寸
        for filename, size in ICON_SIZES.items():
            resized = img.resize((size, size), Image.LANCZOS)
            output_path = os.path.join(output_dir, filename)
            resized.save(output_path, 'PNG')
            print(f"Generated: {filename} ({size}x{size})")
    
    # 生成Contents.json
    contents_path = os.path.join(output_dir, 'Contents.json')
    with open(contents_path, 'w', encoding='utf-8') as f:
        json.dump(CONTENTS_JSON, f, indent=2, ensure_ascii=False)
    print(f"Generated: Contents.json")

def generate_accent_color(assets_dir):
    """生成强调色资源"""
    accent_dir = os.path.join(assets_dir, 'AccentColor.colorset')
    os.makedirs(accent_dir, exist_ok=True)
    
    accent_contents = {
        "colors": [
            {
                "color": {
                    "color-space": "srgb",
                    "components": {
                        "alpha": "1.000",
                        "blue": "0.000",
                        "green": "0.000",
                        "red": "0.800"
                    }
                },
                "idiom": "universal"
            }
        ],
        "info": {
            "author": "xcode",
            "version": 1
        }
    }
    
    with open(os.path.join(accent_dir, 'Contents.json'), 'w', encoding='utf-8') as f:
        json.dump(accent_contents, f, indent=2, ensure_ascii=False)
    print("Generated: AccentColor.colorset")

def main():
    base_dir = os.path.dirname(os.path.abspath(__file__))
    source_icon = os.path.join(base_dir, 'TheFreakCircus/Assets.xcassets/AppIcon.appiconset/icon_1024x1024.png')
    appiconset_dir = os.path.join(base_dir, 'TheFreakCircus/Assets.xcassets/AppIcon.appiconset')
    assets_dir = os.path.join(base_dir, 'TheFreakCircus/Assets.xcassets')
    
    # 生成图标
    print("Generating app icons...")
    generate_icons(source_icon, appiconset_dir)
    
    # 生成强调色
    print("\nGenerating accent color...")
    generate_accent_color(assets_dir)
    
    # 生成Assets.xcassets的Contents.json
    assets_contents = {
        "info": {
            "author": "xcode",
            "version": 1
        }
    }
    with open(os.path.join(assets_dir, 'Contents.json'), 'w', encoding='utf-8') as f:
        json.dump(assets_contents, f, indent=2, ensure_ascii=False)
    print("Generated: Assets.xcassets/Contents.json")
    
    print("\nAll assets generated successfully!")

if __name__ == '__main__':
    main()
