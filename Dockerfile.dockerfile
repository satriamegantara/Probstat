FROM python:3.9-slim

WORKDIR /app

# 1. Install dependensi sistem penting
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    python3-venv \  # Pastikan modul venv tersedia
    && rm -rf /var/lib/apt/lists/*

# 2. Copy requirements terlebih dahulu untuk caching
COPY requirements.txt .

# 3. Install dependencies tanpa virtual env (tidak perlu di Docker)
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# 4. Copy seluruh kode aplikasi
COPY . .

# 5. Set environment variable jika menggunakan Flask
ENV FLASK_APP=app.py

# 6. Command untuk menjalankan aplikasi
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "app:app"]
