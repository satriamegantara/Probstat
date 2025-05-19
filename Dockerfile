# Dockerfile untuk Aplikasi Flask di Railway
# Base image Python 3.9 dengan Debian slim
FROM python:3.9-slim

# Set working directory di container
WORKDIR /app

# Install dependensi sistem yang diperlukan
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    libpq-dev \  # Untuk dukungan PostgreSQL (jika diperlukan)
    && rm -rf /var/lib/apt/lists/*

# Install dan update pip
RUN python -m pip install --upgrade pip

# Copy requirements.txt terlebih dahulu untuk caching
COPY requirements.txt .

# Install dependencies Python
RUN pip install --no-cache-dir -r requirements.txt

# Copy seluruh kode aplikasi
COPY . .

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production  # Untuk environment production

# Expose port yang digunakan (Railway akan handle ini via $PORT)
EXPOSE 5000

# Command untuk menjalankan aplikasi dengan Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:$PORT", "app:app"]
