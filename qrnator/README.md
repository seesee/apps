# QRnator

A complete solution for encoding files into sequential QR codes and decoding them from video recordings.

## Overview

QRnator consists of two components:

1. **Encoder** (HTML/JavaScript) - A web-based application that encodes any file into a series of QR codes with metadata and checksums
2. **Decoder** (Python) - A command-line tool that extracts QR codes from video recordings and reconstructs the original file

## Features

### Encoder
- Drag & drop file interface
- Base64 encoding with configurable chunk sizes
- QR code generation with error correction
- Metadata encoding (filename, size, type)
- Checksum validation for each chunk
- Sequential playback with configurable speed
- Self-contained (no external dependencies)

### Decoder
- Extracts QR codes from MP4 video files
- Automatic deduplication of repeated frames
- Checksum verification
- Metadata extraction and application
- Progress reporting
- Missing chunk detection

## Quick Start

### Encoding a File

1. Open `index.html` in a web browser
2. Drag and drop a file onto the drop zone
3. Configure settings:
   - **QR Code Size**: Display size (200-500px)
   - **Error Correction**: L (7%), M (15%), Q (25%), H (30%)
   - **Chunk Size**: Data per QR code (100-2000 bytes)
   - **Playback Speed**: Display interval (0.5-5 seconds)
4. Click "Generate QR Codes"
5. Click "Play Sequence" to start playback
6. Record the screen using screen capture software

**Recommended Settings:**
- For small files (<100KB): Chunk size 1000, Error correction M
- For larger files: Chunk size 500, Error correction Q or H
- For screen recording: Playback speed 2-3 seconds

### Decoding from Video

1. Navigate to the decoder directory:
   ```bash
   cd decoder/
   ```

2. Run the setup and decode script:
   ```bash
   ./setup_and_run.sh recording.mp4
   ```

   Or specify an output directory:
   ```bash
   ./setup_and_run.sh recording.mp4 ./output
   ```

The script will:
- Create a Python virtual environment (first run only)
- Install dependencies (first run only)
- Process the video and extract QR codes
- Reconstruct the original file with correct filename

## Data Format

### Metadata QR Code (First Frame)
```
META:filename:filesize:filetype:totalchunks:checksum
```

Example:
```
META:document.pdf:1048576:application%2Fpdf:524:a3f2
```

### Data QR Codes
```
DATA:SEQ:TOTAL:CHECKSUM:PAYLOAD
```

Example:
```
DATA:0:524:b4e1:SGVsbG8gV29ybGQh...
```

Where:
- `SEQ`: Chunk sequence number (0-indexed)
- `TOTAL`: Total number of data chunks
- `CHECKSUM`: 4-character hex checksum
- `PAYLOAD`: Base64-encoded file chunk

## Manual Decoder Setup

If you prefer to set up the decoder manually:

```bash
cd decoder/

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate  # Linux/Mac
# or
venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt

# Run decoder
python decode.py recording.mp4
```

## Dependencies

### Encoder
- Modern web browser with HTML5 support
- No external libraries required

### Decoder
- Python 3.8 or higher
- OpenCV (opencv-python)
- NumPy

## Tips for Best Results

### Recording
- Use a high-resolution screen recording (1080p or higher)
- Ensure the QR code is clearly visible and not obstructed
- Avoid compression artifacts by using high-quality recording settings
- Record at the native playback speed (don't speed up video)

### Encoding
- Use higher error correction (Q or H) for noisy recordings
- Smaller chunk sizes are more reliable but produce more QR codes
- Test with a small file first to verify your workflow

### Decoding
- Ensure good lighting and contrast in the recording
- Keep the camera/recording stable
- If chunks are missing, try re-recording with slower playback speed

## Troubleshooting

### Decoder Issues

**"No metadata found"**
- Ensure the video includes the first frame with metadata
- Check if QR codes are being detected at all
- Try increasing error correction level when encoding

**"Missing chunks"**
- Some frames may not have been captured properly
- Re-record with slower playback speed
- Check video quality and resolution

**"Checksum mismatch"**
- QR code was decoded incorrectly
- Try higher error correction when encoding
- Improve recording quality

### Encoder Issues

**"QR code generation error"**
- Chunk size may be too large for the QR code capacity
- Reduce chunk size in settings
- Increase error correction level

## License

This project is provided as-is for educational and personal use.

## Architecture

### Encoder Flow
```
File → Base64 → Split into chunks → Add metadata/checksums → Generate QR codes → Display sequentially
```

### Decoder Flow
```
Video → Extract frames → Detect QR codes → Deduplicate → Parse metadata → Verify checksums → Reassemble → Write file
```

## Advanced Usage

### Custom Chunk Processing

The decoder can be imported as a module:

```python
from decode import QRDecoder

decoder = QRDecoder('video.mp4', output_dir='./output')
decoder.decode()

# Access decoded data
print(f"Metadata: {decoder.metadata}")
print(f"Chunks found: {len(decoder.data_chunks)}")
```

### Batch Processing

Process multiple videos:

```bash
for video in *.mp4; do
    ./setup_and_run.sh "$video" ./output
done
```

## Contributing

Feel free to submit issues and enhancement requests!

## Changelog

### Version 1.0
- Initial release
- HTML encoder with drag & drop
- Python decoder with OpenCV
- Metadata support
- Checksum verification
- Automatic deduplication
