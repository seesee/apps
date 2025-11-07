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
- Metadata encoding (filename, size, type) with unique file IDs
- Checksum validation for each chunk
- Sequential playback with configurable speed
- Self-contained (no external dependencies)
- Supports encoding multiple files in sequence

### Decoder
- Extracts QR codes from MP4 video files
- **Multiple video file processing** - process several recordings at once
- **Multiple files per video** - handles several encoded files in one stream
- Automatic deduplication of repeated frames across all videos
- Checksum verification with detailed error reporting
- Metadata extraction and automatic filename application
- Comprehensive progress reporting and statistics
- Missing chunk detection with detailed diagnostics
- Timestamped logging with success/warning/error indicators

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

   Process multiple videos:
   ```bash
   ./setup_and_run.sh video1.mp4 video2.mp4 video3.mp4
   ```

   Specify an output directory:
   ```bash
   ./setup_and_run.sh recording.mp4 -o ./output
   ```

   Enable verbose logging:
   ```bash
   ./setup_and_run.sh recording.mp4 --verbose
   ```

The script will:
- Create a Python virtual environment (first run only)
- Install dependencies (first run only)
- Process all video files and extract QR codes
- Deduplicate QR codes across all videos
- Handle multiple files if encoded in the same video stream
- Reconstruct files with their original filenames automatically
- Provide comprehensive statistics and error reporting

## Data Format

### Metadata QR Code (First Frame for Each File)
```
META:FILE_ID:filename:filesize:filetype:totalchunks:checksum
```

Example:
```
META:a3f2e8d1:document.pdf:1048576:application%2Fpdf:524:a3f2
```

### Data QR Codes
```
DATA:FILE_ID:SEQ:TOTAL:CHECKSUM:PAYLOAD
```

Example:
```
DATA:a3f2e8d1:0:524:b4e1:SGVsbG8gV29ybGQh...
```

Where:
- `FILE_ID`: Unique 8-character hex identifier for this file
- `SEQ`: Chunk sequence number (0-indexed)
- `TOTAL`: Total number of data chunks
- `CHECKSUM`: 4-character hex checksum
- `PAYLOAD`: Base64-encoded file chunk

The FILE_ID allows multiple files to be encoded in the same video stream without confusion. Each file has its own metadata QR code with a unique ID, and all data chunks for that file reference the same ID.

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

# Run decoder (basic usage)
python decode.py recording.mp4

# Process multiple videos
python decode.py video1.mp4 video2.mp4 -o ./output

# Enable verbose logging
python decode.py recording.mp4 --verbose
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
- Process multiple recordings of the same QR sequence - the decoder will automatically deduplicate and use all unique codes found

## Multi-File Support

### Encoding Multiple Files
To encode multiple files in sequence:
1. Encode first file, play sequence, record
2. Stop recording
3. Load second file, generate QR codes, play sequence
4. Continue recording the same video
5. Repeat for additional files

The decoder will automatically detect all files in the video stream and reconstruct each one separately.

### Processing Multiple Videos
If you have multiple recordings of QR code sequences (e.g., recorded from different angles or sessions):
```bash
./setup_and_run.sh recording1.mp4 recording2.mp4 recording3.mp4
```

The decoder will:
- Process all videos
- Deduplicate QR codes across all videos
- Use all unique codes found to maximize completeness
- Reconstruct all detected files

## Troubleshooting

### Decoder Issues

**"No files found in video stream(s)"**
- Ensure the video includes metadata QR codes
- Check if QR codes are being detected at all (look at frames_with_qr in summary)
- Try increasing error correction level when encoding
- Ensure video quality is sufficient for QR code detection

**"Missing X chunks"**
- Some QR codes were not captured in the recording
- The decoder shows which specific chunk indices are missing
- Solutions:
  - Re-record with slower playback speed
  - Record multiple times and process all videos together
  - Check video quality and resolution
  - Ensure QR codes are fully visible in frame

**"Checksum mismatch" warnings**
- QR code was decoded but data appears corrupted
- The decoder will reject chunks with bad checksums
- Try higher error correction when encoding
- Improve recording quality
- Reduce compression in recording settings

**"Data chunk for unknown file ID"**
- Found data chunks but no matching metadata
- Ensure the metadata QR code (first frame) is captured
- Try processing multiple videos together if you have partial recordings

**Multiple files detected but only some reconstruct**
- This is expected if you have incomplete recordings
- Check the summary to see which files are complete
- The decoder will reconstruct all complete files

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

# Process single or multiple videos
decoder = QRDecoder(['video.mp4'], output_dir='./output', verbose=True)
decoder.decode()

# Access decoded file streams
for file_id, file_stream in decoder.file_streams.items():
    metadata = file_stream.metadata
    print(f"File: {metadata['filename']}")
    print(f"Chunks: {len(file_stream.data_chunks)}/{metadata['total_chunks']}")
    print(f"Complete: {file_stream.is_complete()}")
```

### Batch Processing

Process all videos in a directory:

```bash
./setup_and_run.sh *.mp4 -o ./output
```

Or with more control:

```bash
for video in recordings/*.mp4; do
    echo "Processing: $video"
    ./setup_and_run.sh "$video" -o "./output/$(basename "$video" .mp4)"
done
```

## Contributing

Feel free to submit issues and enhancement requests!

## Changelog

### Version 1.1 (Current)
- **Multi-file support**: Process multiple videos and multiple files per video
- **File ID system**: Unique identifiers to disambiguate files in same stream
- **Enhanced decoder**: Comprehensive error reporting with timestamps and levels
- **Improved statistics**: Detailed summary with per-file status
- **Better CLI**: Support for multiple video inputs and output directory
- **Verbose mode**: Optional detailed logging for debugging
- **Auto-naming**: Files automatically use their encoded filename

### Version 1.0
- Initial release
- HTML encoder with drag & drop
- Python decoder with OpenCV
- Metadata support
- Checksum verification
- Automatic deduplication
