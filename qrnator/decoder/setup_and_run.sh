#!/bin/bash

# QRnator Decoder - Setup and Run Script
# This script creates a virtual environment, installs dependencies, and runs the decoder

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/venv"
PYTHON_SCRIPT="$SCRIPT_DIR/decode.py"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}======================================${NC}"
echo -e "${BLUE}QRnator Decoder - Setup & Run${NC}"
echo -e "${BLUE}======================================${NC}"
echo ""

# Check if Python 3 is available
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Error: Python 3 is not installed${NC}"
    echo "Please install Python 3.8 or higher"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
echo -e "${GREEN}✓ Found Python ${PYTHON_VERSION}${NC}"

# Create virtual environment if it doesn't exist
if [ ! -d "$VENV_DIR" ]; then
    echo -e "${YELLOW}Creating virtual environment...${NC}"
    python3 -m venv "$VENV_DIR"
    echo -e "${GREEN}✓ Virtual environment created${NC}"
else
    echo -e "${GREEN}✓ Virtual environment already exists${NC}"
fi

# Activate virtual environment
source "$VENV_DIR/bin/activate"
echo -e "${GREEN}✓ Virtual environment activated${NC}"

# Check if we need to install/upgrade dependencies
NEED_INSTALL=false
if [ ! -f "$VENV_DIR/.installed" ]; then
    NEED_INSTALL=true
else
    # Check if requirements.txt has been modified
    if [ "$SCRIPT_DIR/requirements.txt" -nt "$VENV_DIR/.installed" ]; then
        NEED_INSTALL=true
    fi
fi

if [ "$NEED_INSTALL" = true ]; then
    echo -e "${YELLOW}Installing dependencies...${NC}"
    pip install --upgrade pip > /dev/null 2>&1
    pip install -r "$SCRIPT_DIR/requirements.txt"
    touch "$VENV_DIR/.installed"
    echo -e "${GREEN}✓ Dependencies installed${NC}"
else
    echo -e "${GREEN}✓ Dependencies already installed${NC}"
fi

echo ""
echo -e "${BLUE}======================================${NC}"
echo ""

# Check if video file argument is provided
if [ $# -eq 0 ]; then
    echo -e "${YELLOW}Usage:${NC}"
    echo "  $0 <video_file.mp4> [output_directory]"
    echo ""
    echo -e "${YELLOW}Example:${NC}"
    echo "  $0 recording.mp4"
    echo "  $0 recording.mp4 ./output"
    echo ""
    echo -e "${YELLOW}Running decoder help:${NC}"
    echo ""
    python3 "$PYTHON_SCRIPT"
    exit 0
fi

# Run the decoder
echo -e "${GREEN}Running decoder...${NC}"
echo ""
python3 "$PYTHON_SCRIPT" "$@"

EXIT_CODE=$?

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ Decode completed successfully!${NC}"
else
    echo -e "${RED}✗ Decode failed with exit code $EXIT_CODE${NC}"
fi

# Deactivate virtual environment
deactivate

exit $EXIT_CODE
